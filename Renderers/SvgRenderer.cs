using System;
using System.Globalization;
using System.IO;
using System.Text;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Renderers;

/// <summary>
/// High-performance Vector SVG Renderer generating publication-ready vector XML files.
/// Standards-compliant with W3C SVG 1.1 / 2.0.
/// </summary>
public sealed class SvgRenderer
{
    private readonly StringBuilder _sb;
    public float Width { get; }
    public float Height { get; }
    public float Dpi { get; }

    public SvgRenderer(float width, float height, float dpi = 300f)
    {
        Width = width;
        Height = height;
        Dpi = dpi;
        _sb = new StringBuilder(16384);
        WriteHeader();
    }

    private void WriteHeader()
    {
        _sb.AppendLine("<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"no\"?>");
        _sb.AppendLine("<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">");
        _sb.Append("<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" ");
        _sb.Append(CultureInfo.InvariantCulture, $"width=\"{Width}px\" height=\"{Height}px\" viewBox=\"0 0 {Width} {Height}\" version=\"1.1\">");
        _sb.AppendLine();
    }

    public void BeginClip(string clipId, float x, float y, float width, float height)
    {
        _sb.AppendLine("<defs>");
        _sb.Append(CultureInfo.InvariantCulture, $"  <clipPath id=\"{clipId}\"><rect x=\"{x:0.##}\" y=\"{y:0.##}\" width=\"{width:0.##}\" height=\"{height:0.##}\" /></clipPath>");
        _sb.AppendLine();
        _sb.AppendLine("</defs>");
        _sb.Append(CultureInfo.InvariantCulture, $"<g clip-path=\"url(#{clipId})\">");
        _sb.AppendLine();
    }

    public void EndClip()
    {
        _sb.AppendLine("</g>");
    }

    public void DrawLine(float x1, float y1, float x2, float y2, Color color, float strokeWidth = 1.0f, string? dashArray = null)
    {
        if (color.A == 0) return;
        _sb.Append(CultureInfo.InvariantCulture, $"<line x1=\"{x1:0.##}\" y1=\"{y1:0.##}\" x2=\"{x2:0.##}\" y2=\"{y2:0.##}\" ");
        _sb.Append(CultureInfo.InvariantCulture, $"stroke=\"{color.ToHexString()}\" stroke-width=\"{strokeWidth:0.##}\" ");
        if (color.A < 255)
        {
            _sb.Append(CultureInfo.InvariantCulture, $"stroke-opacity=\"{(color.A / 255.0f):0.###}\" ");
        }
        if (!string.IsNullOrEmpty(dashArray))
        {
            _sb.Append(CultureInfo.InvariantCulture, $"stroke-dasharray=\"{dashArray}\" ");
        }
        _sb.AppendLine("stroke-linecap=\"round\" />");
    }

    public void DrawRect(float x, float y, float width, float height, Color fill, Color stroke, float strokeWidth = 1.0f, float rx = 0f)
    {
        _sb.Append(CultureInfo.InvariantCulture, $"<rect x=\"{x:0.##}\" y=\"{y:0.##}\" width=\"{width:0.##}\" height=\"{height:0.##}\" ");
        if (rx > 0) _sb.Append(CultureInfo.InvariantCulture, $"rx=\"{rx:0.##}\" ");

        if (fill.A > 0)
        {
            _sb.Append(CultureInfo.InvariantCulture, $"fill=\"{fill.ToHexString()}\" ");
            if (fill.A < 255) _sb.Append(CultureInfo.InvariantCulture, $"fill-opacity=\"{(fill.A / 255.0f):0.###}\" ");
        }
        else
        {
            _sb.Append("fill=\"none\" ");
        }

        if (stroke.A > 0 && strokeWidth > 0)
        {
            _sb.Append(CultureInfo.InvariantCulture, $"stroke=\"{stroke.ToHexString()}\" stroke-width=\"{strokeWidth:0.##}\" ");
            if (stroke.A < 255) _sb.Append(CultureInfo.InvariantCulture, $"stroke-opacity=\"{(stroke.A / 255.0f):0.###}\" ");
        }
        else
        {
            _sb.Append("stroke=\"none\" ");
        }

        _sb.AppendLine("/>");
    }

    public void DrawCircle(float cx, float cy, float r, Color fill, Color stroke, float strokeWidth = 1.0f)
    {
        _sb.Append(CultureInfo.InvariantCulture, $"<circle cx=\"{cx:0.##}\" cy=\"{cy:0.##}\" r=\"{r:0.##}\" ");
        if (fill.A > 0)
        {
            _sb.Append(CultureInfo.InvariantCulture, $"fill=\"{fill.ToHexString()}\" ");
            if (fill.A < 255) _sb.Append(CultureInfo.InvariantCulture, $"fill-opacity=\"{(fill.A / 255.0f):0.###}\" ");
        }
        else
        {
            _sb.Append("fill=\"none\" ");
        }

        if (stroke.A > 0 && strokeWidth > 0)
        {
            _sb.Append(CultureInfo.InvariantCulture, $"stroke=\"{stroke.ToHexString()}\" stroke-width=\"{strokeWidth:0.##}\" ");
            if (stroke.A < 255) _sb.Append(CultureInfo.InvariantCulture, $"stroke-opacity=\"{(stroke.A / 255.0f):0.###}\" ");
        }
        _sb.AppendLine("/>");
    }

    public void DrawPolyline(ReadOnlySpan<float> xCoords, ReadOnlySpan<float> yCoords, Color stroke, float strokeWidth = 1.5f, string? dashArray = null)
    {
        if (xCoords.Length < 2 || stroke.A == 0) return;
        _sb.Append("<polyline points=\"");
        int count = Math.Min(xCoords.Length, yCoords.Length);
        for (int i = 0; i < count; i++)
        {
            _sb.Append(CultureInfo.InvariantCulture, $"{xCoords[i]:0.##},{yCoords[i]:0.##} ");
        }
        _sb.Append(CultureInfo.InvariantCulture, $"\" fill=\"none\" stroke=\"{stroke.ToHexString()}\" stroke-width=\"{strokeWidth:0.##}\" ");
        if (stroke.A < 255) _sb.Append(CultureInfo.InvariantCulture, $"stroke-opacity=\"{(stroke.A / 255.0f):0.###}\" ");
        if (!string.IsNullOrEmpty(dashArray)) _sb.Append(CultureInfo.InvariantCulture, $"stroke-dasharray=\"{dashArray}\" ");
        _sb.AppendLine("stroke-linejoin=\"round\" stroke-linecap=\"round\" />");
    }

    public void DrawPolygon(ReadOnlySpan<float> xCoords, ReadOnlySpan<float> yCoords, Color fill, Color stroke, float strokeWidth = 1.0f)
    {
        if (xCoords.Length < 3) return;
        _sb.Append("<polygon points=\"");
        int count = Math.Min(xCoords.Length, yCoords.Length);
        for (int i = 0; i < count; i++)
        {
            _sb.Append(CultureInfo.InvariantCulture, $"{xCoords[i]:0.##},{yCoords[i]:0.##} ");
        }
        _sb.Append("\" ");

        if (fill.A > 0)
        {
            _sb.Append(CultureInfo.InvariantCulture, $"fill=\"{fill.ToHexString()}\" ");
            if (fill.A < 255) _sb.Append(CultureInfo.InvariantCulture, $"fill-opacity=\"{(fill.A / 255.0f):0.###}\" ");
        }
        else
        {
            _sb.Append("fill=\"none\" ");
        }

        if (stroke.A > 0 && strokeWidth > 0)
        {
            _sb.Append(CultureInfo.InvariantCulture, $"stroke=\"{stroke.ToHexString()}\" stroke-width=\"{strokeWidth:0.##}\" ");
        }
        _sb.AppendLine("/>");
    }

    public void DrawPath(string pathData, Color fill, Color stroke, float strokeWidth = 1.0f)
    {
        _sb.Append(CultureInfo.InvariantCulture, $"<path d=\"{pathData}\" ");
        if (fill.A > 0)
        {
            _sb.Append(CultureInfo.InvariantCulture, $"fill=\"{fill.ToHexString()}\" ");
            if (fill.A < 255) _sb.Append(CultureInfo.InvariantCulture, $"fill-opacity=\"{(fill.A / 255.0f):0.###}\" ");
        }
        else
        {
            _sb.Append("fill=\"none\" ");
        }

        if (stroke.A > 0 && strokeWidth > 0)
        {
            _sb.Append(CultureInfo.InvariantCulture, $"stroke=\"{stroke.ToHexString()}\" stroke-width=\"{strokeWidth:0.##}\" ");
        }
        _sb.AppendLine("/>");
    }

    public void DrawText(
        string text,
        float x,
        float y,
        Color color,
        float fontSize = 12.0f,
        string fontWeight = "normal",
        string fontFamily = "Helvetica, Arial, sans-serif",
        string textAnchor = "start",
        float rotationAngle = 0f)
    {
        if (string.IsNullOrEmpty(text) || color.A == 0) return;

        string escaped = text.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;").Replace("\"", "&quot;");
        _sb.Append(CultureInfo.InvariantCulture, $"<text x=\"{x:0.##}\" y=\"{y:0.##}\" fill=\"{color.ToHexString()}\" font-size=\"{fontSize:0.##}px\" font-weight=\"{fontWeight}\" font-family=\"{fontFamily}\" text-anchor=\"{textAnchor}\" ");

        if (rotationAngle != 0f)
        {
            _sb.Append(CultureInfo.InvariantCulture, $"transform=\"rotate({rotationAngle:0.##} {x:0.##} {y:0.##})\" ");
        }

        _sb.Append(CultureInfo.InvariantCulture, $">{escaped}</text>");
        _sb.AppendLine();
    }

    public string Build()
    {
        var final = new StringBuilder(_sb.Length + 10);
        final.Append(_sb);
        final.AppendLine("</svg>");
        return final.ToString();
    }

    public void Save(string filePath)
    {
        string content = Build();
        File.WriteAllText(filePath, content, Encoding.UTF8);
    }
}
