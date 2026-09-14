using System;
using System.IO;
using TokenVector.Plot.Charts.Statistical;
using TokenVector.Plot.Core;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;
using Xunit;

namespace TokenVector.Plot.Tests;

public class RenderTests
{
    [Fact]
    public void SvgRenderer_ProducesValidXmlSvgDocument()
    {
        var fig = Figure.Create(6.0, 4.0, 300f);
        fig.Title = "Test Figure SVG";
        fig.Theme = StyleTheme.Nature;

        float[] x = { 1, 2, 3, 4, 5 };
        float[] y = { 2, 4, 1, 5, 3 };
        var line = new LinePlot(x, y) { Label = "Series 1", Color = Color.Red };
        fig.Axes.AddElement(line);

        string svg = fig.ToSvgString();
        Assert.StartsWith("<?xml", svg);
        Assert.Contains("<svg", svg);
        Assert.Contains("Test Figure SVG", svg);
        Assert.Contains("</svg>", svg);
    }

    [Fact]
    public void RasterRenderer_ProducesValidPngWithPhysDpiChunk()
    {
        var fig = Figure.Create(4.0, 3.0, 600f); // 600 DPI publication quality
        fig.Title = "600 DPI PNG Test";
        fig.Theme = StyleTheme.Science;

        float[] x = { 0, 1, 2, 3 };
        float[] y = { 10, 20, 15, 30 };
        var line = new LinePlot(x, y) { Color = Color.Blue };
        fig.Axes.AddElement(line);

        byte[] png = fig.ToPngBytes();
        Assert.NotNull(png);
        Assert.True(png.Length > 64);

        // Verify PNG Header: 0x89, 'P', 'N', 'G', 0x0D, 0x0A, 0x1A, 0x0A
        Assert.Equal(0x89, png[0]);
        Assert.Equal((byte)'P', png[1]);
        Assert.Equal((byte)'N', png[2]);
        Assert.Equal((byte)'G', png[3]);

        // Verify pHYs chunk exists in byte stream
        bool hasPhys = false;
        for (int i = 0; i < png.Length - 4; i++)
        {
            if (png[i] == (byte)'p' && png[i + 1] == (byte)'H' && png[i + 2] == (byte)'Y' && png[i + 3] == (byte)'s')
            {
                hasPhys = true;
                break;
            }
        }
        Assert.True(hasPhys, "PNG file must contain pHYs chunk specifying 600 DPI physical pixel resolution.");
    }

    [Fact]
    public void HtmlCanvasRenderer_ProducesInteractiveHtmlUnder50KB()
    {
        var htmlRenderer = new HtmlCanvasRenderer(800, 600)
        {
            Title = "Interactive WebGL Plot"
        };

        float[] x = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
        float[] y = { 3, 5, 2, 8, 4, 7, 9, 6, 8, 10 };

        htmlRenderer.AddScatterData("Sensors", x, y, Color.Blue, 4.0f);
        htmlRenderer.AddLineData("Trend", x, y, Color.Red, 2.0f);

        string html = htmlRenderer.BuildHtml(StyleTheme.Dark);
        Assert.Contains("<!DOCTYPE html>", html);
        Assert.Contains("getContext('webgl')", html);
        Assert.Contains("Interactive WebGL Plot", html);

        int byteSize = System.Text.Encoding.UTF8.GetByteCount(html);
        Assert.True(byteSize < 50 * 1024, $"Payload size {byteSize} bytes exceeds 50KB limit.");
    }
}
