using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TokenVector.Plot.Charts.Base;
using TokenVector.Plot.Core;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Charts.Statistical;

public enum BinningStrategy
{
    FreedmanDiaconis,
    Sturges,
    Scott,
    FixedCount
}

/// <summary>
/// Bar Chart &amp; Scientific Histogram with automatic Freedman-Diaconis / Scott binning
/// and probability density normalization.
/// </summary>
public sealed class BarHistogramPlot : IPlotElement
{
    private readonly float[] _binEdges;
    private readonly float[] _values;
    private readonly float _barWidthRatio;

    public string? Label { get; set; }
    public bool Visible { get; set; } = true;
    public Color PrimaryColor => FillColor;
    public Color FillColor { get; set; } = Color.FromHex("#0C5DA5");
    public Color BorderColor { get; set; } = Color.FromHex("#003C71");
    public float BorderWidth { get; set; } = 1.0f;
    public bool IsHorizontal { get; set; } = false;

    public BarHistogramPlot(ReadOnlySpan<float> categories, ReadOnlySpan<float> values, float barWidthRatio = 0.8f)
    {
        int count = Math.Min(categories.Length, values.Length);
        if (count == 0) throw new ArgumentException("Bar plot data cannot be empty.");

        _values = values[..count].ToArray();
        _barWidthRatio = Math.Clamp(barWidthRatio, 0.1f, 1.0f);

        _binEdges = new float[count + 1];
        for (int i = 0; i < count; i++)
        {
            _binEdges[i] = categories[i] - 0.5f;
        }
        _binEdges[count] = categories[count - 1] + 0.5f;
    }

    public static BarHistogramPlot FromRawData(
        ReadOnlySpan<float> rawData,
        BinningStrategy strategy = BinningStrategy.FreedmanDiaconis,
        int fixedBins = 20,
        bool normalizeDensity = false)
    {
        if (rawData.IsEmpty) throw new ArgumentException("Input raw data cannot be empty.");

        float[] sorted = rawData.ToArray();
        Array.Sort(sorted);
        int n = sorted.Length;
        float min = sorted[0];
        float max = sorted[^1];

        if (MathF.Abs(max - min) < 1e-6f) max = min + 1.0f;

        int numBins;
        switch (strategy)
        {
            case BinningStrategy.FreedmanDiaconis:
                {
                    float q25 = sorted[(int)(n * 0.25f)];
                    float q75 = sorted[(int)(n * 0.75f)];
                    float iqr = q75 - q25;
                    float h = (2.0f * iqr) / MathF.Pow(n, 1.0f / 3.0f);
                    numBins = h > 1e-6f ? (int)MathF.Ceiling((max - min) / h) : 15;
                    numBins = Math.Clamp(numBins, 5, 200);
                    break;
                }
            case BinningStrategy.Sturges:
                numBins = Math.Clamp((int)MathF.Ceiling(1.0f + MathF.Log2(n)), 5, 100);
                break;
            case BinningStrategy.Scott:
                {
                    float sum = 0, sumSq = 0;
                    for (int i = 0; i < n; i++) { sum += sorted[i]; sumSq += sorted[i] * sorted[i]; }
                    float mean = sum / n;
                    float std = MathF.Sqrt(MathF.Max(0, (sumSq / n) - (mean * mean)));
                    float h = (3.49f * std) / MathF.Pow(n, 1.0f / 3.0f);
                    numBins = h > 1e-6f ? (int)MathF.Ceiling((max - min) / h) : 15;
                    numBins = Math.Clamp(numBins, 5, 200);
                    break;
                }
            case BinningStrategy.FixedCount:
            default:
                numBins = Math.Clamp(fixedBins, 2, 500);
                break;
        }

        float binWidth = (max - min) / numBins;
        float[] edges = new float[numBins + 1];
        float[] counts = new float[numBins];

        for (int i = 0; i <= numBins; i++)
        {
            edges[i] = min + i * binWidth;
        }

        for (int i = 0; i < n; i++)
        {
            float v = sorted[i];
            int bIdx = (int)((v - min) / binWidth);
            if (bIdx >= numBins) bIdx = numBins - 1;
            counts[bIdx]++;
        }

        if (normalizeDensity)
        {
            for (int i = 0; i < numBins; i++)
            {
                counts[i] /= (n * binWidth);
            }
        }

        return new BarHistogramPlot(edges, counts);
    }

    private BarHistogramPlot(float[] binEdges, float[] counts)
    {
        _binEdges = binEdges;
        _values = counts;
        _barWidthRatio = 0.95f;
    }

    public void GetBounds(out double xMin, out double xMax, out double yMin, out double yMax)
    {
        xMin = _binEdges[0];
        xMax = _binEdges[^1];
        yMin = 0.0;

        float maxV = float.MinValue;
        for (int i = 0; i < _values.Length; i++)
        {
            if (_values[i] > maxV) maxV = _values[i];
        }
        yMax = maxV * 1.15;
    }

    public void Render(SvgRenderer svg, CoordinateTransform tx, CoordinateTransform ty)
    {
        int numBars = _values.Length;
        for (int i = 0; i < numBars; i++)
        {
            float e0 = _binEdges[i];
            float e1 = _binEdges[i + 1];
            float v = _values[i];

            float x0 = tx.ToTarget(e0);
            float x1 = tx.ToTarget(e1);
            float fullWidth = MathF.Abs(x1 - x0);
            float barW = fullWidth * _barWidthRatio;
            float margin = (fullWidth - barW) * 0.5f;

            float px = MathF.Min(x0, x1) + margin;
            float py0 = ty.ToTarget(0.0);
            float py1 = ty.ToTarget(v);

            float yTop = MathF.Min(py0, py1);
            float barH = MathF.Abs(py1 - py0);

            svg.DrawRect(px, yTop, barW, barH, FillColor, BorderColor, BorderWidth);
        }
    }

    public void Render(RasterRenderer raster, CoordinateTransform tx, CoordinateTransform ty)
    {
        int numBars = _values.Length;
        for (int i = 0; i < numBars; i++)
        {
            float e0 = _binEdges[i];
            float e1 = _binEdges[i + 1];
            float v = _values[i];

            float x0 = tx.ToTarget(e0);
            float x1 = tx.ToTarget(e1);
            float fullWidth = MathF.Abs(x1 - x0);
            float barW = fullWidth * _barWidthRatio;
            float margin = (fullWidth - barW) * 0.5f;

            float px = MathF.Min(x0, x1) + margin;
            float py0 = ty.ToTarget(0.0);
            float py1 = ty.ToTarget(v);

            float yTop = MathF.Min(py0, py1);
            float barH = MathF.Abs(py1 - py0);

            raster.FillRect(px, yTop, barW, barH, FillColor);
            if (BorderWidth > 0 && BorderColor.A > 0)
            {
                raster.DrawRect(px, yTop, barW, barH, BorderColor, BorderWidth);
            }
        }
    }

    public void RenderWebGL(StringBuilder sb, CoordinateTransform tx, CoordinateTransform ty)
    {
    }
}
