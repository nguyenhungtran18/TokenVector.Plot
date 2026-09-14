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
/// Fluid Flow Streamline Plot integrating vector fields using 4th-Order Runge-Kutta (RK4).
/// </summary>
public sealed class StreamPlot : IPlotElement
{
    private readonly float[,] _uGrid;
    private readonly float[,] _vGrid;
    private readonly int _nx;
    private readonly int _ny;
    private readonly double _xMin;
    private readonly double _xMax;
    private readonly double _yMin;
    private readonly double _yMax;
    private readonly List<List<Vector2>> _streamlines = new();

    public string? Label { get; set; }
    public bool Visible { get; set; } = true;
    public Color PrimaryColor => Color;
    public Color Color { get; set; } = Color.FromHex("#0C5DA5");
    public ColorMap? ColorMap { get; set; }
    public float LineWidth { get; set; } = 1.5f;
    public float Density { get; set; } = 1.0f;
    public int MaxSteps { get; set; } = 250;
    public float StepSize { get; set; } = 0.05f;

    public StreamPlot(float[,] u, float[,] v, double xMin, double xMax, double yMin, double yMax)
    {
        ArgumentNullException.ThrowIfNull(u);
        ArgumentNullException.ThrowIfNull(v);
        _nx = u.GetLength(0);
        _ny = u.GetLength(1);
        if (_nx < 2 || _ny < 2) throw new ArgumentException("Grid dimensions must be at least 2x2.");
        if (v.GetLength(0) != _nx || v.GetLength(1) != _ny) throw new ArgumentException("U and V grids must have matching dimensions.");

        _uGrid = u;
        _vGrid = v;
        _xMin = xMin;
        _xMax = xMax;
        _yMin = yMin;
        _yMax = yMax;

        ComputeStreamlines();
    }

    private void ComputeStreamlines()
    {
        _streamlines.Clear();
        int seedCountX = (int)(15 * Density);
        int seedCountY = (int)(15 * Density);

        for (int sx = 0; sx < seedCountX; sx++)
        {
            for (int sy = 0; sy < seedCountY; sy++)
            {
                float seedX = (float)(_xMin + (sx + 0.5f) / seedCountX * (_xMax - _xMin));
                float seedY = (float)(_yMin + (sy + 0.5f) / seedCountY * (_yMax - _yMin));

                var line = TraceStreamline(seedX, seedY);
                if (line.Count >= 3)
                {
                    _streamlines.Add(line);
                }
            }
        }
    }

    private List<Vector2> TraceStreamline(float startX, float startY)
    {
        var points = new List<Vector2>(MaxSteps) { new(startX, startY) };
        float curX = startX;
        float curY = startY;
        float h = StepSize;

        for (int step = 0; step < MaxSteps; step++)
        {
            if (!SampleField(curX, curY, out var k1)) break;
            float mag1 = k1.Length();
            if (mag1 < 1e-6f) break;
            k1 = Vector2.Normalize(k1);

            if (!SampleField(curX + 0.5f * h * k1.X, curY + 0.5f * h * k1.Y, out var k2)) break;
            k2 = Vector2.Normalize(k2);

            if (!SampleField(curX + 0.5f * h * k2.X, curY + 0.5f * h * k2.Y, out var k3)) break;
            k3 = Vector2.Normalize(k3);

            if (!SampleField(curX + h * k3.X, curY + h * k3.Y, out var k4)) break;
            k4 = Vector2.Normalize(k4);

            float nextX = curX + (h / 6.0f) * (k1.X + 2 * k2.X + 2 * k3.X + k4.X);
            float nextY = curY + (h / 6.0f) * (k1.Y + 2 * k2.Y + 2 * k3.Y + k4.Y);

            if (nextX < _xMin || nextX > _xMax || nextY < _yMin || nextY > _yMax) break;

            curX = nextX;
            curY = nextY;
            points.Add(new Vector2(curX, curY));
        }

        return points;
    }

    private bool SampleField(float x, float y, out Vector2 velocity)
    {
        velocity = Vector2.Zero;
        if (x < _xMin || x > _xMax || y < _yMin || y > _yMax) return false;

        float uNorm = (float)((x - _xMin) / (_xMax - _xMin) * (_nx - 1));
        float vNorm = (float)((y - _yMin) / (_yMax - _yMin) * (_ny - 1));

        int i0 = Math.Clamp((int)uNorm, 0, _nx - 2);
        int j0 = Math.Clamp((int)vNorm, 0, _ny - 2);
        int i1 = i0 + 1;
        int j1 = j0 + 1;

        float fx = uNorm - i0;
        float fy = vNorm - j0;

        // Bilinear interpolation
        float uVal = (1 - fx) * (1 - fy) * _uGrid[i0, j0] +
                     fx * (1 - fy) * _uGrid[i1, j0] +
                     (1 - fx) * fy * _uGrid[i0, j1] +
                     fx * fy * _uGrid[i1, j1];

        float vVal = (1 - fx) * (1 - fy) * _vGrid[i0, j0] +
                     fx * (1 - fy) * _vGrid[i1, j0] +
                     (1 - fx) * fy * _vGrid[i0, j1] +
                     fx * fy * _vGrid[i1, j1];

        velocity = new Vector2(uVal, vVal);
        return true;
    }

    public void GetBounds(out double xMin, out double xMax, out double yMin, out double yMax)
    {
        xMin = _xMin; xMax = _xMax;
        yMin = _yMin; yMax = _yMax;
    }

    public void Render(SvgRenderer svg, CoordinateTransform tx, CoordinateTransform ty)
    {
        float[] px = new float[MaxSteps];
        float[] py = new float[MaxSteps];

        foreach (var line in _streamlines)
        {
            int ptCount = line.Count;
            if (ptCount > px.Length)
            {
                px = new float[ptCount];
                py = new float[ptCount];
            }

            for (int i = 0; i < ptCount; i++)
            {
                px[i] = tx.ToTarget(line[i].X);
                py[i] = ty.ToTarget(line[i].Y);
            }

            svg.DrawPolyline(px.AsSpan(0, ptCount), py.AsSpan(0, ptCount), Color, LineWidth);
        }
    }

    public void Render(RasterRenderer raster, CoordinateTransform tx, CoordinateTransform ty)
    {
        float[] px = new float[MaxSteps];
        float[] py = new float[MaxSteps];

        foreach (var line in _streamlines)
        {
            int ptCount = line.Count;
            if (ptCount > px.Length)
            {
                px = new float[ptCount];
                py = new float[ptCount];
            }

            for (int i = 0; i < ptCount; i++)
            {
                px[i] = tx.ToTarget(line[i].X);
                py[i] = ty.ToTarget(line[i].Y);
            }

            raster.DrawPolyline(px.AsSpan(0, ptCount), py.AsSpan(0, ptCount), Color, LineWidth);
        }
    }

    public void RenderWebGL(StringBuilder sb, CoordinateTransform tx, CoordinateTransform ty)
    {
    }
}
