using System;
using System.Numerics;
using TokenVector.Numerics.Core;
using TokenVector.Plot.Charts.Scientific;
using TokenVector.Plot.Charts.Statistical;
using TokenVector.Plot.Core;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Interop;

/// <summary>
/// Zero-Copy Plotting Bridge extensions for TokenVector.Numerics NDArray&lt;T&gt;.
/// </summary>
public static class NDArrayPlotExtensions
{
    public static NDArrayPlotter<T> Plot<T>(this NDArray<T> array) where T : unmanaged, INumber<T>
    {
        return new NDArrayPlotter<T>(array);
    }
}

public readonly ref struct NDArrayPlotter<T> where T : unmanaged, INumber<T>
{
    private readonly NDArray<T> _array;

    public NDArrayPlotter(NDArray<T> array)
    {
        _array = array;
    }

    /// <summary>
    /// Renders 1D NDArray as a Line Plot.
    /// </summary>
    public Figure Line(string? label = null, Color? color = null)
    {
        var fig = Figure.Create();
        int len = _array.TotalLength;
        float[] x = new float[len];
        float[] y = new float[len];

        var contig = _array.Contiguous();
        var span = contig.AsReadOnlySpan();

        for (int i = 0; i < len; i++)
        {
            x[i] = i;
            y[i] = float.CreateTruncating(span[i]);
        }

        var line = new LinePlot(x, y)
        {
            Label = label,
            Color = color ?? fig.Theme.GetPaletteColor(0)
        };
        fig.Axes.AddElement(line);
        return fig;
    }

    /// <summary>
    /// Renders 1D NDArray as a Fast Scatter Plot.
    /// </summary>
    public Figure Scatter(string? label = null, Color? color = null, float pointSize = 3.0f)
    {
        var fig = Figure.Create();
        int len = _array.TotalLength;
        float[] x = new float[len];
        float[] y = new float[len];

        var contig = _array.Contiguous();
        var span = contig.AsReadOnlySpan();

        for (int i = 0; i < len; i++)
        {
            x[i] = i;
            y[i] = float.CreateTruncating(span[i]);
        }

        var scatter = new FastScatterPlot(x, y)
        {
            Label = label,
            Color = color ?? fig.Theme.GetPaletteColor(0),
            PointSize = pointSize
        };
        fig.Axes.AddElement(scatter);
        return fig;
    }

    /// <summary>
    /// Renders 1D NDArray as a Histogram.
    /// </summary>
    public Figure Histogram(int bins = 20, bool normalizeDensity = false)
    {
        var fig = Figure.Create();
        int len = _array.TotalLength;
        float[] data = new float[len];

        var contig = _array.Contiguous();
        var span = contig.AsReadOnlySpan();
        for (int i = 0; i < len; i++)
        {
            data[i] = float.CreateTruncating(span[i]);
        }

        var hist = BarHistogramPlot.FromRawData(data, BinningStrategy.FreedmanDiaconis, bins, normalizeDensity);
        fig.Axes.AddElement(hist);
        return fig;
    }

    /// <summary>
    /// Renders 2D NDArray as a 2D Heatmap.
    /// </summary>
    public Figure Heatmap(ColorMap? colorMap = null, bool showAnnotations = false)
    {
        if (_array.Rank != 2) throw new InvalidOperationException("Heatmap requires a 2D NDArray.");
        int rows = _array.Shape[0];
        int cols = _array.Shape[1];

        float[,] grid = new float[rows, cols];
        for (int r = 0; r < rows; r++)
        {
            for (int c = 0; c < cols; c++)
            {
                grid[r, c] = float.CreateTruncating(_array[r, c]);
            }
        }

        var fig = Figure.Create();
        var heatmap = new HeatmapPlot(grid)
        {
            ColorMap = colorMap ?? ColorMap.Viridis,
            ShowAnnotations = showAnnotations
        };
        fig.Axes.AddElement(heatmap);
        return fig;
    }

    /// <summary>
    /// Renders 2D NDArray as Marching Squares Contour Isolines.
    /// </summary>
    public Figure Contour(int numLevels = 10, ColorMap? colorMap = null)
    {
        if (_array.Rank != 2) throw new InvalidOperationException("Contour plot requires a 2D NDArray.");
        int rows = _array.Shape[0];
        int cols = _array.Shape[1];

        float[,] grid = new float[rows, cols];
        for (int r = 0; r < rows; r++)
        {
            for (int c = 0; c < cols; c++)
            {
                grid[r, c] = float.CreateTruncating(_array[r, c]);
            }
        }

        var fig = Figure.Create();
        var contour = new ContourPlot(grid, 0, cols - 1, 0, rows - 1, numLevels)
        {
            ColorMap = colorMap ?? ColorMap.Viridis
        };
        fig.Axes.AddElement(contour);
        return fig;
    }

    /// <summary>
    /// Renders 2D NDArray as a 3D Surface with Phong Shading &amp; Z-Buffer.
    /// </summary>
    public Figure Surface3D(ColorMap? colorMap = null)
    {
        if (_array.Rank != 2) throw new InvalidOperationException("Surface3D requires a 2D NDArray.");
        int rows = _array.Shape[0];
        int cols = _array.Shape[1];

        float[,] grid = new float[rows, cols];
        for (int r = 0; r < rows; r++)
        {
            for (int c = 0; c < cols; c++)
            {
                grid[r, c] = float.CreateTruncating(_array[r, c]);
            }
        }

        var fig = Figure.Create();
        var surface = new Surface3DPlot(grid, 0, cols - 1, 0, rows - 1)
        {
            ColorMap = colorMap ?? ColorMap.Viridis
        };
        fig.Axes.AddElement(surface);
        return fig;
    }
}
