using System;
using System.Numerics;
using System.Text;
using TokenVector.Plot.Charts.Base;
using TokenVector.Plot.Core;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Charts.Statistical;

public enum MarkerStyle
{
    None,
    Circle,
    Square,
    Triangle,
    Cross
}

public enum LineStyle
{
    Solid,
    Dashed,
    Dotted
}

/// <summary>
/// 1D / 2D Line Plot with marker symbols and semi-transparent Confidence Bands ribbon.
/// </summary>
public sealed class LinePlot : IPlotElement
{
    private readonly float[] _x;
    private readonly float[] _y;
    private readonly float[]? _yLower;
    private readonly float[]? _yUpper;

    public string? Label { get; set; }
    public bool Visible { get; set; } = true;
    public Color PrimaryColor => Color;
    public Color Color { get; set; } = Color.FromHex("#0C5DA5");
    public Color? ConfidenceBandColor { get; set; }
    public float LineWidth { get; set; } = 2.0f;
    public LineStyle Style { get; set; } = LineStyle.Solid;
    public MarkerStyle Marker { get; set; } = MarkerStyle.None;
    public float MarkerSize { get; set; } = 4.0f;

    public LinePlot(ReadOnlySpan<float> x, ReadOnlySpan<float> y, ReadOnlySpan<float> yLower = default, ReadOnlySpan<float> yUpper = default)
    {
        int count = Math.Min(x.Length, y.Length);
        if (count == 0) throw new ArgumentException("Data arrays cannot be empty.");

        _x = x[..count].ToArray();
        _y = y[..count].ToArray();

        if (!yLower.IsEmpty && !yUpper.IsEmpty)
        {
            int bCount = Math.Min(count, Math.Min(yLower.Length, yUpper.Length));
            _yLower = yLower[..bCount].ToArray();
            _yUpper = yUpper[..bCount].ToArray();
        }
    }

    public void GetBounds(out double xMin, out double xMax, out double yMin, out double yMax)
    {
        xMin = double.MaxValue; xMax = double.MinValue;
        yMin = double.MaxValue; yMax = double.MinValue;

        for (int i = 0; i < _x.Length; i++)
        {
            if (_x[i] < xMin) xMin = _x[i];
            if (_x[i] > xMax) xMax = _x[i];

            float yVal = _y[i];
            float yL = _yLower != null && i < _yLower.Length ? _yLower[i] : yVal;
            float yU = _yUpper != null && i < _yUpper.Length ? _yUpper[i] : yVal;

            if (yL < yMin) yMin = yL;
            if (yU > yMax) yMax = yU;
        }
    }

    public void Render(SvgRenderer svg, CoordinateTransform tx, CoordinateTransform ty)
    {
        int count = _x.Length;

        // 1. Render Confidence Band (Filled polygon ribbon)
        if (_yLower != null && _yUpper != null && _yLower.Length == count && _yUpper.Length == count)
        {
            Color bandCol = ConfidenceBandColor ?? Color.WithAlpha(50);
            Span<float> polyX = stackalloc float[count * 2];
            Span<float> polyY = stackalloc float[count * 2];

            for (int i = 0; i < count; i++)
            {
                polyX[i] = tx.ToTarget(_x[i]);
                polyY[i] = ty.ToTarget(_yUpper[i]);
            }
            for (int i = 0; i < count; i++)
            {
                int rIdx = count + i;
                int srcIdx = count - 1 - i;
                polyX[rIdx] = tx.ToTarget(_x[srcIdx]);
                polyY[rIdx] = ty.ToTarget(_yLower[srcIdx]);
            }

            svg.DrawPolygon(polyX, polyY, bandCol, Color.Transparent, 0f);
        }

        // 2. Render Main Line
        Span<float> px = stackalloc float[count];
        Span<float> py = stackalloc float[count];
        tx.TransformSpan(_x, px);
        ty.TransformSpan(_y, py);

        string? dash = Style switch
        {
            LineStyle.Dashed => "6,4",
            LineStyle.Dotted => "2,3",
            _ => null
        };

        svg.DrawPolyline(px, py, Color, LineWidth, dash);

        // 3. Render Markers
        if (Marker != MarkerStyle.None)
        {
            Span<float> txCoords = stackalloc float[3];
            Span<float> tyCoords = stackalloc float[3];

            for (int i = 0; i < count; i++)
            {
                float mx = px[i];
                float my = py[i];
                switch (Marker)
                {
                    case MarkerStyle.Circle:
                        svg.DrawCircle(mx, my, MarkerSize, Color, Color.White, 1.0f);
                        break;
                    case MarkerStyle.Square:
                        svg.DrawRect(mx - MarkerSize, my - MarkerSize, MarkerSize * 2, MarkerSize * 2, Color, Color.White, 1.0f);
                        break;
                    case MarkerStyle.Triangle:
                        txCoords[0] = mx; txCoords[1] = mx - MarkerSize; txCoords[2] = mx + MarkerSize;
                        tyCoords[0] = my - MarkerSize; tyCoords[1] = my + MarkerSize; tyCoords[2] = my + MarkerSize;
                        svg.DrawPolygon(txCoords, tyCoords, Color, Color.White, 1.0f);
                        break;
                }
            }
        }
    }

    public void Render(RasterRenderer raster, CoordinateTransform tx, CoordinateTransform ty)
    {
        int count = _x.Length;

        // 1. Confidence Ribbon
        if (_yLower != null && _yUpper != null && _yLower.Length == count && _yUpper.Length == count)
        {
            Color bandCol = ConfidenceBandColor ?? Color.WithAlpha(50);
            Span<float> qx = stackalloc float[4];
            Span<float> qy = stackalloc float[4];

            for (int i = 0; i < count - 1; i++)
            {
                float x0 = tx.ToTarget(_x[i]);
                float x1 = tx.ToTarget(_x[i + 1]);
                float yTop0 = ty.ToTarget(_yUpper[i]);
                float yTop1 = ty.ToTarget(_yUpper[i + 1]);
                float yBot0 = ty.ToTarget(_yLower[i]);
                float yBot1 = ty.ToTarget(_yLower[i + 1]);

                qx[0] = x0; qx[1] = x1; qx[2] = x1; qx[3] = x0;
                qy[0] = yTop0; qy[1] = yTop1; qy[2] = yBot1; qy[3] = yBot0;
                raster.FillConvexPolygon(qx, qy, bandCol);
            }
        }

        // 2. Line
        Span<float> px = stackalloc float[count];
        Span<float> py = stackalloc float[count];
        tx.TransformSpan(_x, px);
        ty.TransformSpan(_y, py);

        raster.DrawPolyline(px, py, Color, LineWidth);

        // 3. Markers
        if (Marker != MarkerStyle.None)
        {
            for (int i = 0; i < count; i++)
            {
                float mx = px[i];
                float my = py[i];
                if (Marker == MarkerStyle.Circle)
                {
                    raster.FillCircle(mx, my, MarkerSize, Color);
                }
                else if (Marker == MarkerStyle.Square)
                {
                    raster.FillRect(mx - MarkerSize, my - MarkerSize, MarkerSize * 2, MarkerSize * 2, Color);
                }
            }
        }
    }

    public void RenderWebGL(StringBuilder sb, CoordinateTransform tx, CoordinateTransform ty)
    {
    }
}
