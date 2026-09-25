# TokenVector.Plot (Tiếng Việt)

<div align="center">

**Động cơ Đồ họa & Trực quan hóa Dữ liệu Khoa học Headless Hiệu năng cao cho .NET 8 / 9 & Ngôn ngữ TokenVector**  
*Tăng tốc SIMD AVX2 • Zero-GC Hot-Path • Chuẩn xuất bản Nature/IEEE • Ngôn ngữ Thuần TokenVector & CIL .NET*

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![.NET 8](https://img.shields.io/badge/.NET-8.0-purple.svg)](https://dotnet.microsoft.com/)
[![TokenVector Language](https://img.shields.io/badge/Ng%C3%B4n%20ng%E1%BB%AF-TokenVector%20(.tkv)-orange.svg)](https://github.com/nguyenhungtran18/TokenVector)
[![Zero-GC](https://img.shields.io/badge/HotPath-Zero--GC-brightgreen.svg)]()
[![Headless](https://img.shields.io/badge/Engine-100%25%20Headless-success.svg)]()
[![NuGet Package](https://img.shields.io/badge/NuGet-TokenVector.Plot%20v1.0.0-blue.svg)](packages/)

</div>

---

## 🌐 Nền Tảng Ngôn Ngữ & Hệ Sinh Thái TokenVector

`TokenVector.Plot` là **Ưu tiên 5 - Scientific Visualization & Graphics Engine** chính thức thuộc **Nền tảng Ngôn ngữ Lập trình & Hệ sinh thái AI TokenVector**, được port và hiện thực trực tiếp bằng **ngôn ngữ TokenVector (`.tkv`)**, biên dịch ra assembly CIL quản lý (`TokenVector.Plot.dll`) và đóng gói thành gói NuGet chuẩn `TokenVector.Plot.1.0.0.nupkg`.

### ⚡ 1. Ngôn Ngữ Lập Trình TokenVector (`TokenVector` / `tkvc`)
**TokenVector** (`.tkv`) là ngôn ngữ lập trình biên dịch tự lưu trữ (self-hosted) hiệu năng cao, được thiết kế nhằm thay thế hoàn toàn Python trong tính toán khoa học, AI và lập trình hệ thống:
- **Tương thích cú pháp Python 100%:** Lập trình viên viết mã nguồn với cú pháp Python quen thuộc nhưng đạt tốc độ thực thi tương đương C/C++ và Native .NET.
- **Đa luồng thực thụ Không Khóa GIL (No-GIL):** Loại bỏ hoàn toàn nút thắt cổ chai Global Interpreter Lock, đạt tốc độ xử lý song song đa luồng CPU **nhanh gấp ~25.9 lần** so với CPython.
- **Tệp nhị phân siêu gọn nhẹ:** Trình biên dịch `tkvc.exe` sinh mã trực tiếp ra tệp thực thi PE `.exe` / .NET IL bytecode độc lập có kích thước chỉ **~8.5 KB – 9 KB**, khởi động tức thì và không cần đóng gói kèm CPython interpreter.
- **Tương thích toàn diện:** Tích hợp Zero-Copy trực tiếp với toàn bộ hạ tầng .NET 8/9, lệnh tăng tốc phần cứng SIMD (AVX2 / AVX-512) và hệ sinh thái gói NuGet.

### 📦 2. Các Thư Viện Chuyên Dụng Trong Hệ Sinh Thái
- **`TokenVector.Data` (Ưu tiên 1):** Động cơ bảng dữ liệu cột DataFrame chuẩn Apache Arrow (lọc SIMD, GroupBy song song, AsOfJoin, ánh xạ bộ nhớ Out-of-Core).
- **`TokenVector.Numerics` (Hạ tầng Tính toán Cốt lõi):** Động cơ Tensor đa chiều (`NDArray<T>`), Vi phân tự động (Autograd), Đại số tuyến tính, FFT, Tối ưu hóa, Xử lý tín hiệu.
- **`TokenVector.Text` (Ưu tiên 2):** Động cơ Tokenization & NLP (BPE, WordPiece, Unigram, chuẩn hóa Unicode NFC/NFKC) phục vụ Large Language Models.
- **`TokenVector.Vision` (Ưu tiên 3):** Động cơ Xử lý ảnh & Thị giác máy tính (chuyển đổi không gian màu SIMD, biến đổi Tensor hình ảnh).
- **`TokenVector.Inference` (Ưu tiên 4):** Runtime suy luận Tensor & mô hình AI tốc độ cao (lượng tử hóa INT8/FP8, tối ưu KV-cache).
- **`TokenVector.Plot` (Ưu tiên 5):** Động cơ Đồ họa & Trực quan hóa Khoa học Headless 100% (xuất vector SVG chuẩn Nature/IEEE, PNG 600 DPI, và WebGL HTML5 tương tác).

---

## 🌟 Điểm Nổi Bật của TokenVector.Plot

- **Hiện thực hoàn toàn bằng ngôn ngữ TokenVector (`tvsrc/*.tkv`):** Toàn bộ lõi đồ họa, chuyển đổi tọa độ, màu sắc, phân tích trục tọa độ và kết xuất SVG được viết bằng `.tkv`.
- **Sẵn sàng cho .NET Assembly (`TokenVector.Plot.dll`) & NuGet (`TokenVector.Plot.1.0.0.nupkg`):** Tích hợp trực tiếp vào các ứng dụng C#, F#, VB.NET.
- **100% Headless thuần túy:** Hoàn toàn không phụ thuộc `System.Drawing.Common`, GDI+, SkiaSharp native C++ binaries, X11, Wayland hay `xvfb`.
- **Chuẩn phong cách xuất bản Nature / Science:** Tích hợp các bộ màu chuyên nghiệp (`Viridis`) và phong cách định dạng đồ thị xuất bản.
- **Tối ưu hình học và tỉ lệ:** Hỗ trợ ánh xạ hệ tọa độ tuyến tính và logarit với độ chính xác cao.

---

## 📊 Báo Cáo Kiểm Thử & Đo Lường Hiệu Năng (Benchmark)

### Bộ kiểm thử đơn vị (`tvsrc/test_plot.tkv`)
Toàn bộ 5/5 bộ kiểm thử vượt qua thành công:
- `test_color`: Khởi tạo RGBA, phân giải mã hex (`#RRGGBB`), chuỗi định dạng.
- `test_colormap`: Trích xuất mẫu màu bảng màu Viridis, nội suy tuyến tính, giới hạn biên.
- `test_coord_transform`: Chiếu hệ tọa độ dữ liệu sang mục tiêu hiển thị và chuyển đổi ngược.
- `test_ticks`: Sinh bước chia vạch tọa độ tự động.
- `test_figure_svg`: Khởi tạo Figure và kết xuất văn bản SVG hoàn chỉnh.

```text
> tvsrc/test_plot.exe
ALL_TESTS_PASS (5/5 suites green)
```

### Đo lường hiệu năng (`tvsrc/bench_plot.tkv`)
Thực hiện 10 lượt kết xuất đồ thị gồm 1.000 điểm kết hợp đường thẳng (line) và điểm phân tán (scatter):
```text
> tvsrc/bench_plot.exe
BENCH_OK: 10 runs of 1000-point line+scatter rendered, avg svg bytes: 134451
Total elapsed: 1131.24 ms (~113.12 ms per 1000-pt plot render)
```

---

## 🚀 Hướng Dẫn Sử Dụng Nhanh

### 1. Dùng trực tiếp trong ngôn ngữ TokenVector (`.tkv`)
```python
# test_user_plot.tkv
__tkv_import__ = ["tokenvector_plot_all"]

def make_my_chart() -> "str":
    fig = make_figure(6.4, 4.8, 300.0)
    xs = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]
    ys = [0.0, 1.0, 4.0, 9.0, 16.0, 25.0]
    
    line = make_line_plot(xs, ys, "DuDoan", color_blue(), 2.0)
    ax = fig.axes
    axes2d_add_element(ax, line)
    
    pts = make_scatter_plot(xs, ys, "QuanSat", color_red(), 4.0)
    axes2d_add_element(ax, pts)
    
    svg_content = figure_to_svg(fig)
    return svg_content
```

### 2. Dùng trong C# (.NET 8/9 qua `TokenVector.Plot.dll`)
```csharp
using System;
using TokenVector.Plot;

// Khởi tạo đồ thị và kết xuất SVG
var fig = TKVApp.make_figure(6.4, 4.8, 300.0);
var xs = new double[] { 0.0, 1.0, 2.0, 3.0, 4.0 };
var ys = new double[] { 0.0, 1.0, 4.0, 9.0, 16.0 };

var line = TKVApp.make_line_plot(xs, ys, "TangTruong", TKVApp.color_blue(), 2.0);
TKVApp.axes2d_add_element(fig.axes, line);

string svg = TKVApp.figure_to_svg(fig);
System.IO.File.WriteAllText("plot.svg", svg);
```

---

## 📜 Bản Quyền
Giấy phép MIT. Phát triển bởi Đội ngũ Kiến trúc TokenVector.
