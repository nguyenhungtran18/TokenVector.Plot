using System;
using System.Globalization;
using System.Text;
using TokenVector.Plot.Charts.Base;
using TokenVector.Plot.Core;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Charts.Statistical;

/// <summary>
/// 2D Heatmap Correlation and Matrix Plot with ColorMap gradient mapping,
/// cell text annotations, and automatic contrast adjustment.
/// </summary>
public sealed class HeatmapPlot : IPlotElement
{
    private readonly float[,] _matrix;
    private readonly int _rows;
    private readonly int _cols;
    private readonly float _minVal;
    private readonly float _maxVal;

    public string? Label { get; set; }
    public bool Visible { get; set; } = true;
    public Color PrimaryColor => Color.Blue;
    public ColorMap ColorMap { get; set; } = ColorMap.Viridis;
    public bool ShowAnnotations { get; set; } = false;
    public string AnnotationFormat { get; set; } = "0.##";
    public float AnnotationFontSize { get; set; } = 9.0f;
    public string[]? RowLabels { get; set; }
    public string[]? ColLabels { get; set; }

    public HeatmapPlot(float[,] matrix)
    {
        ArgumentNullException.ThrowIfNull(matrix);
        _rows = matrix.GetLength(0);
        _cols = matrix.GetLength(1);
        if (_rows == 0 || _cols == 0) throw new ArgumentException("Matrix cannot be empty.");

        _matrix = matrix;

        float min = float.MaxValue;
        float max = float.MinValue;
        for (int r = 0; r < _rows; r++)
        {
            for (int c = 0; c < _cols; c++)
            {
                float v = matrix[r, c];
                if (v < min) min = v;
                if (v > max) max = v;
            }
        }
        _minVal = min;
        _maxVal = MathF.Abs(max - min) < 1e-6f ? min + 1.0f : max;
    }

    public void GetBounds(out double xMin, out double xMax, out double yMin, out double yMax)
    {
        xMin = 0.0;
        xMax = _cols;
        yMin = 0.0;
        yMax = _rows;
    }

    public void Render(SvgRenderer svg, CoordinateTransform tx, CoordinateTransform ty)
    {
        float invRange = 1.0f / (_maxVal - _minVal);

        for (int r = 0; r < _rows; r++)
        {
            for (int c = 0; c < _cols; c++)
            {
                float val = _matrix[r, c];
                float norm = (val - _minVal) * invRange;
                Color cellCol = ColorMap.Sample(norm);

                float x0 = tx.ToTarget(c);
                float x1 = tx.ToTarget(c + 1);
                float y0 = ty.ToTarget(r);
                float y1 = ty.ToTarget(r + 1);

                float px = MathF.Min(x0, x1);
                float py = MathF.Min(y0, y1);
                float w = MathF.Abs(x1 - x0);
                float h = MathF.Abs(y1 - y0);

                svg.DrawRect(px, py, w, h, cellCol, Color.White, 0.5f);

                if (ShowAnnotations)
                {
                    Color textCol = norm > 0.5f ? Color.Black : Color.White;
                    string txt = val.ToString(AnnotationFormat, CultureInfo.InvariantCulture);
                    svg.DrawText(txt, px + w * 0.5f, py + h * 0.5f + AnnotationFontSize * 0.35f, textCol, AnnotationFontSize, "normal", "Helvetica, Arial, sans-serif", "middle");
                }
            }
        }
    }

    public void Render(RasterRenderer raster, CoordinateTransform tx, CoordinateTransform ty)
    {
        float invRange = 1.0f / (_maxVal - _minVal);

        for (int r = 0; r < _rows; r++)
        {
            for (int c = 0; c < _cols; c++)
            {
                float val = _matrix[r, c];
                float norm = (val - _minVal) * invRange;
                Color cellCol = ColorMap.Sample(norm);

                float x0 = tx.ToTarget(c);
                float x1 = tx.ToTarget(c + 1);
                float y0 = ty.ToTarget(r);
                float y1 = ty.ToTarget(r + 1);

                float px = MathF.Min(x0, x1);
                float py = MathF.Min(y0, y1);
                float w = MathF.Abs(x1 - x0);
                float h = MathF.Abs(y1 - y0);

                raster.FillRect(px, py, w, h, cellCol);
                raster.DrawRect(px, py, w, h, Color.White, 0.5f);

                if (ShowAnnotations)
                {
                    Color textCol = norm > 0.5f ? Color.Black : Color.White;
                    string txt = val.ToString(AnnotationFormat, CultureInfo.InvariantCulture);
                    raster.DrawText(txt, px + w * 0.5f - txt.Length * 3f, py + h * 0.5f + AnnotationFontSize * 0.35f, textCol, AnnotationFontSize);
                }
            }
        }
    }

    public void RenderWebGL(StringBuilder sb, CoordinateTransform tx, CoordinateTransform ty)
    {
    }
}
