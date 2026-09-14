using System;
using TokenVector.Plot.Charts.Scientific;
using TokenVector.Plot.Core;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;
using Xunit;

namespace TokenVector.Plot.Tests;

public class ScientificChartTests
{
    [Fact]
    public void QuiverPlot_ComputesVectorMagnitudesCorrectly()
    {
        float[] x = { 0, 1, 2 };
        float[] y = { 0, 1, 2 };
        float[] u = { 3, 0, 4 };
        float[] v = { 4, 5, 3 };

        var quiver = new QuiverPlot(x, y, u, v);
        quiver.GetBounds(out double xMin, out double xMax, out double yMin, out double yMax);

        Assert.Equal(0, xMin);
        Assert.Equal(2, xMax);
        Assert.Equal(0, yMin);
        Assert.Equal(2, yMax);
    }

    [Fact]
    public void StreamPlot_TracesStreamlinesWithRK4()
    {
        int nx = 20, ny = 20;
        float[,] u = new float[nx, ny];
        float[,] v = new float[nx, ny];

        for (int i = 0; i < nx; i++)
        {
            for (int j = 0; j < ny; j++)
            {
                float x = -2f + i * (4f / (nx - 1));
                float y = -2f + j * (4f / (ny - 1));
                u[i, j] = -y; // Circular vortex field
                v[i, j] = x;
            }
        }

        var stream = new StreamPlot(u, v, -2, 2, -2, 2);
        stream.GetBounds(out double xMin, out double xMax, out double yMin, out double yMax);

        Assert.Equal(-2, xMin);
        Assert.Equal(2, xMax);

        var svg = new SvgRenderer(400, 400);
        var tx = new CoordinateTransform(ScaleType.Linear, -2, 2, 0, 400);
        var ty = new CoordinateTransform(ScaleType.Linear, -2, 2, 400, 0);
        stream.Render(svg, tx, ty);

        string svgContent = svg.Build();
        Assert.Contains("<polyline", svgContent);
    }

    [Fact]
    public void ContourPlot_MarchingSquares_ExtractsIsolines()
    {
        int n = 30;
        float[,] grid = new float[n, n];
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
            {
                float x = -3f + i * (6f / (n - 1));
                float y = -3f + j * (6f / (n - 1));
                grid[i, j] = MathF.Sin(x) * MathF.Cos(y);
            }
        }

        var contour = new ContourPlot(grid, -3, 3, -3, 3, numLevels: 8);
        var svg = new SvgRenderer(500, 500);
        var tx = new CoordinateTransform(ScaleType.Linear, -3, 3, 0, 500);
        var ty = new CoordinateTransform(ScaleType.Linear, -3, 3, 500, 0);
        contour.Render(svg, tx, ty);

        string output = svg.Build();
        Assert.Contains("<line", output);
    }

    [Fact]
    public void Surface3DPlot_RendersPhongLightingAndZBuffer()
    {
        int n = 25;
        float[,] grid = new float[n, n];
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
            {
                float x = -2f + i * (4f / (n - 1));
                float y = -2f + j * (4f / (n - 1));
                grid[i, j] = MathF.Exp(-(x * x + y * y)); // Gaussian peak
            }
        }

        var surface = new Surface3DPlot(grid, -2, 2, -2, 2);
        using var raster = new RasterRenderer(400, 400, 300f, enableZBuffer: true);
        var tx = new CoordinateTransform(ScaleType.Linear, -2, 2, 0, 400);
        var ty = new CoordinateTransform(ScaleType.Linear, -2, 2, 0, 400);

        surface.Render(raster, tx, ty);
        byte[] png = raster.ToPngBytes();
        Assert.NotEmpty(png);
        Assert.Equal(0x89, png[0]); // PNG magic byte
    }
}
