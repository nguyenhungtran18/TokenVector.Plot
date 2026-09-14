using System;
using System.Collections.Generic;
using System.Numerics;
using TokenVector.Plot.Charts.Base;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Core;

/// <summary>
/// 3D Axes System supporting 3D Perspective &amp; Isometric camera projection,
/// 3D wireframe bounding box, and 3D surface plot elements.
/// </summary>
public sealed class Axes3D
{
    private readonly List<IPlotElement> _elements = new();
    public IReadOnlyList<IPlotElement> Elements => _elements;

    public float Azimuth { get; set; } = -60.0f; // degrees
    public float Elevation { get; set; } = 30.0f; // degrees
    public float Distance { get; set; } = 2.5f;

    public string? Title { get; set; }
    public string? XLabel { get; set; } = "X";
    public string? YLabel { get; set; } = "Y";
    public string? ZLabel { get; set; } = "Z";

    public double? XMin { get; set; }
    public double? XMax { get; set; }
    public double? YMin { get; set; }
    public double? YMax { get; set; }
    public double? ZMin { get; set; }
    public double? ZMax { get; set; }

    public void AddElement(IPlotElement element)
    {
        ArgumentNullException.ThrowIfNull(element);
        _elements.Add(element);
    }

    /// <summary>
    /// Computes View-Projection 4x4 matrix based on Azimuth &amp; Elevation angles.
    /// </summary>
    public Matrix4x4 ComputeViewProjectionMatrix(float screenWidth, float screenHeight)
    {
        float radAz = Azimuth * MathF.PI / 180.0f;
        float radEl = Elevation * MathF.PI / 180.0f;

        float camX = Distance * MathF.Cos(radEl) * MathF.Sin(radAz);
        float camY = Distance * MathF.Sin(radEl);
        float camZ = Distance * MathF.Cos(radEl) * MathF.Cos(radAz);

        var cameraPos = new Vector3(camX, camY, camZ);
        var target = Vector3.Zero;
        var up = Vector3.UnitY;

        var view = Matrix4x4.CreateLookAt(cameraPos, target, up);
        var proj = Matrix4x4.CreatePerspectiveFieldOfView(45.0f * MathF.PI / 180.0f, screenWidth / screenHeight, 0.1f, 100.0f);

        return view * proj;
    }

    /// <summary>
    /// Projects 3D point in [-1, 1] normalized cube space to 2D screen coordinates.
    /// </summary>
    public Vector3 ProjectPoint(Vector3 p3d, Matrix4x4 vpMatrix, float screenLeft, float screenTop, float screenWidth, float screenHeight)
    {
        var clip = Vector4.Transform(new Vector4(p3d, 1.0f), vpMatrix);
        if (MathF.Abs(clip.W) < 1e-6f) clip.W = 1.0f;

        float ndcX = clip.X / clip.W;
        float ndcY = clip.Y / clip.W;
        float ndcZ = clip.Z / clip.W;

        float screenX = screenLeft + (ndcX * 0.5f + 0.5f) * screenWidth;
        float screenY = screenTop + (-ndcY * 0.5f + 0.5f) * screenHeight;

        return new Vector3(screenX, screenY, ndcZ);
    }

    public void RenderRaster(RasterRenderer raster, StyleTheme theme, float x, float y, float width, float height)
    {
        raster.FillRect(x, y, width, height, theme.PlotAreaColor);
        var vp = ComputeViewProjectionMatrix(width, height);

        // 1. Draw 3D Wireframe Bounding Box
        Vector3[] cubeCorners = new Vector3[8]
        {
            new(-0.8f, -0.8f, -0.8f), new(0.8f, -0.8f, -0.8f),
            new(0.8f,  0.8f, -0.8f), new(-0.8f,  0.8f, -0.8f),
            new(-0.8f, -0.8f,  0.8f), new(0.8f, -0.8f,  0.8f),
            new(0.8f,  0.8f,  0.8f), new(-0.8f,  0.8f,  0.8f)
        };

        Vector3[] projCorners = new Vector3[8];
        for (int i = 0; i < 8; i++)
        {
            projCorners[i] = ProjectPoint(cubeCorners[i], vp, x, y, width, height);
        }

        // Draw 12 cube edges
        int[][] edges = new int[][]
        {
            new[]{0,1}, new[]{1,2}, new[]{2,3}, new[]{3,0},
            new[]{4,5}, new[]{5,6}, new[]{6,7}, new[]{7,4},
            new[]{0,4}, new[]{1,5}, new[]{2,6}, new[]{3,7}
        };

        foreach (var edge in edges)
        {
            var p0 = projCorners[edge[0]];
            var p1 = projCorners[edge[1]];
            raster.DrawLine(p0.X, p0.Y, p1.X, p1.Y, theme.GridColor, 1.0f);
        }

        // 2. Render 3D Plot Elements
        var tx = new CoordinateTransform(ScaleType.Linear, -1, 1, x, x + width);
        var ty = new CoordinateTransform(ScaleType.Linear, -1, 1, y, y + height);
        foreach (var elem in _elements)
        {
            if (elem.Visible)
            {
                elem.Render(raster, tx, ty);
            }
        }

        // 3. Draw Title & Axis Labels
        if (!string.IsNullOrEmpty(Title))
        {
            raster.DrawText(Title, x + width * 0.5f - Title.Length * 4f, y + 20f, theme.TitleColor, theme.TitleFontSize);
        }
    }

    public void RenderSvg(SvgRenderer svg, StyleTheme theme, float x, float y, float width, float height)
    {
        svg.DrawRect(x, y, width, height, theme.PlotAreaColor, theme.AxisColor, theme.AxisLineWidth);
        var vp = ComputeViewProjectionMatrix(width, height);

        Vector3[] cubeCorners = new Vector3[8]
        {
            new(-0.8f, -0.8f, -0.8f), new(0.8f, -0.8f, -0.8f),
            new(0.8f,  0.8f, -0.8f), new(-0.8f,  0.8f, -0.8f),
            new(-0.8f, -0.8f,  0.8f), new(0.8f, -0.8f,  0.8f),
            new(0.8f,  0.8f,  0.8f), new(-0.8f,  0.8f,  0.8f)
        };

        Vector3[] projCorners = new Vector3[8];
        for (int i = 0; i < 8; i++)
        {
            projCorners[i] = ProjectPoint(cubeCorners[i], vp, x, y, width, height);
        }

        int[][] edges = new int[][]
        {
            new[]{0,1}, new[]{1,2}, new[]{2,3}, new[]{3,0},
            new[]{4,5}, new[]{5,6}, new[]{6,7}, new[]{7,4},
            new[]{0,4}, new[]{1,5}, new[]{2,6}, new[]{3,7}
        };

        foreach (var edge in edges)
        {
            var p0 = projCorners[edge[0]];
            var p1 = projCorners[edge[1]];
            svg.DrawLine(p0.X, p0.Y, p1.X, p1.Y, theme.GridColor, 1.0f);
        }

        var tx = new CoordinateTransform(ScaleType.Linear, -1, 1, x, x + width);
        var ty = new CoordinateTransform(ScaleType.Linear, -1, 1, y, y + height);
        foreach (var elem in _elements)
        {
            if (elem.Visible)
            {
                elem.Render(svg, tx, ty);
            }
        }

        if (!string.IsNullOrEmpty(Title))
        {
            svg.DrawText(Title, x + width * 0.5f, y + 20f, theme.TitleColor, theme.TitleFontSize, "bold", theme.FontFamily, "middle");
        }
    }
}
