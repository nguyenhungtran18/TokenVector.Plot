using System;
using System.Text;
using TokenVector.Plot.Core;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Charts.Base;

/// <summary>
/// Common contract for all renderable 2D/3D scientific and statistical plot elements.
/// </summary>
public interface IPlotElement
{
    string? Label { get; set; }
    bool Visible { get; set; }
    Color PrimaryColor { get; }

    /// <summary>
    /// Computes data bounding box (min/max) for automatic axis auto-scaling.
    /// </summary>
    void GetBounds(out double xMin, out double xMax, out double yMin, out double yMax);

    /// <summary>
    /// Renders vector graphics to SVG.
    /// </summary>
    void Render(SvgRenderer svg, CoordinateTransform tx, CoordinateTransform ty);

    /// <summary>
    /// Renders raster pixels with SIMD acceleration to raw frame-buffer.
    /// </summary>
    void Render(RasterRenderer raster, CoordinateTransform tx, CoordinateTransform ty);

    /// <summary>
    /// Appends WebGL / HTML5 interactive render script.
    /// </summary>
    void RenderWebGL(StringBuilder sb, CoordinateTransform tx, CoordinateTransform ty);
}
