using System;
using TokenVector.Plot.Charts.Statistical;
using TokenVector.Plot.Core;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;
using Xunit;

namespace TokenVector.Plot.Tests;

public class StatisticalChartTests
{
    [Fact]
    public void FastScatterPlot_Handles100kPoints_FastRender()
    {
        int count = 100_000;
        float[] x = new float[count];
        float[] y = new float[count];
        var rand = new Random(42);

        for (int i = 0; i < count; i++)
        {
            x[i] = (float)rand.NextDouble() * 100f;
            y[i] = (float)rand.NextDouble() * 100f;
        }

        var scatter = new FastScatterPlot(x, y);
        using var raster = new RasterRenderer(800, 600, 300f);
        var tx = new CoordinateTransform(ScaleType.Linear, 0, 100, 50, 750);
        var ty = new CoordinateTransform(ScaleType.Linear, 0, 100, 550, 50);

        scatter.Render(raster, tx, ty);
        byte[] png = raster.ToPngBytes();
        Assert.NotNull(png);
        Assert.True(png.Length > 100);
    }

    [Fact]
    public void LinePlot_RendersConfidenceBands()
    {
        float[] x = { 0, 1, 2, 3, 4 };
        float[] y = { 10, 12, 15, 14, 18 };
        float[] yLower = { 8, 10, 13, 12, 16 };
        float[] yUpper = { 12, 14, 17, 16, 20 };

        var line = new LinePlot(x, y, yLower, yUpper);
        line.GetBounds(out double xMin, out double xMax, out double yMin, out double yMax);

        Assert.Equal(0, xMin);
        Assert.Equal(4, xMax);
        Assert.Equal(8, yMin);
        Assert.Equal(20, yMax);

        var svg = new SvgRenderer(400, 300);
        var tx = new CoordinateTransform(ScaleType.Linear, 0, 4, 0, 400);
        var ty = new CoordinateTransform(ScaleType.Linear, 0, 20, 300, 0);
        line.Render(svg, tx, ty);

        string output = svg.Build();
        Assert.Contains("<polygon", output); // Confidence band ribbon
        Assert.Contains("<polyline", output); // Main line
    }

    [Fact]
    public void BarHistogramPlot_FreedmanDiaconisBinning_Works()
    {
        float[] sampleData = new float[500];
        var rand = new Random(123);
        for (int i = 0; i < 500; i++)
        {
            sampleData[i] = (float)(rand.NextDouble() + rand.NextDouble() + rand.NextDouble()); // Approximate normal
        }

        var hist = BarHistogramPlot.FromRawData(sampleData, BinningStrategy.FreedmanDiaconis);
        hist.GetBounds(out double xMin, out double xMax, out double yMin, out double yMax);

        Assert.True(xMax > xMin);
        Assert.True(yMax > 0);
    }

    [Fact]
    public void BoxViolinPlot_ComputesQuartilesAndOutliers()
    {
        float[] data = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 100 }; // 100 is outlier
        var box = new BoxViolinPlot();
        box.AddGroup(1.0f, data, "GroupA");

        var g = box.Groups[0];
        Assert.Equal(6.0f, g.Median, 0.5f);
        Assert.Contains(100f, g.Outliers);
    }

    [Fact]
    public void HeatmapPlot_RendersMatrixGrid()
    {
        float[,] matrix = new float[3, 3]
        {
            { 1.0f, 0.8f, 0.2f },
            { 0.8f, 1.0f, 0.5f },
            { 0.2f, 0.5f, 1.0f }
        };

        var heatmap = new HeatmapPlot(matrix)
        {
            ShowAnnotations = true
        };

        var svg = new SvgRenderer(300, 300);
        var tx = new CoordinateTransform(ScaleType.Linear, 0, 3, 0, 300);
        var ty = new CoordinateTransform(ScaleType.Linear, 0, 3, 0, 300);
        heatmap.Render(svg, tx, ty);

        string output = svg.Build();
        Assert.Contains("<rect", output);
        Assert.Contains("<text", output);
    }
}
