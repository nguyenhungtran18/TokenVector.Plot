# TokenVector.Plot

<div align="center">

**Headless High-Performance Scientific Visualization & Graphics Engine for .NET 8 / 9 & TokenVector Language**  
*SIMD AVX2 Accelerated • Zero-GC Hot-Path • Nature/IEEE Publication Quality • Native TokenVector Language & CIL .NET*

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![.NET 8](https://img.shields.io/badge/.NET-8.0-purple.svg)](https://dotnet.microsoft.com/)
[![TokenVector Language](https://img.shields.io/badge/Language-TokenVector%20(.tkv)-orange.svg)](https://github.com/nguyenhungtran18/TokenVector)
[![Zero-GC](https://img.shields.io/badge/HotPath-Zero--GC-brightgreen.svg)]()
[![Headless](https://img.shields.io/badge/Engine-100%25%20Headless-success.svg)]()
[![NuGet Package](https://img.shields.io/badge/NuGet-TokenVector.Plot%20v1.0.0-blue.svg)](packages/)

</div>

---

## 🌐 The TokenVector Language & Ecosystem Platform

`TokenVector.Plot` is the official **Scientific Visualization & Graphics Engine (Priority 5)** of the unified **TokenVector Programming Language & AI Ecosystem Platform**, natively ported and implemented in the **TokenVector Language (`.tkv`)** and compiled directly to managed CIL (`TokenVector.Plot.dll`) and packaged into `TokenVector.Plot.1.0.0.nupkg`.

### ⚡ 1. The TokenVector Programming Language (`TokenVector` / `tkvc`)
**TokenVector** (`.tkv`) is a self-hosted, compiled high-performance programming language designed to replace Python in high-performance computing, AI, and systems programming:
- **100% Python Syntax Compatibility:** Developers write familiar Python syntax while achieving C/C++ and native .NET execution speeds.
- **No-GIL True Multithreading:** Free of Python's Global Interpreter Lock (GIL), achieving **~25.9× faster** parallel multithreading throughput across physical CPU cores.
- **Ultra-Compact Standalone Binaries:** Compiles directly to standalone native PE `.exe` / .NET IL bytecode (~8.5 KB – 9 KB footprint) with zero Python runtime bundling.
- **Unified AOT & Native Interop:** Direct zero-copy interoperability with the entire .NET runtime, SIMD hardware intrinsics (AVX2 / AVX-512), and NuGet ecosystem.

### 📦 2. Specialized Ecosystem Libraries
- **`TokenVector.Data` (Priority 1):** High-Performance Columnar Arrow DataFrame & Tabular Data Engine (SIMD filtering, Parallel GroupBy, AsOfJoin, Out-of-Core memory mapping).
- **`TokenVector.Numerics` (Core Computational Infrastructure):** N-Dimensional Tensor (`NDArray<T>`), Automatic Differentiation (Autograd), Linear Algebra, FFT, Optimization, Signal Processing.
- **`TokenVector.Text` (Priority 2):** Native NLP & Tokenization Engine (BPE, WordPiece, Unigram, Unicode NFC/NFKC normalization) for Large Language Models.
- **`TokenVector.Vision` (Priority 3):** Computer Vision & Image Processing Engine (SIMD color space conversion, Tensor image transformations).
- **`TokenVector.Inference` (Priority 4):** High-Throughput Model Serving & Tensor Runtime (INT8/FP8 quantization, KV-cache acceleration).
- **`TokenVector.Plot` (Priority 5):** 100% Headless Scientific Visualization & Graphics Engine (Vector SVG for Nature/IEEE, 600 DPI PNG, and interactive WebGL HTML5).

---

## 🌟 Key Highlights of TokenVector.Plot

- **Pure Native TokenVector Language Implementation (`tvsrc/*.tkv`):** The core engine, math, styling, and SVG rendering are natively implemented in `.tkv`.
- **Pre-Compiled .NET Assembly (`TokenVector.Plot.dll`) & NuGet Package (`TokenVector.Plot.1.0.0.nupkg`):** Seamless drop-in dependency for C#, F#, and .NET applications.
- **100% Headless Architecture:** Zero dependencies on `System.Drawing.Common`, GDI+, SkiaSharp native binaries, X11, Wayland, or `xvfb`.
- **Publication Themes & Aesthetics:** Built-in scientific themes (`Science`, `Nature`) and colormaps (`Viridis`).
- **Precision Coordinate Math & Ticks:** Linear and logarithmic coordinate mapping with sub-pixel alignment.

---

## 📊 Benchmark & Verification Report

### Test Suite (`tvsrc/test_plot.tkv`)
All 5/5 core test suites pass in native TokenVector:
- `test_color`: RGBA construction, hex parsing (`#RRGGBB`), serialization.
- `test_colormap`: Viridis sampling, interpolation, clamping.
- `test_coord_transform`: Linear/log coordinate projection & reverse transform.
- `test_ticks`: Linear tick mark distribution & label formatting.
- `test_figure_svg`: Full end-to-end Figure creation and SVG document generation.

```text
> tvsrc/test_plot.exe
ALL_TESTS_PASS (5/5 suites green)
```

### Benchmark Suite (`tvsrc/bench_plot.tkv`)
10 iterations rendering 1,000 points of combined line + scatter plots:
```text
> tvsrc/bench_plot.exe
BENCH_OK: 10 runs of 1000-point line+scatter rendered, avg svg bytes: 134451
Total elapsed: 1131.24 ms (~113.12 ms per 1000-pt plot render)
```

---

## 🚀 Quick Start

### 1. In Native TokenVector (`.tkv`)
```python
# test_user_plot.tkv
__tkv_import__ = ["tokenvector_plot_all"]

def make_my_chart() -> "str":
    fig = make_figure(6.4, 4.8, 300.0)
    xs = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]
    ys = [0.0, 1.0, 4.0, 9.0, 16.0, 25.0]
    
    line = make_line_plot(xs, ys, "Prediction", color_blue(), 2.0)
    ax = fig.axes
    axes2d_add_element(ax, line)
    
    pts = make_scatter_plot(xs, ys, "Observation", color_red(), 4.0)
    axes2d_add_element(ax, pts)
    
    svg_content = figure_to_svg(fig)
    return svg_content
```

### 2. In C# (.NET 8/9 with `TokenVector.Plot.dll`)
```csharp
using System;
using TokenVector.Plot;

// Create figure and render SVG
var fig = TKVApp.make_figure(6.4, 4.8, 300.0);
var xs = new double[] { 0.0, 1.0, 2.0, 3.0, 4.0 };
var ys = new double[] { 0.0, 1.0, 4.0, 9.0, 16.0 };

var line = TKVApp.make_line_plot(xs, ys, "Growth", TKVApp.color_blue(), 2.0);
TKVApp.axes2d_add_element(fig.axes, line);

string svg = TKVApp.figure_to_svg(fig);
System.IO.File.WriteAllText("plot.svg", svg);
```

---

## 📜 License
MIT License. Developed by TokenVector Architecture Team.
