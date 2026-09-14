using System;
using System.IO;
using System.Text;
using TokenVector.Plot.Charts.Base;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Core;

/// <summary>
/// Top-level Figure container managing canvas dimensions (Inches, Pixels, DPI),
/// active themes, subplots, and multi-format exporters (SVG, PNG, HTML5/WebGL).
/// </summary>
public sealed class Figure
{
    public double WidthInches { get; }
    public double HeightInches { get; }
    public float Dpi { get; set; }

    public int PixelWidth => (int)Math.Round(WidthInches * Dpi);
    public int PixelHeight => (int)Math.Round(HeightInches * Dpi);

    public StyleTheme Theme { get; set; } = StyleTheme.Science;
    public string? Title { get; set; }

    public Axes2D Axes { get; }
    public SubplotGrid? SubplotsGrid { get; }

    public float LeftMargin { get; set; } = 70f;
    public float RightMargin { get; set; } = 30f;
    public float TopMargin { get; set; } = 50f;
    public float BottomMargin { get; set; } = 60f;

    public Figure(double widthInches = 6.4, double heightInches = 4.8, float dpi = 300f)
    {
        ArgumentOutOfRangeException.ThrowIfNegativeOrZero(widthInches);
        ArgumentOutOfRangeException.ThrowIfNegativeOrZero(heightInches);
        ArgumentOutOfRangeException.ThrowIfNegativeOrZero(dpi);

        WidthInches = widthInches;
        HeightInches = heightInches;
        Dpi = dpi;
        Axes = new Axes2D();
    }

    public Figure(SubplotGrid grid, double widthInches = 8.0, double heightInches = 6.0, float dpi = 300f)
    {
        ArgumentNullException.ThrowIfNull(grid);
        WidthInches = widthInches;
        HeightInches = heightInches;
        Dpi = dpi;
        SubplotsGrid = grid;
        Axes = grid[0, 0];
    }

    public static Figure Create(double widthInches = 6.4, double heightInches = 4.8, float dpi = 300f) =>
        new(widthInches, heightInches, dpi);

    public static Figure Subplots(int rows, int cols, double widthInches = 8.0, double heightInches = 6.0, float dpi = 300f)
    {
        var grid = new SubplotGrid(rows, cols);
        return new Figure(grid, widthInches, heightInches, dpi);
    }

    #region Exporting Methods

    public string ToSvgString()
    {
        int w = PixelWidth;
        int h = PixelHeight;
        var svg = new SvgRenderer(w, h, Dpi);

        // Draw Figure Background
        svg.DrawRect(0, 0, w, h, Theme.BackgroundColor, Color.Transparent, 0f);

        if (!string.IsNullOrEmpty(Title))
        {
            svg.DrawText(Title, w * 0.5f, TopMargin * 0.5f, Theme.TitleColor, Theme.TitleFontSize + 2f, "bold", Theme.FontFamily, "middle");
        }

        if (SubplotsGrid != null)
        {
            SubplotsGrid.RenderSvg(svg, Theme, w, h);
        }
        else
        {
            float plotLeft = LeftMargin;
            float plotTop = TopMargin;
            float plotWidth = w - LeftMargin - RightMargin;
            float plotHeight = h - TopMargin - BottomMargin;
            Axes.RenderSvg(svg, Theme, plotLeft, plotTop, plotWidth, plotHeight);
        }

        return svg.Build();
    }

    public void SaveSvg(string filePath)
    {
        string svg = ToSvgString();
        File.WriteAllText(filePath, svg, Encoding.UTF8);
    }

    public byte[] ToPngBytes()
    {
        int w = PixelWidth;
        int h = PixelHeight;
        using var raster = new RasterRenderer(w, h, Dpi);

        raster.Clear(Theme.BackgroundColor);

        if (!string.IsNullOrEmpty(Title))
        {
            raster.DrawText(Title, w * 0.5f - Title.Length * 5f, TopMargin * 0.5f, Theme.TitleColor, Theme.TitleFontSize + 2f);
        }

        if (SubplotsGrid != null)
        {
            SubplotsGrid.RenderRaster(raster, Theme, w, h);
        }
        else
        {
            float plotLeft = LeftMargin;
            float plotTop = TopMargin;
            float plotWidth = w - LeftMargin - RightMargin;
            float plotHeight = h - TopMargin - BottomMargin;
            Axes.RenderRaster(raster, Theme, plotLeft, plotTop, plotWidth, plotHeight);
        }

        return raster.ToPngBytes();
    }

    public void SavePng(string filePath)
    {
        byte[] bytes = ToPngBytes();
        File.WriteAllBytes(filePath, bytes);
    }

    public string ToHtmlString()
    {
        var html = new HtmlCanvasRenderer(PixelWidth, PixelHeight)
        {
            Title = Title ?? "TokenVector Interactive Visualization"
        };
        return html.BuildHtml(Theme);
    }

    public void SaveHtml(string filePath)
    {
        string html = ToHtmlString();
        File.WriteAllText(filePath, html, Encoding.UTF8);
    }

    #endregion
}
