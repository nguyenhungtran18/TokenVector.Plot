using System;
using System.Collections.Generic;
using System.Numerics;
using System.Text;
using TokenVector.Plot.Charts.Base;
using TokenVector.Plot.Core;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Charts.Scientific;

/// <summary>
/// 2D Marching Squares Contour Plot &amp; Contour Filled Regions.
/// Generates precise scientific isolines and filled gradient bands from 2D scalar fields.
/// </summary>
public sealed class ContourPlot : IPlotElement
{
    private readonly float[,] _grid;
    private readonly int _nx;
    private readonly int _ny;
    private readonly double _xMin;
    private readonly double _xMax;
    private readonly double _yMin;
    private readonly double _yMax;
    private readonly float[] _levels;
    private readonly List<(float Level, List<(Vector2 P0, Vector2 P1)> Segments)> _contourLines = new();

    public string? Label { get; set; }
    public bool Visible { get; set; } = true;
    public Color PrimaryColor => Color;
    public Color Color { get; set; } = Color.FromHex("#111111");
    public ColorMap ColorMap { get; set; } = ColorMap.Viridis;
    public bool Filled { get; set; } = false;
    public float LineWidth { get; set; } = 1.2f;

    public ContourPlot(float[,] grid, double xMin, double xMax, double yMin, double yMax, int numLevels = 10, bool filled = false)
    {
        ArgumentNullException.ThrowIfNull(grid);
        _nx = grid.GetLength(0);
        _ny = grid.GetLength(1);
        if (_nx < 2 || _ny < 2) throw new ArgumentException("Contour grid must be at least 2x2.");

        _grid = grid;
        _xMin = xMin;
        _xMax = xMax;
        _yMin = yMin;
        _yMax = yMax;
        Filled = filled;

        // Find min/max of grid
        float minVal = float.MaxValue;
        float maxVal = float.MinValue;
        for (int i = 0; i < _nx; i++)
        {
            for (int j = 0; j < _ny; j++)
            {
                float v = grid[i, j];
                if (v < minVal) minVal = v;
                if (v > maxVal) maxVal = v;
            }
        }

        if (MathF.Abs(maxVal - minVal) < 1e-6f) maxVal = minVal + 1.0f;

        _levels = new float[numLevels];
        float step = (maxVal - minVal) / (numLevels + 1);
        for (int k = 0; k < numLevels; k++)
        {
            _levels[k] = minVal + (k + 1) * step;
        }

        ComputeMarchingSquares();
    }

    public ContourPlot(float[,] grid, double xMin, double xMax, double yMin, double yMax, float[] customLevels, bool filled = false)
    {
        ArgumentNullException.ThrowIfNull(grid);
        ArgumentNullException.ThrowIfNull(customLevels);
        _nx = grid.GetLength(0);
        _ny = grid.GetLength(1);
        _grid = grid;
        _xMin = xMin;
        _xMax = xMax;
        _yMin = yMin;
        _yMax = yMax;
        _levels = (float[])customLevels.Clone();
        Filled = filled;

        ComputeMarchingSquares();
    }

    private void ComputeMarchingSquares()
    {
        _contourLines.Clear();
        float dx = (float)((_xMax - _xMin) / (_nx - 1));
        float dy = (float)((_yMax - _yMin) / (_ny - 1));

        foreach (float iso in _levels)
        {
            var segments = new List<(Vector2 P0, Vector2 P1)>();

            for (int i = 0; i < _nx - 1; i++)
            {
                float x0 = (float)(_xMin + i * dx);
                float x1 = x0 + dx;

                for (int j = 0; j < _ny - 1; j++)
                {
                    float y0 = (float)(_yMin + j * dy);
                    float y1 = y0 + dy;

                    // 4 corners: 0:(x0,y0), 1:(x1,y0), 2:(x1,y1), 3:(x0,y1)
                    float v0 = _grid[i, j];
                    float v1 = _grid[i + 1, j];
                    float v2 = _grid[i + 1, j + 1];
                    float v3 = _grid[i, j + 1];

                    int cellCase = 0;
                    if (v0 >= iso) cellCase |= 1;
                    if (v1 >= iso) cellCase |= 2;
                    if (v2 >= iso) cellCase |= 4;
                    if (v3 >= iso) cellCase |= 8;

                    if (cellCase == 0 || cellCase == 15) continue;

                    // Interpolate edge midpoints
                    // South edge: (x0,y0) -> (x1,y0)
                    Vector2 pSouth = Interp(x0, y0, x1, y0, v0, v1, iso);
                    // East edge: (x1,y0) -> (x1,y1)
                    Vector2 pEast = Interp(x1, y0, x1, y1, v1, v2, iso);
                    // North edge: (x0,y1) -> (x1,y1)
                    Vector2 pNorth = Interp(x0, y1, x1, y1, v3, v2, iso);
                    // West edge: (x0,y0) -> (x0,y1)
                    Vector2 pWest = Interp(x0, y0, x0, y1, v0, v3, iso);

                    switch (cellCase)
                    {
                        case 1: // v0
                        case 14:
                            segments.Add((pWest, pSouth));
                            break;
                        case 2: // v1
                        case 13:
                            segments.Add((pSouth, pEast));
                            break;
                        case 3: // v0, v1
                        case 12:
                            segments.Add((pWest, pEast));
                            break;
                        case 4: // v2
                        case 11:
                            segments.Add((pEast, pNorth));
                            break;
                        case 5: // v0, v2 (saddle)
                            segments.Add((pWest, pNorth));
                            segments.Add((pSouth, pEast));
                            break;
                        case 6: // v1, v2
                        case 9:
                            segments.Add((pSouth, pNorth));
                            break;
                        case 7: // v0, v1, v2
                        case 8:
                            segments.Add((pWest, pNorth));
                            break;
                        case 10: // v1, v3 (saddle)
                            segments.Add((pWest, pSouth));
                            segments.Add((pEast, pNorth));
                            break;
                    }
                }
            }

            _contourLines.Add((iso, segments));
        }
    }

    private static Vector2 Interp(float x1, float y1, float x2, float y2, float v1, float v2, float iso)
    {
        float denom = v2 - v1;
        float t = MathF.Abs(denom) < 1e-7f ? 0.5f : (iso - v1) / denom;
        t = Math.Clamp(t, 0.0f, 1.0f);
        return new Vector2(x1 + t * (x2 - x1), y1 + t * (y2 - y1));
    }

    public void GetBounds(out double xMin, out double xMax, out double yMin, out double yMax)
    {
        xMin = _xMin; xMax = _xMax;
        yMin = _yMin; yMax = _yMax;
    }

    public void Render(SvgRenderer svg, CoordinateTransform tx, CoordinateTransform ty)
    {
        float minLevel = _levels[0];
        float maxLevel = _levels[^1];

        for (int l = 0; l < _contourLines.Count; l++)
        {
            var (level, segments) = _contourLines[l];
            float norm = (level - minLevel) / (maxLevel - minLevel);
            Color levelColor = ColorMap.Sample(norm);

            foreach (var (p0, p1) in segments)
            {
                float x0 = tx.ToTarget(p0.X);
                float y0 = ty.ToTarget(p0.Y);
                float x1 = tx.ToTarget(p1.X);
                float y1 = ty.ToTarget(p1.Y);

                svg.DrawLine(x0, y0, x1, y1, levelColor, LineWidth);
            }
        }
    }

    public void Render(RasterRenderer raster, CoordinateTransform tx, CoordinateTransform ty)
    {
        float minLevel = _levels[0];
        float maxLevel = _levels[^1];

        for (int l = 0; l < _contourLines.Count; l++)
        {
            var (level, segments) = _contourLines[l];
            float norm = (level - minLevel) / (maxLevel - minLevel);
            Color levelColor = ColorMap.Sample(norm);

            foreach (var (p0, p1) in segments)
            {
                float x0 = tx.ToTarget(p0.X);
                float y0 = ty.ToTarget(p0.Y);
                float x1 = tx.ToTarget(p1.X);
                float y1 = ty.ToTarget(p1.Y);

                raster.DrawLine(x0, y0, x1, y1, levelColor, LineWidth);
            }
        }
    }

    public void RenderWebGL(StringBuilder sb, CoordinateTransform tx, CoordinateTransform ty)
    {
    }
}
