using System;
using TokenVector.Data.Common;
using TokenVector.Data.Core;
using TokenVector.Plot.Charts.Statistical;
using TokenVector.Plot.Core;
using TokenVector.Plot.Themes;

namespace TokenVector.Plot.Interop;

/// <summary>
/// Zero-Copy Plotting Bridge extensions for TokenVector.Data DataFrame and Series.
/// </summary>
public static class DataFramePlotExtensions
{
    public static DataFramePlotter Plot(this DataFrame df) => new(df);

    public static SeriesPlotter Plot(this Series series) => new(series);
}

public readonly ref struct DataFramePlotter
{
    private readonly DataFrame _df;

    public DataFramePlotter(DataFrame df)
    {
        _df = df;
    }

    public Figure Line(string xCol, string yCol, string? label = null, Color? color = null)
    {
        var sX = _df[xCol];
        var sY = _df[yCol];

        int len = _df.RowCount;
        float[] x = ExtractNumericSpan(sX);
        float[] y = ExtractNumericSpan(sY);

        var fig = Figure.Create();
        fig.Axes.XLabel = xCol;
        fig.Axes.YLabel = yCol;

        var line = new LinePlot(x, y)
        {
            Label = label ?? yCol,
            Color = color ?? fig.Theme.GetPaletteColor(0)
        };
        fig.Axes.AddElement(line);
        return fig;
    }

    public Figure Scatter(string xCol, string yCol, string? label = null, Color? color = null, float pointSize = 3.0f)
    {
        var sX = _df[xCol];
        var sY = _df[yCol];

        float[] x = ExtractNumericSpan(sX);
        float[] y = ExtractNumericSpan(sY);

        var fig = Figure.Create();
        fig.Axes.XLabel = xCol;
        fig.Axes.YLabel = yCol;

        var scatter = new FastScatterPlot(x, y)
        {
            Label = label ?? yCol,
            Color = color ?? fig.Theme.GetPaletteColor(0),
            PointSize = pointSize
        };
        fig.Axes.AddElement(scatter);
        return fig;
    }

    public Figure Bar(string categoryCol, string valueCol, Color? color = null)
    {
        var sCat = _df[categoryCol];
        var sVal = _df[valueCol];

        int len = _df.RowCount;
        float[] cats = new float[len];
        for (int i = 0; i < len; i++) cats[i] = i;

        float[] vals = ExtractNumericSpan(sVal);

        var fig = Figure.Create();
        fig.Axes.XLabel = categoryCol;
        fig.Axes.YLabel = valueCol;

        var bar = new BarHistogramPlot(cats, vals)
        {
            FillColor = color ?? fig.Theme.GetPaletteColor(0)
        };
        fig.Axes.AddElement(bar);
        return fig;
    }

    public Figure Histogram(string valueCol, int bins = 20, bool normalizeDensity = false)
    {
        var sVal = _df[valueCol];
        float[] vals = ExtractNumericSpan(sVal);

        var fig = Figure.Create();
        fig.Axes.XLabel = valueCol;
        fig.Axes.YLabel = normalizeDensity ? "Density" : "Frequency";

        var hist = BarHistogramPlot.FromRawData(vals, BinningStrategy.FreedmanDiaconis, bins, normalizeDensity);
        fig.Axes.AddElement(hist);
        return fig;
    }

    public Figure BoxPlot(params string[] columnNames)
    {
        var fig = Figure.Create();
        var box = new BoxViolinPlot();

        for (int i = 0; i < columnNames.Length; i++)
        {
            string colName = columnNames[i];
            var s = _df[colName];
            float[] vals = ExtractNumericSpan(s);
            box.AddGroup(i + 1, vals, colName);
        }

        fig.Axes.AddElement(box);
        return fig;
    }

    private static float[] ExtractNumericSpan(Series series)
    {
        int len = series.Length;
        float[] res = new float[len];

        if (series.Column is Column<float> fCol)
        {
            fCol.AsReadOnlySpan().CopyTo(res);
            return res;
        }

        if (series.Column is Column<double> dCol)
        {
            var span = dCol.AsReadOnlySpan();
            for (int i = 0; i < len; i++) res[i] = (float)span[i];
            return res;
        }

        if (series.Column is Column<int> iCol)
        {
            var span = iCol.AsReadOnlySpan();
            for (int i = 0; i < len; i++) res[i] = span[i];
            return res;
        }

        if (series.Column is Column<long> lCol)
        {
            var span = lCol.AsReadOnlySpan();
            for (int i = 0; i < len; i++) res[i] = span[i];
            return res;
        }

        for (int i = 0; i < len; i++)
        {
            res[i] = Convert.ToSingle(series[i] ?? 0.0f);
        }
        return res;
    }
}

public readonly ref struct SeriesPlotter
{
    private readonly Series _series;

    public SeriesPlotter(Series series)
    {
        _series = series;
    }

    public Figure Line(string? label = null, Color? color = null)
    {
        int len = _series.Length;
        float[] x = new float[len];
        float[] y = new float[len];

        for (int i = 0; i < len; i++)
        {
            x[i] = i;
            y[i] = Convert.ToSingle(_series[i] ?? 0.0f);
        }

        var fig = Figure.Create();
        var line = new LinePlot(x, y)
        {
            Label = label ?? _series.Name,
            Color = color ?? fig.Theme.GetPaletteColor(0)
        };
        fig.Axes.AddElement(line);
        return fig;
    }

    public Figure Histogram(int bins = 20, bool normalizeDensity = false)
    {
        int len = _series.Length;
        float[] vals = new float[len];
        for (int i = 0; i < len; i++)
        {
            vals[i] = Convert.ToSingle(_series[i] ?? 0.0f);
        }

        var fig = Figure.Create();
        fig.Axes.XLabel = _series.Name;
        fig.Axes.YLabel = normalizeDensity ? "Density" : "Frequency";

        var hist = BarHistogramPlot.FromRawData(vals, BinningStrategy.FreedmanDiaconis, bins, normalizeDensity);
        fig.Axes.AddElement(hist);
        return fig;
    }
}
