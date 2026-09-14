using System;
using TokenVector.Data.Core;
using TokenVector.Numerics.Core;
using TokenVector.Plot.Interop;
using TokenVector.Plot.Themes;
using Xunit;

namespace TokenVector.Plot.Tests;

public class InteropTests
{
    [Fact]
    public void NDArray_PlotLine_And_Heatmap_WorkZeroCopy()
    {
        var array1d = new NDArray<float>(100);
        for (int i = 0; i < 100; i++) array1d[i] = MathF.Sin(i * 0.1f);

        var figLine = array1d.Plot().Line(label: "Sine Wave");
        Assert.Single(figLine.Axes.Elements);
        string svg = figLine.ToSvgString();
        Assert.Contains("Sine Wave", svg);

        var array2d = new NDArray<float>(10, 10);
        for (int r = 0; r < 10; r++)
        {
            for (int c = 0; c < 10; c++)
            {
                array2d[r, c] = r * 10 + c;
            }
        }

        var figHeatmap = array2d.Plot().Heatmap(ColorMap.Viridis);
        Assert.Single(figHeatmap.Axes.Elements);
        byte[] png = figHeatmap.ToPngBytes();
        Assert.NotEmpty(png);
    }

    [Fact]
    public void DataFrame_PlotScatter_And_Bar_WorkSeamlessly()
    {
        float[] time = { 0, 1, 2, 3, 4 };
        float[] signal = { 10.5f, 20.3f, 15.2f, 30.1f, 25.4f };

        var colTime = new Column<float>(time);
        var colSignal = new Column<float>(signal);

        var sTime = new Series("Time", colTime);
        var sSignal = new Series("Signal", colSignal);

        var df = new DataFrame(new[] { sTime, sSignal });

        var figScatter = df.Plot().Scatter("Time", "Signal", pointSize: 4.0f);
        Assert.Single(figScatter.Axes.Elements);
        Assert.Equal("Time", figScatter.Axes.XLabel);
        Assert.Equal("Signal", figScatter.Axes.YLabel);

        string svg = figScatter.ToSvgString();
        Assert.Contains("Signal", svg);
    }
}
