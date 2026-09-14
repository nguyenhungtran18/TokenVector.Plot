using System;
using System.Numerics;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace TokenVector.Plot.Themes;

/// <summary>
/// 32-bit Packed Color representation (RGBA: Red, Green, Blue, Alpha).
/// Memory-aligned for SIMD processing.
/// </summary>
[StructLayout(LayoutKind.Sequential, Pack = 1)]
public readonly record struct Color(byte R, byte G, byte B, byte A = 255)
{
    public static readonly Color Transparent = new(0, 0, 0, 0);
    public static readonly Color Black = new(0, 0, 0, 255);
    public static readonly Color White = new(255, 255, 255, 255);
    public static readonly Color Red = new(235, 64, 52, 255);
    public static readonly Color Green = new(46, 204, 113, 255);
    public static readonly Color Blue = new(52, 152, 219, 255);
    public static readonly Color Gray = new(128, 128, 128, 255);
    public static readonly Color LightGray = new(220, 220, 220, 255);
    public static readonly Color DarkGray = new(50, 50, 50, 255);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public uint ToRgba32() => (uint)(R | (G << 8) | (B << 16) | (A << 24));

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public uint ToBgra32() => (uint)(B | (G << 8) | (R << 16) | (A << 24));

    public string ToHexString() => $"#{R:X2}{G:X2}{B:X2}";

    public string ToRgbaString() => $"rgba({R},{G},{B},{(A / 255.0f):0.###})";

    public static Color FromRgb(byte r, byte g, byte b) => new(r, g, b, 255);
    
    public static Color FromRgba(byte r, byte g, byte b, byte a) => new(r, g, b, a);

    public static Color FromHex(string hex)
    {
        if (string.IsNullOrWhiteSpace(hex)) return Black;
        ReadOnlySpan<char> span = hex.AsSpan();
        if (span.StartsWith("#")) span = span[1..];
        
        if (span.Length == 6)
        {
            byte r = byte.Parse(span[..2], System.Globalization.NumberStyles.HexNumber);
            byte g = byte.Parse(span[2..4], System.Globalization.NumberStyles.HexNumber);
            byte b = byte.Parse(span[4..6], System.Globalization.NumberStyles.HexNumber);
            return new Color(r, g, b, 255);
        }
        if (span.Length == 8)
        {
            byte r = byte.Parse(span[..2], System.Globalization.NumberStyles.HexNumber);
            byte g = byte.Parse(span[2..4], System.Globalization.NumberStyles.HexNumber);
            byte b = byte.Parse(span[4..6], System.Globalization.NumberStyles.HexNumber);
            byte a = byte.Parse(span[6..8], System.Globalization.NumberStyles.HexNumber);
            return new Color(r, g, b, a);
        }
        return Black;
    }

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public Color WithAlpha(byte alpha) => new(R, G, B, alpha);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static Color Lerp(Color c1, Color c2, float t)
    {
        t = Math.Clamp(t, 0.0f, 1.0f);
        byte r = (byte)(c1.R + (c2.R - c1.R) * t);
        byte g = (byte)(c1.G + (c2.G - c1.G) * t);
        byte b = (byte)(c1.B + (c2.B - c1.B) * t);
        byte a = (byte)(c1.A + (c2.A - c1.A) * t);
        return new Color(r, g, b, a);
    }
}

/// <summary>
/// High-performance scientific colormap palette generator and evaluator.
/// Precomputed look-up tables (LUT) for zero-allocation sampling.
/// </summary>
public sealed class ColorMap
{
    private readonly Color[] _lut;
    public string Name { get; }

    public static readonly ColorMap Viridis = new("Viridis", PrecomputeViridis());
    public static readonly ColorMap Plasma = new("Plasma", PrecomputePlasma());
    public static readonly ColorMap Inferno = new("Inferno", PrecomputeInferno());
    public static readonly ColorMap Magma = new("Magma", PrecomputeMagma());
    public static readonly ColorMap Turbo = new("Turbo", PrecomputeTurbo());
    public static readonly ColorMap Coolwarm = new("Coolwarm", PrecomputeCoolwarm());
    public static readonly ColorMap Cividis = new("Cividis", PrecomputeCividis());

    public ColorMap(string name, Color[] lut)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(name);
        ArgumentNullException.ThrowIfNull(lut);
        if (lut.Length == 0) throw new ArgumentException("LUT cannot be empty.");
        Name = name;
        _lut = lut;
    }

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public Color Sample(float normalizedValue)
    {
        float val = Math.Clamp(normalizedValue, 0.0f, 1.0f);
        int idx = (int)(val * (_lut.Length - 1));
        return _lut[idx];
    }

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public Color Sample(double normalizedValue) => Sample((float)normalizedValue);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public Color Sample(float value, float min, float max)
    {
        if (MathF.Abs(max - min) < 1e-7f) return _lut[0];
        float norm = (value - min) / (max - min);
        return Sample(norm);
    }

    public static ColorMap FromName(string name)
    {
        return name.ToLowerInvariant() switch
        {
            "plasma" => Plasma,
            "inferno" => Inferno,
            "magma" => Magma,
            "turbo" => Turbo,
            "coolwarm" => Coolwarm,
            "cividis" => Cividis,
            _ => Viridis
        };
    }

    #region Precomputed LUT Generators

    private static Color[] PrecomputeViridis()
    {
        // 256-element LUT based on standard scientific Viridis polynomial fit
        Color[] lut = new Color[256];
        for (int i = 0; i < 256; i++)
        {
            float t = i / 255.0f;
            float r = Math.Clamp(0.267f + 0.004f * t - 0.94f * t * t + 1.67f * t * t * t, 0f, 1f);
            float g = Math.Clamp(0.004f + 0.88f * t - 0.22f * t * t + 0.33f * t * t * t, 0f, 1f);
            float b = Math.Clamp(0.329f + 0.95f * t - 1.25f * t * t + 0.28f * t * t * t, 0f, 1f);
            lut[i] = new Color((byte)(r * 255), (byte)(g * 255), (byte)(b * 255), 255);
        }
        return lut;
    }

    private static Color[] PrecomputePlasma()
    {
        Color[] lut = new Color[256];
        for (int i = 0; i < 256; i++)
        {
            float t = i / 255.0f;
            float r = Math.Clamp(0.05f + 1.2f * t - 0.3f * t * t, 0f, 1f);
            float g = Math.Clamp(0.01f + 0.2f * t + 0.7f * t * t * t, 0f, 1f);
            float b = Math.Clamp(0.53f + 0.4f * t - 1.2f * t * t + 0.3f * t * t * t, 0f, 1f);
            lut[i] = new Color((byte)(r * 255), (byte)(g * 255), (byte)(b * 255), 255);
        }
        return lut;
    }

    private static Color[] PrecomputeInferno()
    {
        Color[] lut = new Color[256];
        for (int i = 0; i < 256; i++)
        {
            float t = i / 255.0f;
            float r = Math.Clamp(1.3f * t * (1.0f - 0.2f * t), 0f, 1f);
            float g = Math.Clamp(0.9f * t * t * t, 0f, 1f);
            float b = Math.Clamp(0.2f * (1f - t) + 0.8f * MathF.Sin(t * MathF.PI), 0f, 1f);
            lut[i] = new Color((byte)(r * 255), (byte)(g * 255), (byte)(b * 255), 255);
        }
        return lut;
    }

    private static Color[] PrecomputeMagma()
    {
        Color[] lut = new Color[256];
        for (int i = 0; i < 256; i++)
        {
            float t = i / 255.0f;
            float r = Math.Clamp(0.01f + 1.3f * t - 0.35f * t * t, 0f, 1f);
            float g = Math.Clamp(0.02f + 0.15f * t + 0.8f * t * t * t, 0f, 1f);
            float b = Math.Clamp(0.3f + 0.6f * t - 1.0f * t * t + 0.3f * t * t * t, 0f, 1f);
            lut[i] = new Color((byte)(r * 255), (byte)(g * 255), (byte)(b * 255), 255);
        }
        return lut;
    }

    private static Color[] PrecomputeTurbo()
    {
        Color[] lut = new Color[256];
        for (int i = 0; i < 256; i++)
        {
            float x = i / 255.0f;
            float r = Math.Clamp(0.1357f + x * (4.5831f + x * (-42.308f + x * (130.58f + x * (-151.0f + x * 58.13f)))), 0f, 1f);
            float g = Math.Clamp(0.0914f + x * (2.1941f + x * (4.8067f + x * (-14.09f + x * (4.249f + x * 2.906f)))), 0f, 1f);
            float b = Math.Clamp(0.1066f + x * (12.585f + x * (-67.27f + x * (160.0f + x * (-174.6f + x * 69.25f)))), 0f, 1f);
            lut[i] = new Color((byte)(r * 255), (byte)(g * 255), (byte)(b * 255), 255);
        }
        return lut;
    }

    private static Color[] PrecomputeCoolwarm()
    {
        Color[] lut = new Color[256];
        for (int i = 0; i < 256; i++)
        {
            float t = i / 255.0f;
            float r = Math.Clamp(0.23f + 0.75f * t + 0.2f * MathF.Sin(t * MathF.PI), 0f, 1f);
            float g = Math.Clamp(0.30f + 0.40f * MathF.Sin(t * MathF.PI), 0f, 1f);
            float b = Math.Clamp(0.85f - 0.70f * t + 0.2f * MathF.Cos(t * MathF.PI), 0f, 1f);
            lut[i] = new Color((byte)(r * 255), (byte)(g * 255), (byte)(b * 255), 255);
        }
        return lut;
    }

    private static Color[] PrecomputeCividis()
    {
        Color[] lut = new Color[256];
        for (int i = 0; i < 256; i++)
        {
            float t = i / 255.0f;
            float r = Math.Clamp(0.0f + 0.95f * t, 0f, 1f);
            float g = Math.Clamp(0.13f + 0.85f * t, 0f, 1f);
            float b = Math.Clamp(0.33f + 0.25f * t, 0f, 1f);
            lut[i] = new Color((byte)(r * 255), (byte)(g * 255), (byte)(b * 255), 255);
        }
        return lut;
    }

    #endregion
}
