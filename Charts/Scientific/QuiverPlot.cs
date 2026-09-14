using System;
using System.Buffers;
using System.Globalization;
using System.Numerics;
using System.Runtime.Intrinsics;
using System.Runtime.Intrinsics.X86;
using System.Text;
using TokenVector.Plot.Charts.Base;
using TokenVector.Plot.Core;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Charts.Scientific;

/// <summary>
/// 2D Vector Field (Quiver) Plot with SIMD AVX2 accelerated magnitude evaluation,
/// automatic arrow scaling, and ColorMap gradient coloring.
/// </summary>
public sealed class QuiverPlot : IPlotElement
{
    private readonly float[] _x;
    private readonly float[] _y;
    private readonly float[] _u;
    private readonly float[] _v;
    private readonly float[] _magnitudes;
    private readonly float _minMag;
    private readonly float _maxMag;

    public string? Label { get; set; }
    public bool Visible { get; set; } = true;
    public Color PrimaryColor => Color;
    public Color Color { get; set; } = Color.Blue;
    public ColorMap? ColorMap { get; set; }
    public float Scale { get; set; } = 1.0f;
    public float ArrowHeadSize { get; set; } = 4.0f;
    public float LineWidth { get; set; } = 1.2f;

    public QuiverPlot(ReadOnlySpan<float> x, ReadOnlySpan<float> y, ReadOnlySpan<float> u, ReadOnlySpan<float> v, ColorMap? colorMap = null)
    {
        int count = Math.Min(Math.Min(x.Length, y.Length), Math.Min(u.Length, v.Length));
        if (count == 0) throw new ArgumentException("Vector field arrays cannot be empty.");

        _x = x[..count].ToArray();
        _y = y[..count].ToArray();
        _u = u[..count].ToArray();
        _v = v[..count].ToArray();
        _magnitudes = new float[count];
        ColorMap = colorMap;

        // Compute Magnitudes using SIMD AVX2
        ComputeMagnitudesSimd(_u, _v, _magnitudes, out _minMag, out _maxMag);
    }

    private static unsafe void ComputeMagnitudesSimd(float[] u, float[] v, float[] mag, out float minMag, out float maxMag)
    {
        int length = u.Length;
        float min = float.MaxValue;
        float max = float.MinValue;

        fixed (float* pU = u)
        fixed (float* pV = v)
        fixed (float* pMag = mag)
        {
            int i = 0;
            if (Avx.IsSupported && length >= 8)
            {
                for (; i <= length - 8; i += 8)
                {
                    var vu = Avx.LoadVector256(pU + i);
                    var vv = Avx.LoadVector256(pV + i);
                    var u2 = Avx.Multiply(vu, vu);
                    var v2 = Avx.Multiply(vv, vv);
                    var sum = Avx.Add(u2, v2);
                    var vmag = Avx.Sqrt(sum);
                    Avx.Store(pMag + i, vmag);
                }
            }

            for (; i < length; i++)
            {
                pMag[i] = MathF.Sqrt(pU[i] * pU[i] + pV[i] * pV[i]);
            }

            for (int k = 0; k < length; k++)
            {
                if (pMag[k] < min) min = pMag[k];
                if (pMag[k] > max) max = pMag[k];
            }
        }

        minMag = min;
        maxMag = max <= min ? min + 1e-5f : max;
    }

    public void GetBounds(out double xMin, out double xMax, out double yMin, out double yMax)
    {
        xMin = double.MaxValue; xMax = double.MinValue;
        yMin = double.MaxValue; yMax = double.MinValue;

        for (int i = 0; i < _x.Length; i++)
        {
            if (_x[i] < xMin) xMin = _x[i];
            if (_x[i] > xMax) xMax = _x[i];
            if (_y[i] < yMin) yMin = _y[i];
            if (_y[i] > yMax) yMax = _y[i];
        }
    }

    public void Render(SvgRenderer svg, CoordinateTransform tx, CoordinateTransform ty)
    {
        int count = _x.Length;
        float maxArrowLen = 25.0f * Scale;

        Span<float> hx = stackalloc float[3];
        Span<float> hy = stackalloc float[3];

        for (int i = 0; i < count; i++)
        {
            float px0 = tx.ToTarget(_x[i]);
            float py0 = ty.ToTarget(_y[i]);

            float m = _magnitudes[i];
            float normM = (m - _minMag) / (_maxMag - _minMag);
            float arrowLen = Math.Max(2.0f, normM * maxArrowLen);

            float dirX = m > 1e-6f ? _u[i] / m : 0f;
            float dirY = m > 1e-6f ? _v[i] / m : 0f;

            // Screen space direction
            float px1 = px0 + dirX * arrowLen;
            float py1 = py0 - dirY * arrowLen; // invert Y for screen

            Color arrowColor = ColorMap != null ? ColorMap.Sample(normM) : Color;

            // Shaft
            svg.DrawLine(px0, py0, px1, py1, arrowColor, LineWidth);

            // Arrow Head
            float headLen = ArrowHeadSize;
            float perpX = -dirY;
            float perpY = -dirX;

            float hx1 = px1 - dirX * headLen + perpX * (headLen * 0.5f);
            float hy1 = py1 + dirY * headLen + perpY * (headLen * 0.5f);

            float hx2 = px1 - dirX * headLen - perpX * (headLen * 0.5f);
            float hy2 = py1 + dirY * headLen - perpY * (headLen * 0.5f);

            hx[0] = px1; hx[1] = hx1; hx[2] = hx2;
            hy[0] = py1; hy[1] = hy1; hy[2] = hy2;
            svg.DrawPolygon(hx, hy, arrowColor, arrowColor, 0.5f);
        }
    }

    public void Render(RasterRenderer raster, CoordinateTransform tx, CoordinateTransform ty)
    {
        int count = _x.Length;
        float maxArrowLen = 25.0f * Scale;

        Span<float> hx = stackalloc float[3];
        Span<float> hy = stackalloc float[3];

        for (int i = 0; i < count; i++)
        {
            float px0 = tx.ToTarget(_x[i]);
            float py0 = ty.ToTarget(_y[i]);

            float m = _magnitudes[i];
            float normM = (m - _minMag) / (_maxMag - _minMag);
            float arrowLen = Math.Max(2.0f, normM * maxArrowLen);

            float dirX = m > 1e-6f ? _u[i] / m : 0f;
            float dirY = m > 1e-6f ? _v[i] / m : 0f;

            float px1 = px0 + dirX * arrowLen;
            float py1 = py0 - dirY * arrowLen;

            Color arrowColor = ColorMap != null ? ColorMap.Sample(normM) : Color;

            raster.DrawLine(px0, py0, px1, py1, arrowColor, LineWidth);

            float headLen = ArrowHeadSize;
            float perpX = -dirY;
            float perpY = -dirX;

            float hx1 = px1 - dirX * headLen + perpX * (headLen * 0.5f);
            float hy1 = py1 + dirY * headLen + perpY * (headLen * 0.5f);

            float hx2 = px1 - dirX * headLen - perpX * (headLen * 0.5f);
            float hy2 = py1 + dirY * headLen - perpY * (headLen * 0.5f);

            hx[0] = px1; hx[1] = hx1; hx[2] = hx2;
            hy[0] = py1; hy[1] = hy1; hy[2] = hy2;
            raster.FillConvexPolygon(hx, hy, arrowColor);
        }
    }

    public void RenderWebGL(StringBuilder sb, CoordinateTransform tx, CoordinateTransform ty)
    {
        // Add WebGL quiver vectors
    }
}
