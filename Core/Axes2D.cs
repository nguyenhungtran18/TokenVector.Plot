using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using TokenVector.Plot.Charts.Base;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Core;

/// <summary>
/// 2D Cartesian Coordinate System Axes container.
/// Handles auto-scaling, Wilkinson/Talbot ticks, gridlines, spine drawing, and plot element dispatching.
/// </summary>
public sealed class Axes2D
{
    private readonly List<IPlotElement> _elements = new();
    public IReadOnlyList<IPlotElement> Elements => _elements;

    public string? Title { get; set; }
    public string? XLabel { get; set; }
    public string? YLabel { get; set; }

    public ScaleType XScale { get; set; } = ScaleType.Linear;
    public ScaleType YScale { get; set; } = ScaleType.Linear;

    public double? XMin { get; set; }
    public double? XMax { get; set; }
    public double? YMin { get; set; }
    public double? YMax { get; set; }

    public bool ShowGrid { get; set; } = true;
    public bool ShowSpines { get; set; } = true;
    public Legend Legend { get; } = new();

    public void AddElement(IPlotElement element)
    {
        ArgumentNullException.ThrowIfNull(element);
        _elements.Add(element);
    }

    public void ComputeBounds(out double xMin, out double xMax, out double yMin, out double yMax)
    {
        if (XMin.HasValue && XMax.HasValue && YMin.HasValue && YMax.HasValue)
        {
            xMin = XMin.Value;
            xMax = XMax.Value;
            yMin = YMin.Value;
            yMax = YMax.Value;
            return;
        }

        double calcXMin = double.MaxValue, calcXMax = double.MinValue;
        double calcYMin = double.MaxValue, calcYMax = double.MinValue;

        foreach (var elem in _elements)
        {
            if (!elem.Visible) continue;
            elem.GetBounds(out double exMin, out double exMax, out double eyMin, out double eyMax);
            if (exMin < calcXMin) calcXMin = exMin;
            if (exMax > calcXMax) calcXMax = exMax;
            if (eyMin < calcYMin) calcYMin = eyMin;
            if (eyMax > calcYMax) calcYMax = eyMax;
        }

        if (calcXMin == double.MaxValue)
        {
            calcXMin = 0.0; calcXMax = 1.0;
            calcYMin = 0.0; calcYMax = 1.0;
        }

        // Apply 5% margin padding if bounds not explicitly locked
        double xMargin = (calcXMax - calcXMin) * 0.05;
        if (xMargin <= 0) xMargin = 0.1;
        double yMargin = (calcYMax - calcYMin) * 0.05;
        if (yMargin <= 0) yMargin = 0.1;

        xMin = XMin ?? (calcXMin - xMargin);
        xMax = XMax ?? (calcXMax + xMargin);
        yMin = YMin ?? (calcYMin - yMargin);
        yMax = YMax ?? (calcYMax + yMargin);
    }

    public void RenderSvg(SvgRenderer svg, StyleTheme theme, float x, float y, float width, float height)
    {
        ComputeBounds(out double xMin, out double xMax, out double yMin, out double yMax);

        // Coordinate transforms
        var tx = new CoordinateTransform(XScale, xMin, xMax, x, x + width);
        var ty = new CoordinateTransform(YScale, yMin, yMax, y + height, y); // Invert Y (top is 0)

        // 1. Draw Plot Area Background
        svg.DrawRect(x, y, width, height, theme.PlotAreaColor, theme.AxisColor, theme.AxisLineWidth);

        // 2. Generate and Render Ticks & Gridlines
        var xTicks = XScale == ScaleType.Log10 ? TicksEngine.GenerateLogTicks(xMin, xMax) : TicksEngine.GenerateTicks(xMin, xMax);
        var yTicks = YScale == ScaleType.Log10 ? TicksEngine.GenerateLogTicks(yMin, yMax) : TicksEngine.GenerateTicks(yMin, yMax);

        if (ShowGrid && theme.ShowMajorGrid)
        {
            foreach (var xt in xTicks)
            {
                if (xt.Position < xMin || xt.Position > xMax) continue;
                float px = tx.ToTarget(xt.Position);
                svg.DrawLine(px, y, px, y + height, theme.GridColor, theme.GridLineWidth);
            }
            foreach (var yt in yTicks)
            {
                if (yt.Position < yMin || yt.Position > yMax) continue;
                float py = ty.ToTarget(yt.Position);
                svg.DrawLine(x, py, x + width, py, theme.GridColor, theme.GridLineWidth);
            }
        }

        // 3. Draw Plot Elements with Clipping
        string clipId = $"clip_{Guid.NewGuid():N}";
        svg.BeginClip(clipId, x, y, width, height);
        foreach (var elem in _elements)
        {
            if (elem.Visible)
            {
                elem.Render(svg, tx, ty);
            }
        }
        svg.EndClip();

        // 4. Draw Spines & Outer Border
        if (ShowSpines)
        {
            svg.DrawRect(x, y, width, height, Color.Transparent, theme.AxisColor, theme.AxisLineWidth);
        }

        // 5. Draw Tick Marks & Tick Labels
        foreach (var xt in xTicks)
        {
            if (xt.Position < xMin || xt.Position > xMax) continue;
            float px = tx.ToTarget(xt.Position);
            svg.DrawLine(px, y + height, px, y + height + 5f, theme.AxisColor, theme.AxisLineWidth);
            if (!string.IsNullOrEmpty(xt.Label))
            {
                svg.DrawText(xt.Label, px, y + height + 16f, theme.TextColor, theme.TickLabelFontSize, "normal", theme.FontFamily, "middle");
            }
        }

        foreach (var yt in yTicks)
        {
            if (yt.Position < yMin || yt.Position > yMax) continue;
            float py = ty.ToTarget(yt.Position);
            svg.DrawLine(x - 5f, py, x, py, theme.AxisColor, theme.AxisLineWidth);
            if (!string.IsNullOrEmpty(yt.Label))
            {
                svg.DrawText(yt.Label, x - 8f, py + 4f, theme.TextColor, theme.TickLabelFontSize, "normal", theme.FontFamily, "end");
            }
        }

        // 6. Draw Labels & Title
        if (!string.IsNullOrEmpty(Title))
        {
            svg.DrawText(Title, x + width * 0.5f, y - 12f, theme.TitleColor, theme.TitleFontSize, "bold", theme.FontFamily, "middle");
        }

        if (!string.IsNullOrEmpty(XLabel))
        {
            svg.DrawText(XLabel, x + width * 0.5f, y + height + 36f, theme.TextColor, theme.AxisLabelFontSize, "bold", theme.FontFamily, "middle");
        }

        if (!string.IsNullOrEmpty(YLabel))
        {
            svg.DrawText(YLabel, x - 42f, y + height * 0.5f, theme.TextColor, theme.AxisLabelFontSize, "bold", theme.FontFamily, "middle", -90f);
        }

        // 7. Render Legend
        Legend.Render(svg, theme, _elements, x, y, width, height);
    }

    public void RenderRaster(RasterRenderer raster, StyleTheme theme, float x, float y, float width, float height)
    {
        ComputeBounds(out double xMin, out double xMax, out double yMin, out double yMax);

        var tx = new CoordinateTransform(XScale, xMin, xMax, x, x + width);
        var ty = new CoordinateTransform(YScale, yMin, yMax, y + height, y);

        // 1. Draw Plot Area Background
        raster.FillRect(x, y, width, height, theme.PlotAreaColor);
        raster.DrawRect(x, y, width, height, theme.AxisColor, theme.AxisLineWidth);

        // 2. Ticks & Gridlines
        var xTicks = XScale == ScaleType.Log10 ? TicksEngine.GenerateLogTicks(xMin, xMax) : TicksEngine.GenerateTicks(xMin, xMax);
        var yTicks = YScale == ScaleType.Log10 ? TicksEngine.GenerateLogTicks(yMin, yMax) : TicksEngine.GenerateTicks(yMin, yMax);

        if (ShowGrid && theme.ShowMajorGrid)
        {
            foreach (var xt in xTicks)
            {
                if (xt.Position < xMin || xt.Position > xMax) continue;
                float px = tx.ToTarget(xt.Position);
                raster.DrawLine(px, y, px, y + height, theme.GridColor, theme.GridLineWidth);
            }
            foreach (var yt in yTicks)
            {
                if (yt.Position < yMin || yt.Position > yMax) continue;
                float py = ty.ToTarget(yt.Position);
                raster.DrawLine(x, py, x + width, py, theme.GridColor, theme.GridLineWidth);
            }
        }

        // 3. Render Plot Elements
        foreach (var elem in _elements)
        {
            if (elem.Visible)
            {
                elem.Render(raster, tx, ty);
            }
        }

        // 4. Spines & Tick Marks
        if (ShowSpines)
        {
            raster.DrawRect(x, y, width, height, theme.AxisColor, theme.AxisLineWidth);
        }

        foreach (var xt in xTicks)
        {
            if (xt.Position < xMin || xt.Position > xMax) continue;
            float px = tx.ToTarget(xt.Position);
            raster.DrawLine(px, y + height, px, y + height + 5f, theme.AxisColor, theme.AxisLineWidth);
            if (!string.IsNullOrEmpty(xt.Label))
            {
                raster.DrawText(xt.Label, px - xt.Label.Length * 3f, y + height + 16f, theme.TextColor, theme.TickLabelFontSize);
            }
        }

        foreach (var yt in yTicks)
        {
            if (yt.Position < yMin || yt.Position > yMax) continue;
            float py = ty.ToTarget(yt.Position);
            raster.DrawLine(x - 5f, py, x, py, theme.AxisColor, theme.AxisLineWidth);
            if (!string.IsNullOrEmpty(yt.Label))
            {
                raster.DrawText(yt.Label, x - 8f - yt.Label.Length * 6f, py + 4f, theme.TextColor, theme.TickLabelFontSize);
            }
        }

        // 5. Title & Labels
        if (!string.IsNullOrEmpty(Title))
        {
            raster.DrawText(Title, x + width * 0.5f - Title.Length * 4f, y - 10f, theme.TitleColor, theme.TitleFontSize);
        }
        if (!string.IsNullOrEmpty(XLabel))
        {
            raster.DrawText(XLabel, x + width * 0.5f - XLabel.Length * 3.5f, y + height + 32f, theme.TextColor, theme.AxisLabelFontSize);
        }
        if (!string.IsNullOrEmpty(YLabel))
        {
            raster.DrawText(YLabel, x - 40f, y + height * 0.5f, theme.TextColor, theme.AxisLabelFontSize);
        }

        // 6. Legend
        Legend.Render(raster, theme, _elements, x, y, width, height);
    }
}
