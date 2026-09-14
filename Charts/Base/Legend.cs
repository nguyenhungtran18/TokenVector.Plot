using System;
using System.Collections.Generic;
using System.Text;
using TokenVector.Plot.Core;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Charts.Base;

public enum LegendLocation
{
    TopRight,
    TopLeft,
    BottomRight,
    BottomLeft,
    OutsideRight
}

/// <summary>
/// Scientific chart legend component with automatic item discovery and positioning.
/// </summary>
public sealed class Legend
{
    public bool Visible { get; set; } = true;
    public LegendLocation Location { get; set; } = LegendLocation.TopRight;
    public string? Title { get; set; }
    public float FontSize { get; set; } = 10f;
    public float Padding { get; set; } = 8f;
    public float ItemSpacing { get; set; } = 6f;

    public void Render(SvgRenderer svg, StyleTheme theme, IReadOnlyList<IPlotElement> elements, float plotLeft, float plotTop, float plotWidth, float plotHeight)
    {
        if (!Visible) return;

        var legendItems = new List<(string Label, Color Color)>();
        foreach (var elem in elements)
        {
            if (elem.Visible && !string.IsNullOrWhiteSpace(elem.Label))
            {
                legendItems.Add((elem.Label, elem.PrimaryColor));
            }
        }

        if (legendItems.Count == 0) return;

        float charWidth = FontSize * 0.6f;
        float maxTextWidth = 0;
        foreach (var item in legendItems)
        {
            float w = item.Label.Length * charWidth;
            if (w > maxTextWidth) maxTextWidth = w;
        }

        float boxWidth = maxTextWidth + 35f + Padding * 2;
        float boxHeight = (legendItems.Count * (FontSize + ItemSpacing)) + Padding * 2;

        float boxX = Location switch
        {
            LegendLocation.TopLeft => plotLeft + 15f,
            LegendLocation.BottomLeft => plotLeft + 15f,
            LegendLocation.BottomRight => plotLeft + plotWidth - boxWidth - 15f,
            LegendLocation.OutsideRight => plotLeft + plotWidth + 15f,
            _ => plotLeft + plotWidth - boxWidth - 15f // TopRight
        };

        float boxY = Location switch
        {
            LegendLocation.BottomLeft or LegendLocation.BottomRight => plotTop + plotHeight - boxHeight - 15f,
            _ => plotTop + 15f
        };

        // Draw Legend Background Box
        svg.DrawRect(boxX, boxY, boxWidth, boxHeight, theme.LegendBackground, theme.LegendBorder, 1.0f, 3f);

        // Draw Legend Items
        float itemY = boxY + Padding + FontSize * 0.8f;
        foreach (var item in legendItems)
        {
            float markerX = boxX + Padding;
            float markerY = itemY - FontSize * 0.35f;

            // Marker line / dot
            svg.DrawLine(markerX, markerY, markerX + 16f, markerY, item.Color, 2.5f);
            svg.DrawCircle(markerX + 8f, markerY, 3.5f, item.Color, item.Color, 0f);

            // Text
            svg.DrawText(item.Label, markerX + 22f, itemY, theme.TextColor, FontSize, "normal", "Helvetica, Arial, sans-serif", "start");

            itemY += FontSize + ItemSpacing;
        }
    }

    public void Render(RasterRenderer raster, StyleTheme theme, IReadOnlyList<IPlotElement> elements, float plotLeft, float plotTop, float plotWidth, float plotHeight)
    {
        if (!Visible) return;

        var legendItems = new List<(string Label, Color Color)>();
        foreach (var elem in elements)
        {
            if (elem.Visible && !string.IsNullOrWhiteSpace(elem.Label))
            {
                legendItems.Add((elem.Label, elem.PrimaryColor));
            }
        }

        if (legendItems.Count == 0) return;

        float charWidth = FontSize * 0.6f;
        float maxTextWidth = 0;
        foreach (var item in legendItems)
        {
            float w = item.Label.Length * charWidth;
            if (w > maxTextWidth) maxTextWidth = w;
        }

        float boxWidth = maxTextWidth + 35f + Padding * 2;
        float boxHeight = (legendItems.Count * (FontSize + ItemSpacing)) + Padding * 2;

        float boxX = Location switch
        {
            LegendLocation.TopLeft => plotLeft + 15f,
            LegendLocation.BottomLeft => plotLeft + 15f,
            LegendLocation.BottomRight => plotLeft + plotWidth - boxWidth - 15f,
            LegendLocation.OutsideRight => plotLeft + plotWidth + 15f,
            _ => plotLeft + plotWidth - boxWidth - 15f
        };

        float boxY = Location switch
        {
            LegendLocation.BottomLeft or LegendLocation.BottomRight => plotTop + plotHeight - boxHeight - 15f,
            _ => plotTop + 15f
        };

        raster.FillRect(boxX, boxY, boxWidth, boxHeight, theme.LegendBackground);
        raster.DrawRect(boxX, boxY, boxWidth, boxHeight, theme.LegendBorder, 1.0f);

        float itemY = boxY + Padding + FontSize * 0.8f;
        foreach (var item in legendItems)
        {
            float markerX = boxX + Padding;
            float markerY = itemY - FontSize * 0.35f;

            raster.DrawLine(markerX, markerY, markerX + 16f, markerY, item.Color, 2.5f);
            raster.FillCircle(markerX + 8f, markerY, 3.5f, item.Color);

            raster.DrawText(item.Label, markerX + 22f, itemY, theme.TextColor, FontSize);
            itemY += FontSize + ItemSpacing;
        }
    }
}
