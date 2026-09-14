using System;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Core;

/// <summary>
/// Subplot grid layout manager (M rows x N columns).
/// Handles automatic coordinate allocation, margins, and spacing between plots.
/// </summary>
public sealed class SubplotGrid
{
    private readonly Axes2D[,] _axesGrid;
    public int Rows { get; }
    public int Columns { get; }

    public float LeftMargin { get; set; } = 70f;
    public float RightMargin { get; set; } = 30f;
    public float TopMargin { get; set; } = 50f;
    public float BottomMargin { get; set; } = 60f;
    public float HorizontalSpacing { get; set; } = 50f;
    public float VerticalSpacing { get; set; } = 50f;

    public SubplotGrid(int rows, int cols)
    {
        ArgumentOutOfRangeException.ThrowIfNegativeOrZero(rows);
        ArgumentOutOfRangeException.ThrowIfNegativeOrZero(cols);
        Rows = rows;
        Columns = cols;
        _axesGrid = new Axes2D[rows, cols];

        for (int r = 0; r < rows; r++)
        {
            for (int c = 0; c < cols; c++)
            {
                _axesGrid[r, c] = new Axes2D();
            }
        }
    }

    public Axes2D this[int row, int col]
    {
        get
        {
            if ((uint)row >= (uint)Rows || (uint)col >= (uint)Columns)
            {
                throw new IndexOutOfRangeException($"Subplot ({row}, {col}) out of range for grid {Rows}x{Columns}.");
            }
            return _axesGrid[row, col];
        }
    }

    public (float X, float Y, float Width, float Height) GetCellRect(int row, int col, float totalWidth, float totalHeight)
    {
        float usableWidth = totalWidth - LeftMargin - RightMargin - (Columns - 1) * HorizontalSpacing;
        float usableHeight = totalHeight - TopMargin - BottomMargin - (Rows - 1) * VerticalSpacing;

        float cellWidth = usableWidth / Columns;
        float cellHeight = usableHeight / Rows;

        float x = LeftMargin + col * (cellWidth + HorizontalSpacing);
        float y = TopMargin + row * (cellHeight + VerticalSpacing);

        return (x, y, cellWidth, cellHeight);
    }

    public void RenderSvg(SvgRenderer svg, StyleTheme theme, float totalWidth, float totalHeight)
    {
        for (int r = 0; r < Rows; r++)
        {
            for (int c = 0; c < Columns; c++)
            {
                var (x, y, w, h) = GetCellRect(r, c, totalWidth, totalHeight);
                _axesGrid[r, c].RenderSvg(svg, theme, x, y, w, h);
            }
        }
    }

    public void RenderRaster(RasterRenderer raster, StyleTheme theme, float totalWidth, float totalHeight)
    {
        for (int r = 0; r < Rows; r++)
        {
            for (int c = 0; c < Columns; c++)
            {
                var (x, y, w, h) = GetCellRect(r, c, totalWidth, totalHeight);
                _axesGrid[r, c].RenderRaster(raster, theme, x, y, w, h);
            }
        }
    }
}
