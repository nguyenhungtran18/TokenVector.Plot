using System;
using System.Numerics;
using System.Text;
using TokenVector.Plot.Charts.Base;
using TokenVector.Plot.Core;
using TokenVector.Plot.Renderers;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Charts.Scientific;

/// <summary>
/// 3D Multivariate Surface Plot $z = f(x, y)$ with Phong Lighting (Ambient, Diffuse, Specular)
/// and memory-based Z-Buffer hidden surface removal.
/// </summary>
public sealed class Surface3DPlot : IPlotElement
{
    private readonly float[,] _zGrid;
    private readonly int _nx;
    private readonly int _ny;
    private readonly double _xMin;
    private readonly double _xMax;
    private readonly double _yMin;
    private readonly double _yMax;
    private readonly float _zMin;
    private readonly float _zMax;

    public string? Label { get; set; }
    public bool Visible { get; set; } = true;
    public Color PrimaryColor => Color;
    public Color Color { get; set; } = Color.Blue;
    public ColorMap ColorMap { get; set; } = ColorMap.Viridis;
    public bool Wireframe { get; set; } = false;

    // Phong Lighting Parameters
    public Vector3 LightDirection { get; set; } = Vector3.Normalize(new Vector3(1.0f, 2.0f, 1.5f));
    public float AmbientIntensity { get; set; } = 0.25f;
    public float DiffuseIntensity { get; set; } = 0.65f;
    public float SpecularIntensity { get; set; } = 0.30f;
    public float Shininess { get; set; } = 16.0f;

    public Surface3DPlot(float[,] zGrid, double xMin = -2, double xMax = 2, double yMin = -2, double yMax = 2)
    {
        ArgumentNullException.ThrowIfNull(zGrid);
        _nx = zGrid.GetLength(0);
        _ny = zGrid.GetLength(1);
        if (_nx < 2 || _ny < 2) throw new ArgumentException("Surface grid must be at least 2x2.");

        _zGrid = zGrid;
        _xMin = xMin;
        _xMax = xMax;
        _yMin = yMin;
        _yMax = yMax;

        float minZ = float.MaxValue;
        float maxZ = float.MinValue;
        for (int i = 0; i < _nx; i++)
        {
            for (int j = 0; j < _ny; j++)
            {
                float val = zGrid[i, j];
                if (val < minZ) minZ = val;
                if (val > maxZ) maxZ = val;
            }
        }
        _zMin = minZ;
        _zMax = MathF.Abs(maxZ - minZ) < 1e-6f ? minZ + 1.0f : maxZ;
    }

    public void GetBounds(out double xMin, out double xMax, out double yMin, out double yMax)
    {
        xMin = _xMin; xMax = _xMax;
        yMin = _yMin; yMax = _yMax;
    }

    public void Render(RasterRenderer raster, CoordinateTransform tx, CoordinateTransform ty)
    {
        // 3D mesh rendering with Phong lighting
        float dx = (float)((_xMax - _xMin) / (_nx - 1));
        float dy = (float)((_yMax - _yMin) / (_ny - 1));

        float xCenter = (float)((_xMin + _xMax) * 0.5);
        float yCenter = (float)((_yMin + _yMax) * 0.5);
        float zCenter = (_zMin + _zMax) * 0.5f;

        float xSpan = (float)(_xMax - _xMin);
        float ySpan = (float)(_yMax - _yMin);
        float zSpan = _zMax - _zMin;
        float maxSpan = MathF.Max(xSpan, MathF.Max(ySpan, zSpan));
        if (maxSpan < 1e-6f) maxSpan = 1.0f;

        float invSpan = 1.6f / maxSpan; // Fit to [-0.8, 0.8] cube

        // Precompute 3D vertex positions and normals
        var vertices = new Vector3[_nx, _ny];
        var normals = new Vector3[_nx, _ny];
        var colors = new Color[_nx, _ny];

        for (int i = 0; i < _nx; i++)
        {
            float wx = (float)(_xMin + i * dx);
            float normX = (wx - xCenter) * invSpan;

            for (int j = 0; j < _ny; j++)
            {
                float wy = (float)(_yMin + j * dy);
                float wz = _zGrid[i, j];

                float normY = (wz - zCenter) * invSpan; // Z is height
                float normZ = (wy - yCenter) * invSpan;

                vertices[i, j] = new Vector3(normX, normY, normZ);

                // Sample color from colormap
                float normZColor = (wz - _zMin) / (_zMax - _zMin);
                colors[i, j] = ColorMap.Sample(normZColor);
            }
        }

        // Compute Vertex Normals
        for (int i = 0; i < _nx; i++)
        {
            for (int j = 0; j < _ny; j++)
            {
                int iPrev = Math.Max(0, i - 1);
                int iNext = Math.Min(_nx - 1, i + 1);
                int jPrev = Math.Max(0, j - 1);
                int jNext = Math.Min(_ny - 1, j + 1);

                var dU = vertices[iNext, j] - vertices[iPrev, j];
                var dV = vertices[i, jNext] - vertices[i, jPrev];

                var n = Vector3.Cross(dV, dU);
                normals[i, j] = n.LengthSquared() > 1e-6f ? Vector3.Normalize(n) : Vector3.UnitY;
            }
        }

        // Project vertices
        var axes3d = new Axes3D();
        var vp = axes3d.ComputeViewProjectionMatrix(raster.Width, raster.Height);

        var projVertices = new Vector3[_nx, _ny];
        var litColors = new Color[_nx, _ny];

        var viewDir = Vector3.Normalize(new Vector3(0, 0, 1)); // Approximate view dir

        for (int i = 0; i < _nx; i++)
        {
            for (int j = 0; j < _ny; j++)
            {
                projVertices[i, j] = axes3d.ProjectPoint(vertices[i, j], vp, 0, 0, raster.Width, raster.Height);

                // Apply Phong Lighting
                var n = normals[i, j];
                float diff = MathF.Max(0.0f, Vector3.Dot(n, LightDirection));

                var reflectDir = Vector3.Reflect(-LightDirection, n);
                float spec = MathF.Pow(MathF.Max(0.0f, Vector3.Dot(viewDir, reflectDir)), Shininess);

                float intensity = AmbientIntensity + DiffuseIntensity * diff + SpecularIntensity * spec;
                intensity = Math.Clamp(intensity, 0.0f, 1.0f);

                var baseCol = colors[i, j];
                byte r = (byte)Math.Min(255, (int)(baseCol.R * intensity));
                byte g = (byte)Math.Min(255, (int)(baseCol.G * intensity));
                byte b = (byte)Math.Min(255, (int)(baseCol.B * intensity));

                litColors[i, j] = new Color(r, g, b, 255);
            }
        }

        // Draw Mesh Triangles with Z-Buffer
        for (int i = 0; i < _nx - 1; i++)
        {
            for (int j = 0; j < _ny - 1; j++)
            {
                var p00 = projVertices[i, j];
                var p10 = projVertices[i + 1, j];
                var p11 = projVertices[i + 1, j + 1];
                var p01 = projVertices[i, j + 1];

                var c00 = litColors[i, j];
                var c10 = litColors[i + 1, j];
                var c11 = litColors[i + 1, j + 1];
                var c01 = litColors[i, j + 1];

                if (Wireframe)
                {
                    raster.DrawLine(p00.X, p00.Y, p10.X, p10.Y, c00);
                    raster.DrawLine(p10.X, p10.Y, p11.X, p11.Y, c10);
                    raster.DrawLine(p11.X, p11.Y, p01.X, p01.Y, c11);
                    raster.DrawLine(p01.X, p01.Y, p00.X, p00.Y, c01);
                }
                else
                {
                    // Triangle 1: (p00, p10, p11)
                    raster.FillTriangle3D(p00, p10, p11, c00, c10, c11);
                    // Triangle 2: (p00, p11, p01)
                    raster.FillTriangle3D(p00, p11, p01, c00, c11, c01);
                }
            }
        }
    }

    public void Render(SvgRenderer svg, CoordinateTransform tx, CoordinateTransform ty)
    {
        // Vector projection wireframe
        float dx = (float)((_xMax - _xMin) / (_nx - 1));
        float dy = (float)((_yMax - _yMin) / (_ny - 1));

        var axes3d = new Axes3D();
        var vp = axes3d.ComputeViewProjectionMatrix(svg.Width, svg.Height);

        for (int i = 0; i < _nx - 1; i++)
        {
            for (int j = 0; j < _ny - 1; j++)
            {
                float x0 = (float)(_xMin + i * dx);
                float y0 = (float)(_yMin + j * dy);
                float z0 = _zGrid[i, j];

                float normZ = (z0 - _zMin) / (_zMax - _zMin);
                Color color = ColorMap.Sample(normZ);

                var p0 = axes3d.ProjectPoint(new Vector3(x0, z0, y0), vp, 0, 0, svg.Width, svg.Height);
                var p1 = axes3d.ProjectPoint(new Vector3(x0 + dx, _zGrid[i + 1, j], y0), vp, 0, 0, svg.Width, svg.Height);

                svg.DrawLine(p0.X, p0.Y, p1.X, p1.Y, color, 1.0f);
            }
        }
    }

    public void RenderWebGL(StringBuilder sb, CoordinateTransform tx, CoordinateTransform ty)
    {
    }
}
