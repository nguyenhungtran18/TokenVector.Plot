using System;
using System.Collections.Generic;
using TokenVector.Plot.Core;
using TokenVector.Plot.Themes;
using Xunit;

namespace TokenVector.Plot.Tests;

public class CoreTests
{
    [Fact]
    public void TicksEngine_GeneratesAestheticTicks_ForLinearRange()
    {
        var ticks = TicksEngine.GenerateTicks(0.0, 10.0, 5);
        Assert.NotEmpty(ticks);
        Assert.Contains(ticks, t => Math.Abs(t.Position - 0.0) < 1e-6);
        Assert.Contains(ticks, t => Math.Abs(t.Position - 10.0) < 1e-6);
        Assert.True(ticks.Count >= 4 && ticks.Count <= 8);
    }

    [Fact]
    public void TicksEngine_GeneratesLogTicks_ForMultiDecadeRange()
    {
        var ticks = TicksEngine.GenerateLogTicks(1e-2, 1e4);
        Assert.NotEmpty(ticks);
        Assert.Contains(ticks, t => t.Label == "10^-2");
        Assert.Contains(ticks, t => t.Label == "10^0");
        Assert.Contains(ticks, t => t.Label == "10^4");
    }

    [Fact]
    public void CoordinateTransform_LinearTransform_MapsCorrectly()
    {
        var tx = new CoordinateTransform(ScaleType.Linear, 0, 100, 50, 250);
        Assert.Equal(50f, tx.ToTarget(0));
        Assert.Equal(150f, tx.ToTarget(50));
        Assert.Equal(250f, tx.ToTarget(100));

        Assert.Equal(0.0, tx.ToData(50f), 4);
        Assert.Equal(50.0, tx.ToData(150f), 4);
        Assert.Equal(100.0, tx.ToData(250f), 4);
    }

    [Fact]
    public void CoordinateTransform_SIMDTransformSpan_MatchesScalar()
    {
        var tx = new CoordinateTransform(ScaleType.Linear, -50, 50, 0, 1000);
        float[] inData = new float[64];
        for (int i = 0; i < inData.Length; i++) inData[i] = -50f + i * (100f / 63f);

        float[] outSimd = new float[64];
        tx.TransformSpan(inData, outSimd);

        for (int i = 0; i < inData.Length; i++)
        {
            float scalarExpected = tx.ToTarget(inData[i]);
            Assert.Equal(scalarExpected, outSimd[i], 0.01f);
        }
    }

    [Fact]
    public void CoordinateTransform_SymLog_HandlesZeroAndNegativeValues()
    {
        var tx = new CoordinateTransform(ScaleType.SymLog, -1000, 1000, 0, 1000, linThresh: 1.0);
        float posAtZero = tx.ToTarget(0.0);
        float posAtPos = tx.ToTarget(100.0);
        float posAtNeg = tx.ToTarget(-100.0);

        Assert.True(posAtZero > posAtNeg);
        Assert.True(posAtPos > posAtZero);
        Assert.Equal(0.0, tx.ToData(posAtZero), 3);
    }

    [Fact]
    public void Figure_And_SubplotGrid_CalculatesCorrectDimensions()
    {
        var fig = Figure.Subplots(2, 2, widthInches: 8.0, heightInches: 6.0, dpi: 300f);
        Assert.Equal(2400, fig.PixelWidth);
        Assert.Equal(1800, fig.PixelHeight);
        Assert.NotNull(fig.SubplotsGrid);
        Assert.Equal(2, fig.SubplotsGrid.Rows);
        Assert.Equal(2, fig.SubplotsGrid.Columns);

        var (x, y, w, h) = fig.SubplotsGrid.GetCellRect(0, 0, fig.PixelWidth, fig.PixelHeight);
        Assert.True(w > 0 && h > 0);
        Assert.True(x >= fig.SubplotsGrid.LeftMargin);
    }
}
