using System;
using System.Collections.Generic;

namespace TokenVector.Plot.Themes;

/// <summary>
/// Predefined publication-ready themes and styling configurations.
/// Follows Nature, IEEE, Science, and Dark/Light UI aesthetics.
/// </summary>
public sealed class StyleTheme
{
    public string Name { get; set; } = "Science";
    public Color BackgroundColor { get; set; } = Color.White;
    public Color PlotAreaColor { get; set; } = Color.White;
    public Color AxisColor { get; set; } = Color.FromHex("#2C3E50");
    public Color GridColor { get; set; } = Color.FromHex("#E0E0E0");
    public Color TextColor { get; set; } = Color.FromHex("#2C3E50");
    public Color TitleColor { get; set; } = Color.FromHex("#1A252F");
    public Color LegendBackground { get; set; } = Color.FromRgba(255, 255, 255, 230);
    public Color LegendBorder { get; set; } = Color.FromHex("#BDC3C7");

    public float AxisLineWidth { get; set; } = 1.2f;
    public float GridLineWidth { get; set; } = 0.8f;
    public bool ShowMajorGrid { get; set; } = true;
    public bool ShowMinorGrid { get; set; } = false;

    public float TitleFontSize { get; set; } = 16.0f;
    public float AxisLabelFontSize { get; set; } = 12.0f;
    public float TickLabelFontSize { get; set; } = 10.0f;
    public float LegendFontSize { get; set; } = 10.0f;
    public string FontFamily { get; set; } = "Helvetica, Arial, sans-serif";

    public Color[] Palette { get; set; } = Array.Empty<Color>();

    #region Predefined Themes

    public static StyleTheme Science => new()
    {
        Name = "Science",
        BackgroundColor = Color.White,
        PlotAreaColor = Color.White,
        AxisColor = Color.FromHex("#111111"),
        GridColor = Color.FromHex("#E5E5E5"),
        TextColor = Color.FromHex("#111111"),
        TitleColor = Color.FromHex("#000000"),
        AxisLineWidth = 1.2f,
        GridLineWidth = 0.75f,
        ShowMajorGrid = true,
        Palette = new[]
        {
            Color.FromHex("#0C5DA5"),
            Color.FromHex("#00B945"),
            Color.FromHex("#FF9500"),
            Color.FromHex("#FF2C00"),
            Color.FromHex("#845B97"),
            Color.FromHex("#474747"),
            Color.FromHex("#9E9E9E")
        }
    };

    public static StyleTheme Nature => new()
    {
        Name = "Nature",
        BackgroundColor = Color.White,
        PlotAreaColor = Color.White,
        AxisColor = Color.FromHex("#222222"),
        GridColor = Color.FromHex("#ECEFF1"),
        TextColor = Color.FromHex("#222222"),
        TitleColor = Color.FromHex("#111111"),
        AxisLineWidth = 1.0f,
        GridLineWidth = 0.5f,
        ShowMajorGrid = true,
        Palette = new[]
        {
            Color.FromHex("#E64B35"),
            Color.FromHex("#4DBBD5"),
            Color.FromHex("#00A087"),
            Color.FromHex("#3C5488"),
            Color.FromHex("#F39B7F"),
            Color.FromHex("#8491B4"),
            Color.FromHex("#91D1C2")
        }
    };

    public static StyleTheme IEEE => new()
    {
        Name = "IEEE",
        BackgroundColor = Color.White,
        PlotAreaColor = Color.White,
        AxisColor = Color.FromHex("#000000"),
        GridColor = Color.FromHex("#D3D3D3"),
        TextColor = Color.FromHex("#000000"),
        TitleColor = Color.FromHex("#000000"),
        AxisLineWidth = 1.5f,
        GridLineWidth = 0.8f,
        ShowMajorGrid = true,
        Palette = new[]
        {
            Color.FromHex("#1F77B4"),
            Color.FromHex("#FF7F0E"),
            Color.FromHex("#2CA02C"),
            Color.FromHex("#D62728"),
            Color.FromHex("#9467BD"),
            Color.FromHex("#8C564B"),
            Color.FromHex("#E377C2")
        }
    };

    public static StyleTheme Dark => new()
    {
        Name = "Dark",
        BackgroundColor = Color.FromHex("#181818"),
        PlotAreaColor = Color.FromHex("#1F1F1F"),
        AxisColor = Color.FromHex("#E0E0E0"),
        GridColor = Color.FromHex("#333333"),
        TextColor = Color.FromHex("#E0E0E0"),
        TitleColor = Color.FromHex("#FFFFFF"),
        LegendBackground = Color.FromRgba(30, 30, 30, 220),
        LegendBorder = Color.FromHex("#555555"),
        AxisLineWidth = 1.2f,
        GridLineWidth = 0.75f,
        ShowMajorGrid = true,
        Palette = new[]
        {
            Color.FromHex("#4FC3F7"),
            Color.FromHex("#81C784"),
            Color.FromHex("#FFB74D"),
            Color.FromHex("#E57373"),
            Color.FromHex("#BA68C8"),
            Color.FromHex("#4DB6AC"),
            Color.FromHex("#FFF176")
        }
    };

    public static StyleTheme Light => Science;

    #endregion

    public Color GetPaletteColor(int index)
    {
        if (Palette == null || Palette.Length == 0) return Color.Blue;
        return Palette[index % Palette.Length];
    }
}
