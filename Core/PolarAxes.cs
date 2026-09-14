using System;
using System.Collections.Generic;
using System.Globalization;
using TokenVector.Plot.Charts.Base;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Core;

/// <summary>
/// Polar Coordinate System Axes container.
/// Maps (Radius r, Angle Theta) to 2D screen coordinates with circular gridlines and radial spokes.
/// </summary>
public sealed class PolarAxes
{
    private readonly List<IPlotElement> _elements = new();
    public IReadOnlyList<IPlotElement> Elements => _elements;

    public string? Title { get; set; }
    public double? RMax { get; set; }
    public bool ShowGrid { get; set; } = true;

    public void AddElement(IPlotElement element)
    {
        ArgumentNullException.ThrowIfNull(element);
        _elements.Add(element);
    }

    public void RenderSvg(SvgRenderer svg, StyleTheme theme, float x, float y, float width, float height)
    {
        float cx = x + width * 0.5f;
        float cy = y + height * 0.5f;
        float radius = MathF.Min(width, height) * 0.42f;

        // Background circle
        svg.DrawCircle(cx, cy, radius, theme.PlotAreaColor, theme.AxisColor, theme.AxisLineWidth);

        if (ShowGrid)
        {
            // Concentric circle rings (e.g. 4 rings)
            for (int ring = 1; ring <= 4; ring++)
            {
                float r = radius * (ring / 4.0f);
                svg.DrawCircle(cx, cy, r, Color.Transparent, theme.GridColor, theme.GridLineWidth);
            }

            // Radial spokes (every 45 degrees)
            for (int deg = 0; deg < 360; deg += 45)
            {
                float rad = deg * MathF.PI / 180.0f;
                float ex = cx + radius * MathF.Cos(rad);
                float ey = cy - radius * MathF.Sin(rad);
                svg.DrawLine(cx, cy, ex, ey, theme.GridColor, theme.GridLineWidth);

                // Angle labels
                float labelRadius = radius + 12f;
                float lx = cx + labelRadius * MathF.Cos(rad);
                float ly = cy - labelRadius * MathF.Sin(rad) + 4f;
                svg.DrawText($"{deg}°", lx, ly, theme.TextColor, theme.TickLabelFontSize, "normal", theme.FontFamily, "middle");
            }
        }

        // Plot elements
        var tx = new CoordinateTransform(ScaleType.Linear, -radius, radius, cx - radius, cx + radius);
        var ty = new CoordinateTransform(ScaleType.Linear, -radius, radius, cy + radius, cy - radius);

        foreach (var elem in _elements)
        {
            if (elem.Visible)
            {
                elem.Render(svg, tx, ty);
            }
        }

        if (!string.IsNullOrEmpty(Title))
        {
            svg.DrawText(Title, cx, y - 10f, theme.TitleColor, theme.TitleFontSize, "bold", theme.FontFamily, "middle");
        }
    }

    public void RenderRaster(RasterRenderer raster, StyleTheme theme, float x, float y, float width, float height)
    {
        float cx = x + width * 0.5f;
        float cy = y + height * 0.5f;
        float radius = MathF.Min(width, height) * 0.42f;

        raster.FillCircle(cx, cy, radius, theme.PlotAreaColor);
        raster.DrawCircle(cx, cy, radius, theme.AxisColor);

        if (ShowGrid)
        {
            for (int ring = 1; ring <= 4; ring++)
            {
                float r = radius * (ring / 4.0f);
                raster.DrawCircle(cx, cy, r, theme.GridColor);
            }

            for (int deg = 0; deg < 360; deg += 45)
            {
                float rad = deg * MathF.PI / 180.0f;
                float ex = cx + radius * MathF.Cos(rad);
                float ey = cy - radius * MathF.Sin(rad);
                raster.DrawLine(cx, cy, ex, ey, theme.GridColor, theme.GridLineWidth);

                float labelRadius = radius + 12f;
                float lx = cx + labelRadius * MathF.Cos(rad);
                float ly = cy - labelRadius * MathF.Sin(rad);
                raster.DrawText($"{deg}°", lx - 8f, ly, theme.TextColor, theme.TickLabelFontSize);
            }
        }

        var tx = new CoordinateTransform(ScaleType.Linear, -radius, radius, cx - radius, cx + radius);
        var ty = new CoordinateTransform(ScaleType.Linear, -radius, radius, cy + radius, cy - radius);

        foreach (var elem in _elements)
        {
            if (elem.Visible)
            {
                elem.Render(raster, tx, ty);
            }
        }

        if (!string.IsNullOrEmpty(Title))
        {
            raster.DrawText(Title, cx - Title.Length * 4f, y - 10f, theme.TitleColor, theme.TitleFontSize);
        }
    }
}
