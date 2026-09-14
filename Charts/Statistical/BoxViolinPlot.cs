using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TokenVector.Plot.Charts.Base;
using TokenVector.Plot.Core;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Charts.Statistical;

public enum BoxPlotDisplayMode
{
    BoxOnly,
    ViolinOnly,
    Combined
}

/// <summary>
/// Statistical Box-and-Whisker Plot &amp; Gaussian KDE Density Violin Plot.
/// Computes 5-number summary (Min, Q1, Median, Q3, Max), IQR, Outliers, and continuous density envelope.
/// </summary>
public sealed class BoxViolinPlot : IPlotElement
{
    public struct BoxGroup
    {
        public float Position;
        public float Median;
        public float Q1;
        public float Q3;
        public float WhiskerLower;
        public float WhiskerUpper;
        public float[] Outliers;
        public float[] KdeY;
        public float[] KdeDensity;
        public string? Name;
    }

    private readonly List<BoxGroup> _groups = new();
    public IReadOnlyList<BoxGroup> Groups => _groups;

    public string? Label { get; set; }
    public bool Visible { get; set; } = true;
    public Color PrimaryColor => BoxColor;
    public Color BoxColor { get; set; } = Color.FromHex("#0C5DA5");
    public Color MedianColor { get; set; } = Color.FromHex("#FF2C00");
    public Color ViolinColor { get; set; } = Color.FromRgba(12, 93, 165, 100);
    public BoxPlotDisplayMode DisplayMode { get; set; } = BoxPlotDisplayMode.Combined;
    public float BoxWidth { get; set; } = 0.4f;

    public void AddGroup(float position, ReadOnlySpan<float> data, string? name = null)
    {
        if (data.IsEmpty) return;

        float[] sorted = data.ToArray();
        Array.Sort(sorted);
        int n = sorted.Length;

        float median = ComputePercentile(sorted, 0.50f);
        float q1 = ComputePercentile(sorted, 0.25f);
        float q3 = ComputePercentile(sorted, 0.75f);
        float iqr = q3 - q1;

        float lowerBound = q1 - 1.5f * iqr;
        float upperBound = q3 + 1.5f * iqr;

        float whiskerLower = sorted[0];
        float whiskerUpper = sorted[^1];

        var outliers = new List<float>();
        for (int i = 0; i < n; i++)
        {
            float v = sorted[i];
            if (v < lowerBound || v > upperBound)
            {
                outliers.Add(v);
            }
            else
            {
                if (v >= lowerBound && whiskerLower < lowerBound) whiskerLower = v;
                if (v <= upperBound) whiskerUpper = v;
            }
        }

        // Gaussian KDE for Violin
        int kdeSamples = 40;
        float[] kdeY = new float[kdeSamples];
        float[] kdeDensity = new float[kdeSamples];
        float yMin = sorted[0];
        float yMax = sorted[^1];
        float dy = (yMax - yMin) / (kdeSamples - 1);

        float sum = 0, sumSq = 0;
        for (int i = 0; i < n; i++) { sum += sorted[i]; sumSq += sorted[i] * sorted[i]; }
        float mean = sum / n;
        float std = MathF.Sqrt(MathF.Max(1e-5f, (sumSq / n) - (mean * mean)));
        float bandwidth = 1.06f * std * MathF.Pow(n, -0.2f);
        if (bandwidth < 1e-4f) bandwidth = 0.1f;

        float maxDensity = 0f;
        for (int i = 0; i < kdeSamples; i++)
        {
            float y = yMin + i * dy;
            kdeY[i] = y;
            float d = 0f;
            for (int k = 0; k < n; k++)
            {
                float u = (y - sorted[k]) / bandwidth;
                d += MathF.Exp(-0.5f * u * u);
            }
            d /= (n * bandwidth * MathF.Sqrt(2 * MathF.PI));
            kdeDensity[i] = d;
            if (d > maxDensity) maxDensity = d;
        }

        // Normalize KDE density width to 0.4 box units
        if (maxDensity > 1e-6f)
        {
            for (int i = 0; i < kdeSamples; i++)
            {
                kdeDensity[i] = (kdeDensity[i] / maxDensity) * (BoxWidth * 0.9f);
            }
        }

        _groups.Add(new BoxGroup
        {
            Position = position,
            Median = median,
            Q1 = q1,
            Q3 = q3,
            WhiskerLower = whiskerLower,
            WhiskerUpper = whiskerUpper,
            Outliers = outliers.ToArray(),
            KdeY = kdeY,
            KdeDensity = kdeDensity,
            Name = name
        });
    }

    private static float ComputePercentile(float[] sorted, float p)
    {
        float idx = p * (sorted.Length - 1);
        int lower = (int)idx;
        int upper = Math.Min(sorted.Length - 1, lower + 1);
        float weight = idx - lower;
        return sorted[lower] * (1.0f - weight) + sorted[upper] * weight;
    }

    public void GetBounds(out double xMin, out double xMax, out double yMin, out double yMax)
    {
        if (_groups.Count == 0)
        {
            xMin = 0; xMax = 1; yMin = 0; yMax = 1;
            return;
        }

        xMin = _groups[0].Position - 0.8;
        xMax = _groups[^1].Position + 0.8;
        yMin = double.MaxValue;
        yMax = double.MinValue;

        foreach (var g in _groups)
        {
            if (g.WhiskerLower < yMin) yMin = g.WhiskerLower;
            if (g.WhiskerUpper > yMax) yMax = g.WhiskerUpper;
            foreach (var o in g.Outliers)
            {
                if (o < yMin) yMin = o;
                if (o > yMax) yMax = o;
            }
        }

        double yMargin = (yMax - yMin) * 0.1;
        yMin -= yMargin;
        yMax += yMargin;
    }

    public void Render(SvgRenderer svg, CoordinateTransform tx, CoordinateTransform ty)
    {
        float[] vx = Array.Empty<float>();
        float[] vy = Array.Empty<float>();

        foreach (var g in _groups)
        {
            float cx = tx.ToTarget(g.Position);

            // 1. Render Violin (if enabled)
            if (DisplayMode != BoxPlotDisplayMode.BoxOnly && g.KdeY != null && g.KdeY.Length > 0)
            {
                int kCount = g.KdeY.Length;
                int totalPts = kCount * 2;
                if (vx == null || vx.Length < totalPts)
                {
                    vx = new float[totalPts];
                    vy = new float[totalPts];
                }

                for (int i = 0; i < kCount; i++)
                {
                    vx[i] = tx.ToTarget(g.Position + g.KdeDensity[i] * 0.5f);
                    vy[i] = ty.ToTarget(g.KdeY[i]);
                }
                for (int i = 0; i < kCount; i++)
                {
                    int rIdx = kCount + i;
                    int src = kCount - 1 - i;
                    vx[rIdx] = tx.ToTarget(g.Position - g.KdeDensity[src] * 0.5f);
                    vy[rIdx] = ty.ToTarget(g.KdeY[src]);
                }
                svg.DrawPolygon(vx.AsSpan(0, totalPts), vy.AsSpan(0, totalPts), ViolinColor, Color.Transparent, 0f);
            }

            // 2. Render Box (if enabled)
            if (DisplayMode != BoxPlotDisplayMode.ViolinOnly)
            {
                float xL = tx.ToTarget(g.Position - BoxWidth * 0.5f);
                float xR = tx.ToTarget(g.Position + BoxWidth * 0.5f);
                float w = MathF.Abs(xR - xL);

                float yQ1 = ty.ToTarget(g.Q1);
                float yQ3 = ty.ToTarget(g.Q3);
                float yTop = MathF.Min(yQ1, yQ3);
                float h = MathF.Abs(yQ3 - yQ1);

                float yMed = ty.ToTarget(g.Median);
                float yWLow = ty.ToTarget(g.WhiskerLower);
                float yWHigh = ty.ToTarget(g.WhiskerUpper);

                // Whisker vertical stems
                svg.DrawLine(cx, yQ1, cx, yWLow, Color.Black, 1.2f);
                svg.DrawLine(cx, yQ3, cx, yWHigh, Color.Black, 1.2f);

                // Whisker caps
                float capW = w * 0.4f;
                svg.DrawLine(cx - capW * 0.5f, yWLow, cx + capW * 0.5f, yWLow, Color.Black, 1.2f);
                svg.DrawLine(cx - capW * 0.5f, yWHigh, cx + capW * 0.5f, yWHigh, Color.Black, 1.2f);

                // Box
                svg.DrawRect(cx - w * 0.5f, yTop, w, h, BoxColor, Color.Black, 1.2f);

                // Median line
                svg.DrawLine(cx - w * 0.5f, yMed, cx + w * 0.5f, yMed, MedianColor, 2.0f);

                // Outliers
                foreach (var o in g.Outliers)
                {
                    float yo = ty.ToTarget(o);
                    svg.DrawCircle(cx, yo, 3.0f, Color.Transparent, MedianColor, 1.0f);
                }
            }
        }
    }

    public void Render(RasterRenderer raster, CoordinateTransform tx, CoordinateTransform ty)
    {
        foreach (var g in _groups)
        {
            float cx = tx.ToTarget(g.Position);

            if (DisplayMode != BoxPlotDisplayMode.ViolinOnly)
            {
                float xL = tx.ToTarget(g.Position - BoxWidth * 0.5f);
                float xR = tx.ToTarget(g.Position + BoxWidth * 0.5f);
                float w = MathF.Abs(xR - xL);

                float yQ1 = ty.ToTarget(g.Q1);
                float yQ3 = ty.ToTarget(g.Q3);
                float yTop = MathF.Min(yQ1, yQ3);
                float h = MathF.Abs(yQ3 - yQ1);

                float yMed = ty.ToTarget(g.Median);
                float yWLow = ty.ToTarget(g.WhiskerLower);
                float yWHigh = ty.ToTarget(g.WhiskerUpper);

                raster.DrawLine(cx, yQ1, cx, yWLow, Color.Black, 1.2f);
                raster.DrawLine(cx, yQ3, cx, yWHigh, Color.Black, 1.2f);

                float capW = w * 0.4f;
                raster.DrawLine(cx - capW * 0.5f, yWLow, cx + capW * 0.5f, yWLow, Color.Black, 1.2f);
                raster.DrawLine(cx - capW * 0.5f, yWHigh, cx + capW * 0.5f, yWHigh, Color.Black, 1.2f);

                raster.FillRect(cx - w * 0.5f, yTop, w, h, BoxColor);
                raster.DrawRect(cx - w * 0.5f, yTop, w, h, Color.Black, 1.2f);
                raster.DrawLine(cx - w * 0.5f, yMed, cx + w * 0.5f, yMed, MedianColor, 2.0f);

                foreach (var o in g.Outliers)
                {
                    float yo = ty.ToTarget(o);
                    raster.FillCircle(cx, yo, 2.5f, MedianColor);
                }
            }
        }
    }

    public void RenderWebGL(StringBuilder sb, CoordinateTransform tx, CoordinateTransform ty)
    {
    }
}
