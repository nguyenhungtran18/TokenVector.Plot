using System;
using System.Collections.Generic;
using System.Globalization;

namespace TokenVector.Plot.Core;

public readonly record struct Tick(double Position, string Label, bool IsMajor = true);

/// <summary>
/// Mathematical Ticks Engine implementing Extended Wilkinson / Talbot's Optimization Algorithm
/// for aesthetic, publication-grade axis labelling.
/// </summary>
public static class TicksEngine
{
    private static readonly double[] Q = { 1.0, 5.0, 2.0, 2.5, 4.0, 3.0 };
    private static readonly double[] W = { 0.25, 0.2, 0.5, 0.05 }; // Weights: Simplicity, Coverage, Density, Legibility

    /// <summary>
    /// Computes optimal aesthetic tick marks for a given numeric range.
    /// </summary>
    public static List<Tick> GenerateTicks(double min, double max, int targetCount = 6, string? customFormat = null)
    {
        var ticks = new List<Tick>();
        if (double.IsNaN(min) || double.IsNaN(max) || double.IsInfinity(min) || double.IsInfinity(max))
        {
            return ticks;
        }

        if (Math.Abs(max - min) < 1e-12)
        {
            ticks.Add(new Tick(min, FormatNumber(min, customFormat), true));
            return ticks;
        }

        if (min > max) (min, max) = (max, min);

        double bestScore = double.MinValue;
        double bestMin = min;
        double bestMax = max;
        double bestStep = 1.0;

        int kMin = Math.Max(2, targetCount - 3);
        int kMax = targetCount + 3;

        // Optimization search loop
        for (int k = kMin; k <= kMax; k++)
        {
            for (int qIdx = 0; qIdx < Q.Length; qIdx++)
            {
                double q = Q[qIdx];
                double rawStep = (max - min) / (k - 1);
                double exponent = Math.Floor(Math.Log10(rawStep / q));
                double step = q * Math.Pow(10.0, exponent);

                double lMin = Math.Floor(min / step) * step;
                double lMax = Math.Ceiling(max / step) * step;
                int count = (int)Math.Round((lMax - lMin) / step) + 1;

                if (count < 2 || count > 15) continue;

                // 1. Simplicity: penalize complex q values and floating exponents
                double s = 1.0 - (qIdx / (double)Q.Length);

                // 2. Coverage: reward spanning close to the actual range
                double c = (max - min) / (lMax - lMin);

                // 3. Density: reward matching requested tick count k
                double d = 1.0 - Math.Abs(count - targetCount) / (double)targetCount;
                if (d < 0) d = 0;

                // 4. Legibility: keep step readable
                double l = 1.0;

                double score = W[0] * s + W[1] * c + W[2] * d + W[3] * l;

                if (score > bestScore)
                {
                    bestScore = score;
                    bestMin = lMin;
                    bestMax = lMax;
                    bestStep = step;
                }
            }
        }

        // Generate final tick positions and formatted labels
        double current = bestMin;
        int maxIter = 50;
        int iter = 0;
        while (current <= bestMax + bestStep * 0.5 && iter++ < maxIter)
        {
            // Avoid precision artifact e.g. 0.30000000000000004
            double roundedPos = Math.Round(current / bestStep) * bestStep;
            if (Math.Abs(roundedPos) < 1e-12) roundedPos = 0.0;
            
            ticks.Add(new Tick(roundedPos, FormatNumber(roundedPos, customFormat), true));
            current += bestStep;
        }

        return ticks;
    }

    /// <summary>
    /// Generates logarithmic tick marks (powers of 10 and sub-decades).
    /// </summary>
    public static List<Tick> GenerateLogTicks(double min, double max)
    {
        var ticks = new List<Tick>();
        if (min <= 0) min = 1e-4;
        if (max <= min) max = min * 10;

        int minExp = (int)Math.Floor(Math.Log10(min));
        int maxExp = (int)Math.Ceiling(Math.Log10(max));

        for (int exp = minExp; exp <= maxExp; exp++)
        {
            double val = Math.Pow(10, exp);
            ticks.Add(new Tick(val, $"10^{exp}", true));

            // Sub-ticks (minor ticks) 2, 3, ..., 9 * 10^exp
            if (maxExp - minExp <= 4)
            {
                for (int m = 2; m <= 9; m++)
                {
                    double mVal = m * val;
                    if (mVal >= min && mVal <= max)
                    {
                        ticks.Add(new Tick(mVal, "", false));
                    }
                }
            }
        }

        return ticks;
    }

    private static string FormatNumber(double v, string? customFormat)
    {
        if (!string.IsNullOrEmpty(customFormat))
        {
            return v.ToString(customFormat, CultureInfo.InvariantCulture);
        }

        double abs = Math.Abs(v);
        if (abs == 0.0) return "0";

        if (abs >= 1e5 || abs <= 1e-4)
        {
            return v.ToString("0.##e+0", CultureInfo.InvariantCulture);
        }

        if (abs >= 1000)
        {
            return v.ToString("N0", CultureInfo.InvariantCulture);
        }

        return v.ToString("0.###", CultureInfo.InvariantCulture);
    }
}
