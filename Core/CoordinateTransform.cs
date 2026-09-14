using System;
using System.Numerics;
using System.Runtime.CompilerServices;
using System.Runtime.Intrinsics;
using System.Runtime.Intrinsics.X86;

namespace TokenVector.Plot.Core;

public enum ScaleType
{
    Linear,
    Log10,
    Ln,
    SymLog
}

/// <summary>
/// Mathematical coordinate transformation engine mapping data space to normalized/pixel space.
/// Accelerated with AVX2 vector SIMD math.
/// </summary>
public sealed class CoordinateTransform
{
    public ScaleType Scale { get; }
    public double DataMin { get; }
    public double DataMax { get; }
    public float TargetMin { get; }
    public float TargetMax { get; }
    public double LinThresh { get; } // For SymLog
    public double LinScale { get; }

    private readonly double _transformedMin;
    private readonly double _transformedMax;
    private readonly double _transformedRange;
    private readonly float _targetRange;

    public CoordinateTransform(
        ScaleType scale,
        double dataMin,
        double dataMax,
        float targetMin,
        float targetMax,
        double linThresh = 1.0,
        double linScale = 1.0)
    {
        Scale = scale;
        DataMin = dataMin;
        DataMax = dataMax;
        TargetMin = targetMin;
        TargetMax = targetMax;
        LinThresh = linThresh <= 0 ? 1e-5 : linThresh;
        LinScale = linScale <= 0 ? 1.0 : linScale;

        _transformedMin = ForwardScalar(DataMin);
        _transformedMax = ForwardScalar(DataMax);
        _transformedRange = _transformedMax - _transformedMin;
        if (Math.Abs(_transformedRange) < 1e-12) _transformedRange = 1.0;

        _targetRange = TargetMax - TargetMin;
    }

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    private double ForwardScalar(double v)
    {
        switch (Scale)
        {
            case ScaleType.Log10:
                return v > 0 ? Math.Log10(v) : double.NegativeInfinity;
            case ScaleType.Ln:
                return v > 0 ? Math.Log(v) : double.NegativeInfinity;
            case ScaleType.SymLog:
                {
                    double abs = Math.Abs(v);
                    if (abs <= LinThresh)
                    {
                        return v / LinThresh * LinScale;
                    }
                    double sign = Math.Sign(v);
                    return sign * (LinScale + Math.Log10(abs / LinThresh));
                }
            case ScaleType.Linear:
            default:
                return v;
        }
    }

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    private double InverseScalar(double t)
    {
        switch (Scale)
        {
            case ScaleType.Log10:
                return Math.Pow(10.0, t);
            case ScaleType.Ln:
                return Math.Exp(t);
            case ScaleType.SymLog:
                {
                    double abs = Math.Abs(t);
                    if (abs <= LinScale)
                    {
                        return t * LinThresh / LinScale;
                    }
                    double sign = Math.Sign(t);
                    return sign * LinThresh * Math.Pow(10.0, abs - LinScale);
                }
            case ScaleType.Linear:
            default:
                return t;
        }
    }

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public float ToTarget(double dataVal)
    {
        double t = ForwardScalar(dataVal);
        double normalized = (t - _transformedMin) / _transformedRange;
        return (float)(TargetMin + normalized * _targetRange);
    }

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public double ToData(float targetVal)
    {
        double normalized = (targetVal - TargetMin) / _targetRange;
        double t = _transformedMin + normalized * _transformedRange;
        return InverseScalar(t);
    }

    /// <summary>
    /// SIMD AVX2 Accelerated batch transformation of contiguous floats for Linear Scale.
    /// Zero-GC allocation.
    /// </summary>
    public unsafe void TransformSpan(ReadOnlySpan<float> input, Span<float> output)
    {
        if (input.Length != output.Length)
        {
            throw new ArgumentException("Input and Output spans must have the same length.");
        }

        int length = input.Length;
        if (length == 0) return;

        if (Scale == ScaleType.Linear && Avx.IsSupported && length >= 8)
        {
            float dMin = (float)_transformedMin;
            float dRange = (float)_transformedRange;
            float tMin = TargetMin;
            float tRange = _targetRange;
            float invDRange = 1.0f / dRange;
            float scaleFactor = tRange * invDRange;

            fixed (float* pIn = input)
            fixed (float* pOut = output)
            {
                int i = 0;
                var vDMin = Vector256.Create(dMin);
                var vScaleFactor = Vector256.Create(scaleFactor);
                var vTMin = Vector256.Create(tMin);

                for (; i <= length - 8; i += 8)
                {
                    var vIn = Avx.LoadVector256(pIn + i);
                    var vSub = Avx.Subtract(vIn, vDMin);
                    var vMul = Avx.Multiply(vSub, vScaleFactor);
                    var vRes = Avx.Add(vMul, vTMin);
                    Avx.Store(pOut + i, vRes);
                }

                for (; i < length; i++)
                {
                    pOut[i] = tMin + (pIn[i] - dMin) * scaleFactor;
                }
            }
        }
        else
        {
            for (int i = 0; i < length; i++)
            {
                output[i] = ToTarget(input[i]);
            }
        }
    }
}
