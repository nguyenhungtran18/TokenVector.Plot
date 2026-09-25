.assembly extern mscorlib {}
.assembly extern System.Core { .publickeytoken = (B7 7A 5C 56 19 34 E0 89 ) .ver 4:0:0:0 }
.assembly extern System { .publickeytoken = (B7 7A 5C 56 19 34 E0 89 ) .ver 4:0:0:0 }
.assembly extern System.Numerics { .publickeytoken = (B7 7A 5C 56 19 34 E0 89 ) .ver 4:0:0:0 }
.assembly TKVApp {}
.module TKVApp.dll

.class public auto ansi Color extends [mscorlib]System.Object
{
  .field public int32 'r'
  .field public int32 'g'
  .field public int32 'b'
  .field public int32 'a'
  .method public hidebysig specialname rtspecialname instance void .ctor(int32 'r', int32 'g', int32 'b', int32 'a') cil managed
  {
    .maxstack 8
    ldarg.0
    call instance void [mscorlib]System.Object::.ctor()
    ldarg.0
    ldarg.s 1
    stfld int32 Color::'r'
    ldarg.0
    ldarg.s 2
    stfld int32 Color::'g'
    ldarg.0
    ldarg.s 3
    stfld int32 Color::'b'
    ldarg.0
    ldarg.s 4
    stfld int32 Color::'a'
    ret
  }
}
.class public auto ansi ColorMap extends [mscorlib]System.Object
{
  .field public string 'name'
  .field public class [mscorlib]System.Collections.Generic.List`1<class Color> 'stops'
  .method public hidebysig specialname rtspecialname instance void .ctor(string 'name') cil managed
  {
    .maxstack 8
    ldarg.0
    call instance void [mscorlib]System.Object::.ctor()
    ldarg.0
    ldarg.s 1
    stfld string ColorMap::'name'
    ldarg.0
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::.ctor()
    stfld class [mscorlib]System.Collections.Generic.List`1<class Color> ColorMap::'stops'
    ret
  }
}
.class public auto ansi StyleTheme extends [mscorlib]System.Object
{
  .field public string 'name'
  .field public class Color 'bg_color'
  .field public class Color 'plot_area_color'
  .field public class Color 'axis_color'
  .field public class Color 'grid_color'
  .field public class Color 'text_color'
  .field public class Color 'title_color'
  .field public class Color 'legend_bg'
  .field public class Color 'legend_border'
  .field public float64 'axis_line_width'
  .field public float64 'grid_line_width'
  .field public int32 'show_major_grid'
  .field public int32 'show_minor_grid'
  .field public float64 'title_font_size'
  .field public float64 'axis_label_font_size'
  .field public float64 'tick_label_font_size'
  .field public float64 'legend_font_size'
  .field public string 'font_family'
  .field public class [mscorlib]System.Collections.Generic.List`1<class Color> 'palette'
  .method public hidebysig specialname rtspecialname instance void .ctor(string 'name', class Color 'bg_color', class Color 'plot_area_color', class Color 'axis_color', class Color 'grid_color', class Color 'text_color', class Color 'title_color', class Color 'legend_bg', class Color 'legend_border', float64 'axis_line_width', float64 'grid_line_width', int32 'show_major_grid', int32 'show_minor_grid', float64 'title_font_size', float64 'axis_label_font_size', float64 'tick_label_font_size', float64 'legend_font_size', string 'font_family') cil managed
  {
    .maxstack 8
    ldarg.0
    call instance void [mscorlib]System.Object::.ctor()
    ldarg.0
    ldarg.s 1
    stfld string StyleTheme::'name'
    ldarg.0
    ldarg.s 2
    stfld class Color StyleTheme::'bg_color'
    ldarg.0
    ldarg.s 3
    stfld class Color StyleTheme::'plot_area_color'
    ldarg.0
    ldarg.s 4
    stfld class Color StyleTheme::'axis_color'
    ldarg.0
    ldarg.s 5
    stfld class Color StyleTheme::'grid_color'
    ldarg.0
    ldarg.s 6
    stfld class Color StyleTheme::'text_color'
    ldarg.0
    ldarg.s 7
    stfld class Color StyleTheme::'title_color'
    ldarg.0
    ldarg.s 8
    stfld class Color StyleTheme::'legend_bg'
    ldarg.0
    ldarg.s 9
    stfld class Color StyleTheme::'legend_border'
    ldarg.0
    ldarg.s 10
    stfld float64 StyleTheme::'axis_line_width'
    ldarg.0
    ldarg.s 11
    stfld float64 StyleTheme::'grid_line_width'
    ldarg.0
    ldarg.s 12
    stfld int32 StyleTheme::'show_major_grid'
    ldarg.0
    ldarg.s 13
    stfld int32 StyleTheme::'show_minor_grid'
    ldarg.0
    ldarg.s 14
    stfld float64 StyleTheme::'title_font_size'
    ldarg.0
    ldarg.s 15
    stfld float64 StyleTheme::'axis_label_font_size'
    ldarg.0
    ldarg.s 16
    stfld float64 StyleTheme::'tick_label_font_size'
    ldarg.0
    ldarg.s 17
    stfld float64 StyleTheme::'legend_font_size'
    ldarg.0
    ldarg.s 18
    stfld string StyleTheme::'font_family'
    ldarg.0
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::.ctor()
    stfld class [mscorlib]System.Collections.Generic.List`1<class Color> StyleTheme::'palette'
    ret
  }
}
.class public auto ansi CoordinateTransform extends [mscorlib]System.Object
{
  .field public int32 'scale'
  .field public float64 'data_min'
  .field public float64 'data_max'
  .field public float64 'target_min'
  .field public float64 'target_max'
  .field public float64 'trans_min'
  .field public float64 'trans_max'
  .field public float64 'trans_range'
  .field public float64 'target_range'
  .method public hidebysig specialname rtspecialname instance void .ctor(int32 'scale', float64 'data_min', float64 'data_max', float64 'target_min', float64 'target_max', float64 'trans_min', float64 'trans_max', float64 'trans_range', float64 'target_range') cil managed
  {
    .maxstack 8
    ldarg.0
    call instance void [mscorlib]System.Object::.ctor()
    ldarg.0
    ldarg.s 1
    stfld int32 CoordinateTransform::'scale'
    ldarg.0
    ldarg.s 2
    stfld float64 CoordinateTransform::'data_min'
    ldarg.0
    ldarg.s 3
    stfld float64 CoordinateTransform::'data_max'
    ldarg.0
    ldarg.s 4
    stfld float64 CoordinateTransform::'target_min'
    ldarg.0
    ldarg.s 5
    stfld float64 CoordinateTransform::'target_max'
    ldarg.0
    ldarg.s 6
    stfld float64 CoordinateTransform::'trans_min'
    ldarg.0
    ldarg.s 7
    stfld float64 CoordinateTransform::'trans_max'
    ldarg.0
    ldarg.s 8
    stfld float64 CoordinateTransform::'trans_range'
    ldarg.0
    ldarg.s 9
    stfld float64 CoordinateTransform::'target_range'
    ret
  }
}
.class public auto ansi Tick extends [mscorlib]System.Object
{
  .field public float64 'position'
  .field public string 'label'
  .field public int32 'is_major'
  .method public hidebysig specialname rtspecialname instance void .ctor(float64 'position', string 'label', int32 'is_major') cil managed
  {
    .maxstack 8
    ldarg.0
    call instance void [mscorlib]System.Object::.ctor()
    ldarg.0
    ldarg.s 1
    stfld float64 Tick::'position'
    ldarg.0
    ldarg.s 2
    stfld string Tick::'label'
    ldarg.0
    ldarg.s 3
    stfld int32 Tick::'is_major'
    ret
  }
}
.class public auto ansi SvgRenderer extends [mscorlib]System.Object
{
  .field public float64 'width'
  .field public float64 'height'
  .field public float64 'dpi'
  .field public class [mscorlib]System.Collections.Generic.List`1<string> 'body'
  .method public hidebysig specialname rtspecialname instance void .ctor(float64 'width', float64 'height', float64 'dpi') cil managed
  {
    .maxstack 8
    ldarg.0
    call instance void [mscorlib]System.Object::.ctor()
    ldarg.0
    ldarg.s 1
    stfld float64 SvgRenderer::'width'
    ldarg.0
    ldarg.s 2
    stfld float64 SvgRenderer::'height'
    ldarg.0
    ldarg.s 3
    stfld float64 SvgRenderer::'dpi'
    ldarg.0
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<string>::.ctor()
    stfld class [mscorlib]System.Collections.Generic.List`1<string> SvgRenderer::'body'
    ret
  }
}
.class public auto ansi PlotElement extends [mscorlib]System.Object
{
  .field public int32 'kind'
  .field public string 'label'
  .field public int32 'visible'
  .field public class Color 'color'
  .field public float64 'line_width'
  .field public class [mscorlib]System.Collections.Generic.List`1<float64> 'xs'
  .field public class [mscorlib]System.Collections.Generic.List`1<float64> 'ys'
  .field public class [mscorlib]System.Collections.Generic.List`1<float64> 'grid_data'
  .field public int32 'grid_rows'
  .field public int32 'grid_cols'
  .field public float64 'x_min'
  .field public float64 'x_max'
  .field public float64 'y_min'
  .field public float64 'y_max'
  .field public float64 'point_size'
  .method public hidebysig specialname rtspecialname instance void .ctor(int32 'kind', string 'label', int32 'visible', class Color 'color', float64 'line_width', int32 'grid_rows', int32 'grid_cols', float64 'x_min', float64 'x_max', float64 'y_min', float64 'y_max', float64 'point_size') cil managed
  {
    .maxstack 8
    ldarg.0
    call instance void [mscorlib]System.Object::.ctor()
    ldarg.0
    ldarg.s 1
    stfld int32 PlotElement::'kind'
    ldarg.0
    ldarg.s 2
    stfld string PlotElement::'label'
    ldarg.0
    ldarg.s 3
    stfld int32 PlotElement::'visible'
    ldarg.0
    ldarg.s 4
    stfld class Color PlotElement::'color'
    ldarg.0
    ldarg.s 5
    stfld float64 PlotElement::'line_width'
    ldarg.0
    ldarg.s 6
    stfld int32 PlotElement::'grid_rows'
    ldarg.0
    ldarg.s 7
    stfld int32 PlotElement::'grid_cols'
    ldarg.0
    ldarg.s 8
    stfld float64 PlotElement::'x_min'
    ldarg.0
    ldarg.s 9
    stfld float64 PlotElement::'x_max'
    ldarg.0
    ldarg.s 10
    stfld float64 PlotElement::'y_min'
    ldarg.0
    ldarg.s 11
    stfld float64 PlotElement::'y_max'
    ldarg.0
    ldarg.s 12
    stfld float64 PlotElement::'point_size'
    ldarg.0
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<float64>::.ctor()
    stfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'xs'
    ldarg.0
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<float64>::.ctor()
    stfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'ys'
    ldarg.0
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<float64>::.ctor()
    stfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'grid_data'
    ret
  }
}
.class public auto ansi Axes2D extends [mscorlib]System.Object
{
  .field public string 'title'
  .field public string 'xlabel'
  .field public string 'ylabel'
  .field public class [mscorlib]System.Collections.Generic.List`1<class PlotElement> 'elements'
  .method public hidebysig specialname rtspecialname instance void .ctor(string 'title', string 'xlabel', string 'ylabel') cil managed
  {
    .maxstack 8
    ldarg.0
    call instance void [mscorlib]System.Object::.ctor()
    ldarg.0
    ldarg.s 1
    stfld string Axes2D::'title'
    ldarg.0
    ldarg.s 2
    stfld string Axes2D::'xlabel'
    ldarg.0
    ldarg.s 3
    stfld string Axes2D::'ylabel'
    ldarg.0
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<class PlotElement>::.ctor()
    stfld class [mscorlib]System.Collections.Generic.List`1<class PlotElement> Axes2D::'elements'
    ret
  }
}
.class public auto ansi Figure extends [mscorlib]System.Object
{
  .field public float64 'width_inches'
  .field public float64 'height_inches'
  .field public float64 'dpi'
  .field public class StyleTheme 'theme'
  .field public string 'title'
  .field public class Axes2D 'axes'
  .method public hidebysig specialname rtspecialname instance void .ctor(float64 'width_inches', float64 'height_inches', float64 'dpi', class StyleTheme 'theme', string 'title', class Axes2D 'axes') cil managed
  {
    .maxstack 8
    ldarg.0
    call instance void [mscorlib]System.Object::.ctor()
    ldarg.0
    ldarg.s 1
    stfld float64 Figure::'width_inches'
    ldarg.0
    ldarg.s 2
    stfld float64 Figure::'height_inches'
    ldarg.0
    ldarg.s 3
    stfld float64 Figure::'dpi'
    ldarg.0
    ldarg.s 4
    stfld class StyleTheme Figure::'theme'
    ldarg.0
    ldarg.s 5
    stfld string Figure::'title'
    ldarg.0
    ldarg.s 6
    stfld class Axes2D Figure::'axes'
    ret
  }
}

.class public sequential ansi sealed beforefieldinit TkvInt
       extends [mscorlib]System.ValueType
       implements class [mscorlib]System.IComparable`1<valuetype TkvInt>, [mscorlib]System.IComparable
{
  .field public int64 lo
  .field public object big
  .method public static valuetype TkvInt FromI64(int64 v) cil managed
  {
    .maxstack 8
    .locals init (valuetype TkvInt r)
    ldloca.s r
    ldarg.0
    stfld int64 TkvInt::lo
    ldloca.s r
    ldnull
    stfld object TkvInt::big
    ldloc.s r
    ret
  }
  .method public static valuetype TkvInt FromStr(string s) cil managed
  {
    .maxstack 8
    ldarg.0
    ldc.i4.7
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::Parse(string, valuetype [mscorlib]System.Globalization.NumberStyles, class [mscorlib]System.IFormatProvider)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt FromBig(valuetype [System.Numerics]System.Numerics.BigInteger b) cil managed
  {
    .maxstack 8
    .locals init (valuetype TkvInt r)
    ldarg.0
    ldc.i8 0x8000000000000000
    call bool [System.Numerics]System.Numerics.BigInteger::op_GreaterThanOrEqual(valuetype [System.Numerics]System.Numerics.BigInteger, int64)
    brfalse.s BIGPATH
    ldarg.0
    ldc.i8 0x7FFFFFFFFFFFFFFF
    call bool [System.Numerics]System.Numerics.BigInteger::op_LessThanOrEqual(valuetype [System.Numerics]System.Numerics.BigInteger, int64)
    brfalse.s BIGPATH
    ldloca.s r
    ldarg.0
    call int64 [System.Numerics]System.Numerics.BigInteger::op_Explicit(valuetype [System.Numerics]System.Numerics.BigInteger)
    stfld int64 TkvInt::lo
    ldloca.s r
    ldnull
    stfld object TkvInt::big
    ldloc.s r
    ret
  BIGPATH:
    ldloca.s r
    ldc.i8 0
    stfld int64 TkvInt::lo
    ldloca.s r
    ldarg.0
    box [System.Numerics]System.Numerics.BigInteger
    stfld object TkvInt::big
    ldloc.s r
    ret
  }
  .method public static valuetype [System.Numerics]System.Numerics.BigInteger ToBig(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    ldarga.s a
    ldfld object TkvInt::big
    brfalse.s FASTPATH
    ldarga.s a
    ldfld object TkvInt::big
    unbox.any [System.Numerics]System.Numerics.BigInteger
    ret
  FASTPATH:
    ldarga.s a
    ldfld int64 TkvInt::lo
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::op_Implicit(int64)
    ret
  }
  .method public static valuetype TkvInt AddSlow(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    ldarg.1
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::op_Addition(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt SubSlow(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    ldarg.1
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::op_Subtraction(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt MulSlow(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    ldarg.1
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::op_Multiply(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static int32 Cmp(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    .locals init (int64 x)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue.s SLOWPATH
    ldarga.s b
    ldfld object TkvInt::big
    brtrue.s SLOWPATH
    ldarga.s a
    ldfld int64 TkvInt::lo
    stloc.s x
    ldloca.s x
    ldarga.s b
    ldfld int64 TkvInt::lo
    call instance int32 [mscorlib]System.Int64::CompareTo(int64)
    ret
  SLOWPATH:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    ldarg.1
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    call int32 [System.Numerics]System.Numerics.BigInteger::Compare(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static string Str(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    .locals init (int64 x, valuetype [System.Numerics]System.Numerics.BigInteger b)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue.s SLOWPATH
    ldarga.s a
    ldfld int64 TkvInt::lo
    stloc.s x
    ldloca.s x
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call instance string [mscorlib]System.Int64::ToString(class [mscorlib]System.IFormatProvider)
    ret
  SLOWPATH:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    stloc.s b
    ldloca.s b
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call instance string [System.Numerics]System.Numerics.BigInteger::ToString(class [mscorlib]System.IFormatProvider)
    ret
  }
  .method public static int32 ToI32(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    ldarga.s a
    ldfld object TkvInt::big
    brtrue TOI32_BIG
    ldarga.s a
    ldfld int64 TkvInt::lo
    conv.ovf.i4
    ret
  TOI32_BIG:
    ldstr "chi so int qua lon: khong vua int32."
    newobj instance void [mscorlib]System.OverflowException::.ctor(string)
    throw
  }
  .method public static int64 ToI64(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    ldarga.s a
    ldfld object TkvInt::big
    brtrue TOI64_BIG
    ldarga.s a
    ldfld int64 TkvInt::lo
    ret
  TOI64_BIG:
    ldstr "gia tri int qua lon: khong vua int64."
    newobj instance void [mscorlib]System.OverflowException::.ctor(string)
    throw
  }
  .method public static float64 ToF64(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    .locals init (valuetype [System.Numerics]System.Numerics.BigInteger b, float64 d)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue TOF64_BIG
    ldarga.s a
    ldfld int64 TkvInt::lo
    conv.r8
    ret
  TOF64_BIG:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    stloc.s b
    ldloc.s b
    call float64 [System.Numerics]System.Numerics.BigInteger::op_Explicit(valuetype [System.Numerics]System.Numerics.BigInteger)
    stloc.s d
    ldloc.s d
    call bool [mscorlib]System.Double::IsInfinity(float64)
    brtrue TOF64_OVF
    ldloc.s d
    ret
  TOF64_OVF:
    ldstr "gia tri int qua lon de chuyen thanh float."
    newobj instance void [mscorlib]System.OverflowException::.ctor(string)
    throw
  }
  .method public hidebysig newslot virtual final instance int32 CompareTo(valuetype TkvInt other) cil managed
  {
    .maxstack 8
    .override method instance int32 class [mscorlib]System.IComparable`1<valuetype TkvInt>::CompareTo(!0)
    ldarg.0
    ldobj valuetype TkvInt
    ldarg.1
    call int32 TkvInt::Cmp(valuetype TkvInt, valuetype TkvInt)
    ret
  }
  .method public hidebysig newslot virtual final instance int32 CompareTo(object other) cil managed
  {
    .maxstack 8
    .override [mscorlib]System.IComparable::CompareTo
    ldarg.0
    ldobj valuetype TkvInt
    ldarg.1
    unbox.any valuetype TkvInt
    call int32 TkvInt::Cmp(valuetype TkvInt, valuetype TkvInt)
    ret
  }
  .method public static valuetype TkvInt FloorDiv(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    .locals init (int64 x, int64 y, int64 q, int64 r, valuetype [System.Numerics]System.Numerics.BigInteger ba, valuetype [System.Numerics]System.Numerics.BigInteger bb, valuetype [System.Numerics]System.Numerics.BigInteger bq, valuetype [System.Numerics]System.Numerics.BigInteger bdu)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue FD_SLOW
    ldarga.s b
    ldfld object TkvInt::big
    brtrue FD_SLOW
    ldarga.s a
    ldfld int64 TkvInt::lo
    stloc.s x
    ldarga.s b
    ldfld int64 TkvInt::lo
    stloc.s y
    ldloc.s y
    ldc.i8 0
    beq FD_SLOW
    ldloc.s y
    ldc.i8 -1
    beq FD_SLOW
    ldloc.s x
    ldloc.s y
    div
    stloc.s q
    ldloc.s x
    ldloc.s y
    rem
    stloc.s r
    ldloc.s r
    ldc.i8 0
    beq FD_FAST_DONE
    ldloc.s x
    ldloc.s y
    xor
    ldc.i8 0
    bge FD_FAST_DONE
    ldloc.s q
    ldc.i8 1
    sub
    stloc.s q
  FD_FAST_DONE:
    ldloc.s q
    call valuetype TkvInt TkvInt::FromI64(int64)
    ret
  FD_SLOW:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    stloc.s ba
    ldarg.1
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    stloc.s bb
    ldloc.s ba
    ldloc.s bb
    ldloca.s bdu
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::DivRem(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger&)
    stloc.s bq
    ldloca.s bdu
    call instance int32 [System.Numerics]System.Numerics.BigInteger::get_Sign()
    ldc.i4.0
    beq FD_SLOW_DONE
    ldloca.s bdu
    call instance int32 [System.Numerics]System.Numerics.BigInteger::get_Sign()
    ldloca.s bb
    call instance int32 [System.Numerics]System.Numerics.BigInteger::get_Sign()
    beq FD_SLOW_DONE
    ldloc.s bq
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::get_One()
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::op_Subtraction(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger)
    stloc.s bq
  FD_SLOW_DONE:
    ldloc.s bq
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt Mod(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    .locals init (int64 x, int64 y, int64 q, int64 r, valuetype [System.Numerics]System.Numerics.BigInteger ba, valuetype [System.Numerics]System.Numerics.BigInteger bb, valuetype [System.Numerics]System.Numerics.BigInteger bq, valuetype [System.Numerics]System.Numerics.BigInteger bdu)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue MD_SLOW
    ldarga.s b
    ldfld object TkvInt::big
    brtrue MD_SLOW
    ldarga.s a
    ldfld int64 TkvInt::lo
    stloc.s x
    ldarga.s b
    ldfld int64 TkvInt::lo
    stloc.s y
    ldloc.s y
    ldc.i8 0
    beq MD_SLOW
    ldloc.s y
    ldc.i8 -1
    beq MD_SLOW
    ldloc.s x
    ldloc.s y
    rem
    stloc.s r
    ldloc.s r
    ldc.i8 0
    beq MD_FAST_DONE
    ldloc.s r
    ldloc.s y
    xor
    ldc.i8 0
    bge MD_FAST_DONE
    ldloc.s r
    ldloc.s y
    add
    stloc.s r
  MD_FAST_DONE:
    ldloc.s r
    call valuetype TkvInt TkvInt::FromI64(int64)
    ret
  MD_SLOW:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    stloc.s ba
    ldarg.1
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    stloc.s bb
    ldloc.s ba
    ldloc.s bb
    ldloca.s bdu
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::DivRem(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger&)
    stloc.s bq
    ldloca.s bdu
    call instance int32 [System.Numerics]System.Numerics.BigInteger::get_Sign()
    ldc.i4.0
    beq MD_SLOW_DONE
    ldloca.s bdu
    call instance int32 [System.Numerics]System.Numerics.BigInteger::get_Sign()
    ldloca.s bb
    call instance int32 [System.Numerics]System.Numerics.BigInteger::get_Sign()
    beq MD_SLOW_DONE
    ldloc.s bdu
    ldloc.s bb
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::op_Addition(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger)
    stloc.s bdu
  MD_SLOW_DONE:
    ldloc.s bdu
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt Pow(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    .locals init (int64 e)
    ldarga.s b
    ldfld object TkvInt::big
    brtrue PW_HUGE
    ldarga.s b
    ldfld int64 TkvInt::lo
    stloc.s e
    ldloc.s e
    ldc.i8 0
    blt PW_NEG
    ldloc.s e
    ldc.i8 2147483647
    bgt PW_HUGE
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    ldloc.s e
    conv.i4
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::Pow(valuetype [System.Numerics]System.Numerics.BigInteger, int32)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  PW_NEG:
    ldstr "int ** so mu am tra ve float trong Python - TokenVector chua co duong int->float (moc 10). Doi ve f64 truoc khi luy thua."
    newobj instance void [mscorlib]System.NotSupportedException::.ctor(string)
    throw
  PW_HUGE:
    ldstr "int ** so mu qua lon (> 2^31-1): ket qua khong the vua bo nho."
    newobj instance void [mscorlib]System.OverflowException::.ctor(string)
    throw
  }
  .method public static valuetype TkvInt Neg(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    .locals init (int64 x)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue NG_SLOW
    ldarga.s a
    ldfld int64 TkvInt::lo
    stloc.s x
    ldloc.s x
    ldc.i8 0x8000000000000000
    beq NG_SLOW
    ldc.i8 0
    ldloc.s x
    sub
    call valuetype TkvInt TkvInt::FromI64(int64)
    ret
  NG_SLOW:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::Negate(valuetype [System.Numerics]System.Numerics.BigInteger)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt Add(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    .locals init (int64 x, int64 y, int64 r)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue AD_SLOW
    ldarga.s b
    ldfld object TkvInt::big
    brtrue AD_SLOW
    ldarga.s a
    ldfld int64 TkvInt::lo
    stloc.s x
    ldarga.s b
    ldfld int64 TkvInt::lo
    stloc.s y
    ldloc.s x
    ldloc.s y
    add
    stloc.s r
    ldloc.s x
    ldloc.s r
    xor
    ldloc.s y
    ldloc.s r
    xor
    and
    ldc.i8 0
    blt AD_SLOW
    ldloc.s r
    call valuetype TkvInt TkvInt::FromI64(int64)
    ret
  AD_SLOW:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    ldarg.1
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::op_Addition(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt Abs(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    .locals init (int64 x)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue AB_SLOW
    ldarga.s a
    ldfld int64 TkvInt::lo
    stloc.s x
    ldloc.s x
    ldc.i8 0
    bge AB_POS
    ldloc.s x
    ldc.i8 0x8000000000000000
    beq AB_SLOW
    ldc.i8 0
    ldloc.s x
    sub
    call valuetype TkvInt TkvInt::FromI64(int64)
    ret
  AB_POS:
    ldarg.0
    ret
  AB_SLOW:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::Abs(valuetype [System.Numerics]System.Numerics.BigInteger)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt FromF64(float64 d) cil managed
  {
    .maxstack 8
    ldarg.0
    newobj instance void [System.Numerics]System.Numerics.BigInteger::.ctor(float64)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static int32 IsZero(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    ldarga.s a
    ldfld object TkvInt::big
    brtrue IZ_BIG
    ldarga.s a
    ldfld int64 TkvInt::lo
    ldc.i8 0
    ceq
    ret
  IZ_BIG:
    ldc.i4.0
    ret
  }
}
.class public abstract sealed auto ansi TkvStr
       extends [mscorlib]System.Object
{
  .method public static string I32(int32 v) cil managed
  {
    .maxstack 8
    ldarga.s 0
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call instance string [mscorlib]System.Int32::ToString(class [mscorlib]System.IFormatProvider)
    ret
  }
  .method public static string I64(int64 v) cil managed
  {
    .maxstack 8
    ldarga.s 0
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call instance string [mscorlib]System.Int64::ToString(class [mscorlib]System.IFormatProvider)
    ret
  }
  .method public static string Bool(int32 v) cil managed
  {
    .maxstack 8
    ldarg.0
    brfalse BOOL_FALSE
    ldstr "True"
    ret
  BOOL_FALSE:
    ldstr "False"
    ret
  }
  .method public static string F64(float64 v) cil managed
  {
    .maxstack 8
    .locals init (string s)
    ldarg.0
    call bool [mscorlib]System.Double::IsNaN(float64)
    brfalse F64_NOTNAN
    ldstr "nan"
    ret
  F64_NOTNAN:
    ldarg.0
    call bool [mscorlib]System.Double::IsInfinity(float64)
    brfalse F64_NOTINF
    ldarg.0
    ldc.r8 0.0
    blt F64_NEGINF
    ldstr "inf"
    ret
  F64_NEGINF:
    ldstr "-inf"
    ret
  F64_NOTINF:
    ldarg.0
    ldc.r8 0.0
    bne.un F64_NOTZERO
    ldarg.0
    call int64 [mscorlib]System.BitConverter::DoubleToInt64Bits(float64)
    ldc.i8 0
    blt F64_NEGZERO
    ldstr "0.0"
    ret
  F64_NEGZERO:
    ldstr "-0.0"
    ret
  F64_NOTZERO:
    ldarga.s 0
    ldstr "G15"
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call instance string [mscorlib]System.Double::ToString(string, class [mscorlib]System.IFormatProvider)
    stloc.s s
    ldloc.s s
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call float64 [mscorlib]System.Double::Parse(string, class [mscorlib]System.IFormatProvider)
    ldarg.0
    beq LAD_DONE
    ldarga.s 0
    ldstr "G16"
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call instance string [mscorlib]System.Double::ToString(string, class [mscorlib]System.IFormatProvider)
    stloc.s s
    ldloc.s s
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call float64 [mscorlib]System.Double::Parse(string, class [mscorlib]System.IFormatProvider)
    ldarg.0
    beq LAD_DONE
    ldarga.s 0
    ldstr "G17"
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call instance string [mscorlib]System.Double::ToString(string, class [mscorlib]System.IFormatProvider)
    stloc.s s
  LAD_DONE:
    ldloc.s s
    call string TkvStr::Post(string)
    ret
  }
  .method public static string F32(float32 v) cil managed
  {
    .maxstack 8
    .locals init (string s)
    ldarg.0
    call bool [mscorlib]System.Single::IsNaN(float32)
    brfalse F32_NOTNAN
    ldstr "nan"
    ret
  F32_NOTNAN:
    ldarg.0
    call bool [mscorlib]System.Single::IsInfinity(float32)
    brfalse F32_NOTINF
    ldarg.0
    ldc.r4 0.0
    blt F32_NEGINF
    ldstr "inf"
    ret
  F32_NEGINF:
    ldstr "-inf"
    ret
  F32_NOTINF:
    ldarga.s 0
    ldstr "G7"
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call instance string [mscorlib]System.Single::ToString(string, class [mscorlib]System.IFormatProvider)
    stloc.s s
    ldloc.s s
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call float32 [mscorlib]System.Single::Parse(string, class [mscorlib]System.IFormatProvider)
    ldarg.0
    beq LAD_DONE
    ldarga.s 0
    ldstr "G8"
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call instance string [mscorlib]System.Single::ToString(string, class [mscorlib]System.IFormatProvider)
    stloc.s s
    ldloc.s s
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call float32 [mscorlib]System.Single::Parse(string, class [mscorlib]System.IFormatProvider)
    ldarg.0
    beq LAD_DONE
    ldarga.s 0
    ldstr "G9"
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call instance string [mscorlib]System.Single::ToString(string, class [mscorlib]System.IFormatProvider)
    stloc.s s
  LAD_DONE:
    ldloc.s s
    call string TkvStr::Post(string)
    ret
  }
  .method public static string Post(string s) cil managed
  {
    .maxstack 8
    .locals init (int32 i, int32 e)
    ldarg.0
    ldc.i4 69
    callvirt instance int32 [mscorlib]System.String::IndexOf(char)
    stloc.s i
    ldloc.s i
    ldc.i4.0
    blt PS_NOEXP
    ldarg.0
    ldloc.s i
    ldc.i4.1
    add
    callvirt instance string [mscorlib]System.String::Substring(int32)
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call int32 [mscorlib]System.Int32::Parse(string, class [mscorlib]System.IFormatProvider)
    stloc.s e
    ldloc.s e
    ldc.i4 15
    bne.un PS_LOWER
    ldarg.0
    ldloc.s i
    call string TkvStr::Expand16(string, int32)
    ret
  PS_LOWER:
    ldarg.0
    ldstr "E"
    ldstr "e"
    callvirt instance string [mscorlib]System.String::Replace(string, string)
    ret
  PS_NOEXP:
    ldarg.0
    ldstr "."
    callvirt instance bool [mscorlib]System.String::Contains(string)
    brtrue PS_ASIS
    ldarg.0
    ldstr ".0"
    call string [mscorlib]System.String::Concat(string, string)
    ret
  PS_ASIS:
    ldarg.0
    ret
  }
  .method public static string Expand16(string s, int32 epos) cil managed
  {
    .maxstack 8
    .locals init (string sign, string mant, string digs, string frac)
    ldstr ""
    stloc.s sign
    ldarg.0
    ldc.i4.0
    ldarg.1
    callvirt instance string [mscorlib]System.String::Substring(int32, int32)
    stloc.s mant
    ldloc.s mant
    ldstr "-"
    callvirt instance bool [mscorlib]System.String::StartsWith(string)
    brfalse EX_NOSIGN
    ldstr "-"
    stloc.s sign
    ldloc.s mant
    ldc.i4.1
    callvirt instance string [mscorlib]System.String::Substring(int32)
    stloc.s mant
  EX_NOSIGN:
    ldloc.s mant
    ldstr "."
    ldstr ""
    callvirt instance string [mscorlib]System.String::Replace(string, string)
    stloc.s digs
    ldloc.s digs
    callvirt instance int32 [mscorlib]System.String::get_Length()
    ldc.i4 16
    bgt EX_LONG
    ldloc.s digs
    ldc.i4 16
    ldc.i4 48
    callvirt instance string [mscorlib]System.String::PadRight(int32, char)
    stloc.s digs
    ldstr "0"
    stloc.s frac
    br EX_JOIN
  EX_LONG:
    ldloc.s digs
    ldc.i4 16
    callvirt instance string [mscorlib]System.String::Substring(int32)
    stloc.s frac
    ldloc.s digs
    ldc.i4.0
    ldc.i4 16
    callvirt instance string [mscorlib]System.String::Substring(int32, int32)
    stloc.s digs
  EX_JOIN:
    ldloc.s sign
    ldloc.s digs
    ldstr "."
    ldloc.s frac
    call string [mscorlib]System.String::Concat(string, string, string, string)
    ret
  }
  .method public static float64 ParseF64(string s) cil managed
  {
    .maxstack 8
    .locals init (string t)
    ldarg.0
    callvirt instance string [mscorlib]System.String::Trim()
    callvirt instance string [mscorlib]System.String::ToLowerInvariant()
    stloc.s t
    ldloc.s t
    ldstr "inf"
    call bool [mscorlib]System.String::op_Equality(string, string)
    brtrue PF_INF
    ldloc.s t
    ldstr "infinity"
    call bool [mscorlib]System.String::op_Equality(string, string)
    brtrue PF_INF
    ldloc.s t
    ldstr "+inf"
    call bool [mscorlib]System.String::op_Equality(string, string)
    brtrue PF_INF
    ldloc.s t
    ldstr "-inf"
    call bool [mscorlib]System.String::op_Equality(string, string)
    brtrue PF_NEGINF
    ldloc.s t
    ldstr "-infinity"
    call bool [mscorlib]System.String::op_Equality(string, string)
    brtrue PF_NEGINF
    ldloc.s t
    ldstr "nan"
    call bool [mscorlib]System.String::op_Equality(string, string)
    brtrue PF_NAN
    ldarg.0
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call float64 [mscorlib]System.Double::Parse(string, class [mscorlib]System.IFormatProvider)
    ret
  PF_INF:
    ldc.r8 (00 00 00 00 00 00 F0 7F)
    ret
  PF_NEGINF:
    ldc.r8 (00 00 00 00 00 00 F0 FF)
    ret
  PF_NAN:
    ldc.r8 (00 00 00 00 00 00 F8 FF)
    ret
  }
  .method public static string Replace(string src, string oldStr, string newStr) cil managed
  {
    .maxstack 8
    .locals init (int32 i, int32 n, class [mscorlib]System.Text.StringBuilder sb)
    ldarg.1
    callvirt instance int32 [mscorlib]System.String::get_Length()
    brtrue RP_NORMAL
    ldarg.0
    callvirt instance int32 [mscorlib]System.String::get_Length()
    stloc.s n
    ldloc.s n
    ldc.i4.1
    add
    ldarg.2
    callvirt instance int32 [mscorlib]System.String::get_Length()
    mul
    ldloc.s n
    add
    newobj instance void [mscorlib]System.Text.StringBuilder::.ctor(int32)
    stloc.s sb
    ldc.i4.0
    stloc.s i
  RP_LOOP:
    ldloc.s i
    ldloc.s n
    bge RP_TAIL
    ldloc.s sb
    ldarg.2
    callvirt instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
    pop
    ldloc.s sb
    ldarg.0
    ldloc.s i
    callvirt instance char [mscorlib]System.String::get_Chars(int32)
    callvirt instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(char)
    pop
    ldloc.s i
    ldc.i4.1
    add
    stloc.s i
    br RP_LOOP
  RP_TAIL:
    ldloc.s sb
    ldarg.2
    callvirt instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
    pop
    ldloc.s sb
    callvirt instance string [mscorlib]System.Text.StringBuilder::ToString()
    ret
  RP_NORMAL:
    ldarg.0
    ldarg.1
    ldarg.2
    callvirt instance string [mscorlib]System.String::Replace(string, string)
    ret
  }
  .method public static string ReplaceCount(string src, string oldStr, string newStr, int32 count) cil managed
  {
    .maxstack 8
    .locals init (int32 i, int32 n, int32 pos, int32 replaced, int32 idx, class [mscorlib]System.Text.StringBuilder sb)
    ldarg.3
    ldc.i4.0
    bge RC_NONNEG
    ldarg.0
    ldarg.1
    ldarg.2
    call string TkvStr::Replace(string, string, string)
    ret
  RC_NONNEG:
    ldarg.1
    callvirt instance int32 [mscorlib]System.String::get_Length()
    brtrue RC_OLDNONEMPTY
    ldarg.0
    callvirt instance int32 [mscorlib]System.String::get_Length()
    stloc.s n
    newobj instance void [mscorlib]System.Text.StringBuilder::.ctor()
    stloc.s sb
    ldc.i4.0
    stloc.s i
  RC_EMPTY_LOOP:
    ldloc.s i
    ldarg.3
    bge RC_EMPTY_TAIL
    ldloc.s i
    ldloc.s n
    bge RC_EMPTY_TAIL
    ldloc.s sb
    ldarg.2
    callvirt instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
    pop
    ldloc.s sb
    ldarg.0
    ldloc.s i
    callvirt instance char [mscorlib]System.String::get_Chars(int32)
    callvirt instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(char)
    pop
    ldloc.s i
    ldc.i4.1
    add
    stloc.s i
    br RC_EMPTY_LOOP
  RC_EMPTY_TAIL:
    ldarg.3
    ldloc.s n
    ble RC_EMPTY_NOEXTRA
    ldloc.s sb
    ldarg.2
    callvirt instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
    pop
  RC_EMPTY_NOEXTRA:
    ldloc.s sb
    ldarg.0
    ldloc.s i
    callvirt instance string [mscorlib]System.String::Substring(int32)
    callvirt instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
    pop
    ldloc.s sb
    callvirt instance string [mscorlib]System.Text.StringBuilder::ToString()
    ret
  RC_OLDNONEMPTY:
    ldc.i4.0
    stloc.s pos
    ldc.i4.0
    stloc.s replaced
    newobj instance void [mscorlib]System.Text.StringBuilder::.ctor()
    stloc.s sb
  RC_LOOP:
    ldloc.s replaced
    ldarg.3
    bge RC_TAIL
    ldarg.0
    ldarg.1
    ldloc.s pos
    callvirt instance int32 [mscorlib]System.String::IndexOf(string, int32)
    stloc.s idx
    ldloc.s idx
    ldc.i4.0
    blt RC_TAIL
    ldloc.s sb
    ldarg.0
    ldloc.s pos
    ldloc.s idx
    ldloc.s pos
    sub
    callvirt instance string [mscorlib]System.String::Substring(int32, int32)
    callvirt instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
    pop
    ldloc.s sb
    ldarg.2
    callvirt instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
    pop
    ldloc.s idx
    ldarg.1
    callvirt instance int32 [mscorlib]System.String::get_Length()
    add
    stloc.s pos
    ldloc.s replaced
    ldc.i4.1
    add
    stloc.s replaced
    br RC_LOOP
  RC_TAIL:
    ldloc.s sb
    ldarg.0
    ldloc.s pos
    callvirt instance string [mscorlib]System.String::Substring(int32)
    callvirt instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
    pop
    ldloc.s sb
    callvirt instance string [mscorlib]System.Text.StringBuilder::ToString()
    ret
  }
  .method public static int32 RFind(string src, string subStr) cil managed
  {
    .maxstack 8
    ldarg.1
    callvirt instance int32 [mscorlib]System.String::get_Length()
    brtrue RF_NORMAL
    ldarg.0
    callvirt instance int32 [mscorlib]System.String::get_Length()
    ret
  RF_NORMAL:
    ldarg.0
    ldarg.1
    callvirt instance int32 [mscorlib]System.String::LastIndexOf(string)
    ret
  }
  .method public static int32 IsDigit(string s) cil managed
  {
    .maxstack 8
    .locals init (int32 i, int32 n)
    ldarg.0
    callvirt instance int32 [mscorlib]System.String::get_Length()
    stloc.s n
    ldloc.s n
    brtrue ID_INIT
    ldc.i4.0
    ret
  ID_INIT:
    ldc.i4.0
    stloc.s i
  ID_LOOP:
    ldloc.s i
    ldloc.s n
    bge ID_TRUE
    ldarg.0
    ldloc.s i
    callvirt instance char [mscorlib]System.String::get_Chars(int32)
    call bool [mscorlib]System.Char::IsDigit(char)
    brfalse ID_FALSE
    ldloc.s i
    ldc.i4.1
    add
    stloc.s i
    br ID_LOOP
  ID_FALSE:
    ldc.i4.0
    ret
  ID_TRUE:
    ldc.i4.1
    ret
  }
}

.class public auto ansi TKVApp extends [mscorlib]System.Object
{
  .method public static class Color 'make_color'(int32 'r', int32 'g', int32 'b', int32 'a') cil managed
  {
    .maxstack 12
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    ldarg.s 1
    ldarg.s 2
    ldarg.s 3
    newobj instance void Color::.ctor(int32, int32, int32, int32)
    ret
  }
  .method public static class Color 'color_transparent'() cil managed
  {
    .maxstack 12
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldc.i4 0
    ldc.i4 0
    ldc.i4 0
    ldc.i4 0
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    ret
  }
  .method public static class Color 'color_black'() cil managed
  {
    .maxstack 12
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldc.i4 0
    ldc.i4 0
    ldc.i4 0
    ldc.i4 255
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    ret
  }
  .method public static class Color 'color_white'() cil managed
  {
    .maxstack 12
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldc.i4 255
    ldc.i4 255
    ldc.i4 255
    ldc.i4 255
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    ret
  }
  .method public static class Color 'color_red'() cil managed
  {
    .maxstack 12
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldc.i4 235
    ldc.i4 64
    ldc.i4 52
    ldc.i4 255
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    ret
  }
  .method public static class Color 'color_green'() cil managed
  {
    .maxstack 12
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldc.i4 46
    ldc.i4 204
    ldc.i4 113
    ldc.i4 255
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    ret
  }
  .method public static class Color 'color_blue'() cil managed
  {
    .maxstack 12
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldc.i4 52
    ldc.i4 152
    ldc.i4 219
    ldc.i4 255
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    ret
  }
  .method public static class Color 'color_gray'() cil managed
  {
    .maxstack 12
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldc.i4 128
    ldc.i4 128
    ldc.i4 128
    ldc.i4 255
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    ret
  }
  .method public static class Color 'color_light_gray'() cil managed
  {
    .maxstack 12
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldc.i4 220
    ldc.i4 220
    ldc.i4 220
    ldc.i4 255
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    ret
  }
  .method public static class Color 'color_dark_gray'() cil managed
  {
    .maxstack 12
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldc.i4 50
    ldc.i4 50
    ldc.i4 50
    ldc.i4 255
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    ret
  }
  .method public static int32 '_hex_byte'(string 'hex_str', int32 'start') cil managed
  {
    .maxstack 11
    .locals init (string 'sub', int32 '__slice2081116260128_start', valuetype TkvInt 'val', int32 'i', string 'ch', valuetype TkvInt 'cval', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 1
    stloc.s 1
    ldarg.s 0
    ldloc.s 1
    ldarg.s 1
    ldc.i4 2
    add.ovf
    ldloc.s 1
    sub
    callvirt instance string [mscorlib]System.String::Substring(int32, int32)
    callvirt instance string [mscorlib]System.String::ToLower()
    stloc.s 0
    ldc.i8 0
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 2
    ldc.i4.0
    stloc.s 3
  _hex_byte_L1_start:
    ldloc.s 3
    ldc.i4 2
    bge _hex_byte_L1_end
    ldloc.s 0
    ldloc.s 3
    callvirt instance char [mscorlib]System.String::get_Chars(int32)
    ldc.i4.1
    newobj instance void [mscorlib]System.String::.ctor(char, int32)
    stloc.s 4
    ldc.i8 0
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 5
    ldloc.s 4
    ldstr "0"
    call int32 [mscorlib]System.String::CompareOrdinal(string, string)
    ldc.i4.0
    clt
    ldc.i4.0
    ceq
    dup
    brfalse _hex_byte_sc3_end
    pop
    ldloc.s 4
    ldstr "9"
    call int32 [mscorlib]System.String::CompareOrdinal(string, string)
    ldc.i4.0
    cgt
    ldc.i4.0
    ceq
  _hex_byte_sc3_end:
    brfalse _hex_byte_If2_else
    ldloc.s 4
    call valuetype TkvInt TkvInt::FromStr(string)
    stloc.s 5
    br _hex_byte_If2_end
  _hex_byte_If2_else:
    ldloc.s 4
    ldstr "a"
    call bool [mscorlib]System.String::Equals(string, string)
    brfalse _hex_byte_If4_else
    ldc.i8 10
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 5
    br _hex_byte_If4_end
  _hex_byte_If4_else:
    ldloc.s 4
    ldstr "b"
    call bool [mscorlib]System.String::Equals(string, string)
    brfalse _hex_byte_If5_else
    ldc.i8 11
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 5
    br _hex_byte_If5_end
  _hex_byte_If5_else:
    ldloc.s 4
    ldstr "c"
    call bool [mscorlib]System.String::Equals(string, string)
    brfalse _hex_byte_If6_else
    ldc.i8 12
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 5
    br _hex_byte_If6_end
  _hex_byte_If6_else:
    ldloc.s 4
    ldstr "d"
    call bool [mscorlib]System.String::Equals(string, string)
    brfalse _hex_byte_If7_else
    ldc.i8 13
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 5
    br _hex_byte_If7_end
  _hex_byte_If7_else:
    ldloc.s 4
    ldstr "e"
    call bool [mscorlib]System.String::Equals(string, string)
    brfalse _hex_byte_If8_else
    ldc.i8 14
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 5
    br _hex_byte_If8_end
  _hex_byte_If8_else:
    ldloc.s 4
    ldstr "f"
    call bool [mscorlib]System.String::Equals(string, string)
    brfalse _hex_byte_If9_else
    ldc.i8 15
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 5
  _hex_byte_If9_else:
  _hex_byte_If8_end:
  _hex_byte_If7_end:
  _hex_byte_If6_end:
  _hex_byte_If5_end:
  _hex_byte_If4_end:
  _hex_byte_If2_end:
    ldloc.s 2
    ldc.i8 16
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 7
    stloc.s 6
    ldloca.s 6
    ldfld object TkvInt::big
    brtrue _hex_byte_int10_slow
    ldloca.s 7
    ldfld object TkvInt::big
    brtrue _hex_byte_int10_slow
    ldloca.s 6
    ldfld int64 TkvInt::lo
    ldc.i8 -2147483648
    blt _hex_byte_int10_slow
    ldloca.s 6
    ldfld int64 TkvInt::lo
    ldc.i8 2147483647
    bgt _hex_byte_int10_slow
    ldloca.s 7
    ldfld int64 TkvInt::lo
    ldc.i8 -2147483648
    blt _hex_byte_int10_slow
    ldloca.s 7
    ldfld int64 TkvInt::lo
    ldc.i8 2147483647
    bgt _hex_byte_int10_slow
    ldloca.s 6
    ldfld int64 TkvInt::lo
    ldloca.s 7
    ldfld int64 TkvInt::lo
    mul
    stloc.s 9
    ldloca.s 8
    ldloc.s 9
    stfld int64 TkvInt::lo
    ldloca.s 8
    ldnull
    stfld object TkvInt::big
    ldloc.s 8
    br _hex_byte_int10_done
  _hex_byte_int10_slow:
    ldloc.s 6
    ldloc.s 7
    call valuetype TkvInt TkvInt::MulSlow(valuetype TkvInt, valuetype TkvInt)
  _hex_byte_int10_done:
    ldloc.s 5
    stloc.s 7
    stloc.s 6
    ldloca.s 6
    ldfld object TkvInt::big
    brtrue _hex_byte_int11_slow
    ldloca.s 7
    ldfld object TkvInt::big
    brtrue _hex_byte_int11_slow
    ldloca.s 6
    ldfld int64 TkvInt::lo
    ldloca.s 7
    ldfld int64 TkvInt::lo
    add
    stloc.s 9
    ldloca.s 6
    ldfld int64 TkvInt::lo
    ldloc.s 9
    xor
    ldloca.s 7
    ldfld int64 TkvInt::lo
    ldloc.s 9
    xor
    and
    ldc.i8 0
    blt _hex_byte_int11_slow
    ldloca.s 8
    ldloc.s 9
    stfld int64 TkvInt::lo
    ldloca.s 8
    ldnull
    stfld object TkvInt::big
    ldloc.s 8
    br _hex_byte_int11_done
  _hex_byte_int11_slow:
    ldloc.s 6
    ldloc.s 7
    call valuetype TkvInt TkvInt::AddSlow(valuetype TkvInt, valuetype TkvInt)
  _hex_byte_int11_done:
    stloc.s 2
  _hex_byte_L1_cont:
    ldloc.s 3
    ldc.i4 1
    add
    stloc.s 3
    br _hex_byte_L1_start
  _hex_byte_L1_end:
    ldloc.s 2
    call int32 TkvInt::ToI32(valuetype TkvInt)
    ret
  }
  .method public static class Color 'color_from_hex'(string 'hex_str') cil managed
  {
    .maxstack 12
    .locals init (string 'clean', int32 '__slice2081115989440_start', int32 'ln', int32 'r', int32 'g', int32 'b', int32 'a', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    stloc.s 0
    ldarg.s 0
    ldstr "#"
    callvirt instance bool [mscorlib]System.String::StartsWith(string)
    brfalse color_from_hex_If1_else
    ldc.i4 1
    stloc.s 1
    ldarg.s 0
    ldloc.s 1
    ldarg.s 0
    callvirt instance int32 [mscorlib]System.String::get_Length()
    ldloc.s 1
    sub
    callvirt instance string [mscorlib]System.String::Substring(int32, int32)
    stloc.s 0
  color_from_hex_If1_else:
    ldloc.s 0
    callvirt instance int32 [mscorlib]System.String::get_Length()
    stloc.s 2
    ldloc.s 2
    ldc.i4 6
    ceq
    brfalse color_from_hex_If2_else
    ldloc.s 0
    ldc.i4 0
    call int32 TKVApp::'_hex_byte'(string, int32)
    stloc.s 3
    ldloc.s 0
    ldc.i4 2
    call int32 TKVApp::'_hex_byte'(string, int32)
    stloc.s 4
    ldloc.s 0
    ldc.i4 4
    call int32 TKVApp::'_hex_byte'(string, int32)
    stloc.s 5
    ldloc.s 3
    ldloc.s 4
    ldloc.s 5
    ldc.i4 255
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    ret
  color_from_hex_If2_else:
    ldloc.s 2
    ldc.i4 8
    ceq
    brfalse color_from_hex_If3_else
    ldloc.s 0
    ldc.i4 0
    call int32 TKVApp::'_hex_byte'(string, int32)
    stloc.s 3
    ldloc.s 0
    ldc.i4 2
    call int32 TKVApp::'_hex_byte'(string, int32)
    stloc.s 4
    ldloc.s 0
    ldc.i4 4
    call int32 TKVApp::'_hex_byte'(string, int32)
    stloc.s 5
    ldloc.s 0
    ldc.i4 6
    call int32 TKVApp::'_hex_byte'(string, int32)
    stloc.s 6
    ldloc.s 3
    ldloc.s 4
    ldloc.s 5
    ldloc.s 6
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    ret
  color_from_hex_If3_else:
    call class Color TKVApp::'color_black'()
    ret
  }
  .method public static string '_byte_to_hex'(int32 'b') cil managed
  {
    .maxstack 10
    .locals init (int32 'v', int32 'hi', int32 '__idiv2081115995040_a', int32 '__idiv2081115995040_b', int32 '__idiv2081115995040_q', int32 '__idiv2081115995040_r', int32 'lo', int32 '__idiv2081115995120_a', int32 '__idiv2081115995120_b', int32 '__idiv2081115995120_q', int32 '__idiv2081115995120_r', string 'digits', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    stloc.s 0
    ldloc.s 0
    ldc.i4 0
    clt
    brfalse _byte_to_hex_If1_else
    ldc.i4 0
    stloc.s 0
  _byte_to_hex_If1_else:
    ldloc.s 0
    ldc.i4 255
    cgt
    brfalse _byte_to_hex_If2_else
    ldc.i4 255
    stloc.s 0
  _byte_to_hex_If2_else:
    ldloc.s 0
    stloc.s 2
    ldc.i4 16
    stloc.s 3
    ldloc.s 2
    ldloc.s 3
    div
    stloc.s 4
    ldloc.s 2
    ldloc.s 3
    rem
    stloc.s 5
    ldloc.s 5
    ldc.i4.0
    beq _byte_to_hex_idiv3_done
    ldloc.s 2
    ldloc.s 3
    xor
    ldc.i4.0
    bge _byte_to_hex_idiv3_done
    ldloc.s 4
    ldc.i4.1
    sub
    stloc.s 4
  _byte_to_hex_idiv3_done:
    ldloc.s 4
    stloc.s 1
    ldloc.s 0
    stloc.s 7
    ldc.i4 16
    stloc.s 8
    ldloc.s 7
    ldloc.s 8
    div
    stloc.s 9
    ldloc.s 7
    ldloc.s 8
    rem
    stloc.s 10
    ldloc.s 10
    ldc.i4.0
    beq _byte_to_hex_idiv4_done
    ldloc.s 10
    ldloc.s 8
    xor
    ldc.i4.0
    bge _byte_to_hex_idiv4_done
    ldloc.s 10
    ldloc.s 8
    add
    stloc.s 10
  _byte_to_hex_idiv4_done:
    ldloc.s 10
    stloc.s 6
    ldstr "0123456789ABCDEF"
    stloc.s 11
    ldloc.s 11
    ldloc.s 1
    callvirt instance char [mscorlib]System.String::get_Chars(int32)
    ldc.i4.1
    newobj instance void [mscorlib]System.String::.ctor(char, int32)
    ldloc.s 11
    ldloc.s 6
    callvirt instance char [mscorlib]System.String::get_Chars(int32)
    ldc.i4.1
    newobj instance void [mscorlib]System.String::.ctor(char, int32)
    call string [mscorlib]System.String::Concat(string, string)
    ret
  }
  .method public static string 'color_to_hex'(class Color 'c') cil managed
  {
    .maxstack 10
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldstr "#"
    ldarg.s 0
    ldfld int32 Color::'r'
    call string TKVApp::'_byte_to_hex'(int32)
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 0
    ldfld int32 Color::'g'
    call string TKVApp::'_byte_to_hex'(int32)
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 0
    ldfld int32 Color::'b'
    call string TKVApp::'_byte_to_hex'(int32)
    call string [mscorlib]System.String::Concat(string, string)
    ret
  }
  .method public static string 'color_to_rgba_str'(class Color 'c') cil managed
  {
    .maxstack 10
    .locals init (float64 'alpha', int32 '__strtmp2081115995600', int32 '__strtmp2081115995760', int32 '__strtmp2081115995920', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    ldfld int32 Color::'a'
    conv.r8
    ldc.r8 255.0
    div
    stloc.s 0
    ldstr "rgba("
    ldarg.s 0
    ldfld int32 Color::'r'
    call string TkvStr::I32(int32)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr ","
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 0
    ldfld int32 Color::'g'
    call string TkvStr::I32(int32)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr ","
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 0
    ldfld int32 Color::'b'
    call string TkvStr::I32(int32)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr ","
    call string [mscorlib]System.String::Concat(string, string)
    ldloc.s 0
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr ")"
    call string [mscorlib]System.String::Concat(string, string)
    ret
  }
  .method public static class ColorMap 'make_colormap'(string 'name', class [mscorlib]System.Collections.Generic.List`1<class Color> 'stops') cil managed
  {
    .maxstack 9
    .locals init (class ColorMap 'cm', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    newobj instance void ColorMap::.ctor(string)
    stloc.s 0
    ldloc.s 0
    ldarg.s 0
    stfld string ColorMap::'name'
    ldloc.s 0
    ldarg.s 1
    stfld class [mscorlib]System.Collections.Generic.List`1<class Color> ColorMap::'stops'
    ldloc.s 0
    ret
  }
  .method public static float64 '_lerp_f'(float64 'a', float64 'b', float64 't') cil managed
  {
    .maxstack 8
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    ldarg.s 1
    ldarg.s 0
    sub
    ldarg.s 2
    mul
    add
    ret
  }
  .method public static class Color 'colormap_sample'(class ColorMap 'cm', float64 't') cil managed
  {
    .maxstack 12
    .locals init (float64 'clamped_t', class [mscorlib]System.Collections.Generic.List`1<class Color> '__hoist0', int32 'n', class [mscorlib]System.Collections.Generic.List`1<class Color> '__hoist1', float64 'scaled', int32 'idx', class [mscorlib]System.Collections.Generic.List`1<class Color> '__hoist2', float64 'frac', class [mscorlib]System.Collections.Generic.List`1<class Color> '__hoist3', class Color 'c1', class [mscorlib]System.Collections.Generic.List`1<class Color> '__hoist4', class Color 'c2', int32 'r', int32 'g', int32 'b', int32 'a', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 1
    stloc.s 0
    ldloc.s 0
    ldc.r8 0.0
    clt
    brfalse colormap_sample_If1_else
    ldc.r8 0.0
    stloc.s 0
  colormap_sample_If1_else:
    ldloc.s 0
    ldc.r8 1.0
    cgt
    brfalse colormap_sample_If2_else
    ldc.r8 1.0
    stloc.s 0
  colormap_sample_If2_else:
    ldarg.s 0
    ldfld class [mscorlib]System.Collections.Generic.List`1<class Color> ColorMap::'stops'
    stloc.s 1
    ldloc.s 1
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<class Color>::get_Count()
    stloc.s 2
    ldloc.s 2
    ldc.i4 0
    ceq
    brfalse colormap_sample_If3_else
    call class Color TKVApp::'color_black'()
    ret
  colormap_sample_If3_else:
    ldloc.s 2
    ldc.i4 1
    ceq
    brfalse colormap_sample_If4_else
    ldarg.s 0
    ldfld class [mscorlib]System.Collections.Generic.List`1<class Color> ColorMap::'stops'
    stloc.s 3
    ldloc.s 3
    ldc.i4 0
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<class Color>::get_Item(int32)
    ret
  colormap_sample_If4_else:
    ldloc.s 0
    ldloc.s 2
    ldc.i4 1
    sub.ovf
    conv.r8
    mul
    stloc.s 4
    ldloc.s 4
    conv.i4
    stloc.s 5
    ldloc.s 5
    ldloc.s 2
    ldc.i4 1
    sub.ovf
    clt
    ldc.i4.0
    ceq
    brfalse colormap_sample_If5_else
    ldarg.s 0
    ldfld class [mscorlib]System.Collections.Generic.List`1<class Color> ColorMap::'stops'
    stloc.s 6
    ldloc.s 6
    ldloc.s 2
    ldc.i4 1
    sub.ovf
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<class Color>::get_Item(int32)
    ret
  colormap_sample_If5_else:
    ldloc.s 4
    ldloc.s 5
    conv.r8
    sub
    stloc.s 7
    ldarg.s 0
    ldfld class [mscorlib]System.Collections.Generic.List`1<class Color> ColorMap::'stops'
    stloc.s 8
    ldloc.s 8
    ldloc.s 5
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<class Color>::get_Item(int32)
    stloc.s 9
    ldarg.s 0
    ldfld class [mscorlib]System.Collections.Generic.List`1<class Color> ColorMap::'stops'
    stloc.s 10
    ldloc.s 10
    ldloc.s 5
    ldc.i4 1
    add.ovf
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<class Color>::get_Item(int32)
    stloc.s 11
    ldloc.s 9
    ldfld int32 Color::'r'
    conv.r8
    ldloc.s 11
    ldfld int32 Color::'r'
    conv.r8
    ldloc.s 7
    call float64 TKVApp::'_lerp_f'(float64, float64, float64)
    conv.i4
    stloc.s 12
    ldloc.s 9
    ldfld int32 Color::'g'
    conv.r8
    ldloc.s 11
    ldfld int32 Color::'g'
    conv.r8
    ldloc.s 7
    call float64 TKVApp::'_lerp_f'(float64, float64, float64)
    conv.i4
    stloc.s 13
    ldloc.s 9
    ldfld int32 Color::'b'
    conv.r8
    ldloc.s 11
    ldfld int32 Color::'b'
    conv.r8
    ldloc.s 7
    call float64 TKVApp::'_lerp_f'(float64, float64, float64)
    conv.i4
    stloc.s 14
    ldloc.s 9
    ldfld int32 Color::'a'
    conv.r8
    ldloc.s 11
    ldfld int32 Color::'a'
    conv.r8
    ldloc.s 7
    call float64 TKVApp::'_lerp_f'(float64, float64, float64)
    conv.i4
    stloc.s 15
    ldloc.s 12
    ldloc.s 13
    ldloc.s 14
    ldloc.s 15
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    ret
  }
  .method public static class ColorMap 'get_viridis_colormap'() cil managed
  {
    .maxstack 10
    .locals init (class [mscorlib]System.Collections.Generic.List`1<class Color> 'stops', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::.ctor()
    stloc.s 0
    ldloc.s 0
    ldstr "#440154"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    ldloc.s 0
    ldstr "#482878"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    ldloc.s 0
    ldstr "#3E4A89"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    ldloc.s 0
    ldstr "#31688E"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    ldloc.s 0
    ldstr "#26828E"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    ldloc.s 0
    ldstr "#1F9E89"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    ldloc.s 0
    ldstr "#35B779"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    ldloc.s 0
    ldstr "#6DCD59"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    ldloc.s 0
    ldstr "#B4DE2C"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    ldloc.s 0
    ldstr "#FDE725"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    ldstr "Viridis"
    ldloc.s 0
    call class ColorMap TKVApp::'make_colormap'(string, class [mscorlib]System.Collections.Generic.List`1<class Color>)
    ret
  }
  .method public static class StyleTheme 'make_theme_science'() cil managed
  {
    .maxstack 26
    .locals init (class StyleTheme 't', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldstr "Science"
    call class Color TKVApp::'color_white'()
    call class Color TKVApp::'color_white'()
    ldstr "#111111"
    call class Color TKVApp::'color_from_hex'(string)
    ldstr "#E5E5E5"
    call class Color TKVApp::'color_from_hex'(string)
    ldstr "#111111"
    call class Color TKVApp::'color_from_hex'(string)
    ldstr "#000000"
    call class Color TKVApp::'color_from_hex'(string)
    ldc.i4 255
    ldc.i4 255
    ldc.i4 255
    ldc.i4 230
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    ldstr "#BDC3C7"
    call class Color TKVApp::'color_from_hex'(string)
    ldc.r8 1.2
    ldc.r8 0.75
    ldc.i4 1
    ldc.i4 0
    ldc.r8 16.0
    ldc.r8 12.0
    ldc.r8 10.0
    ldc.r8 10.0
    ldstr "Helvetica, Arial, sans-serif"
    newobj instance void StyleTheme::.ctor(string, class Color, class Color, class Color, class Color, class Color, class Color, class Color, class Color, float64, float64, int32, int32, float64, float64, float64, float64, string)
    stloc.s 0
    ldloc.s 0
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::.ctor()
    dup
    ldstr "#0C5DA5"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    dup
    ldstr "#00B945"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    dup
    ldstr "#FF9500"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    dup
    ldstr "#FF2C00"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    stfld class [mscorlib]System.Collections.Generic.List`1<class Color> StyleTheme::'palette'
    ldloc.s 0
    ret
  }
  .method public static class StyleTheme 'make_theme_nature'() cil managed
  {
    .maxstack 26
    .locals init (class StyleTheme 't', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldstr "Nature"
    call class Color TKVApp::'color_white'()
    call class Color TKVApp::'color_white'()
    ldstr "#222222"
    call class Color TKVApp::'color_from_hex'(string)
    ldstr "#ECECEC"
    call class Color TKVApp::'color_from_hex'(string)
    ldstr "#222222"
    call class Color TKVApp::'color_from_hex'(string)
    ldstr "#111111"
    call class Color TKVApp::'color_from_hex'(string)
    ldc.i4 255
    ldc.i4 255
    ldc.i4 255
    ldc.i4 240
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    ldstr "#D0D0D0"
    call class Color TKVApp::'color_from_hex'(string)
    ldc.r8 1.0
    ldc.r8 0.5
    ldc.i4 1
    ldc.i4 0
    ldc.r8 15.0
    ldc.r8 11.5
    ldc.r8 9.5
    ldc.r8 9.5
    ldstr "Arial, Helvetica, sans-serif"
    newobj instance void StyleTheme::.ctor(string, class Color, class Color, class Color, class Color, class Color, class Color, class Color, class Color, float64, float64, int32, int32, float64, float64, float64, float64, string)
    stloc.s 0
    ldloc.s 0
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::.ctor()
    dup
    ldstr "#E64B35"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    dup
    ldstr "#4DBBD5"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    dup
    ldstr "#00A087"
    call class Color TKVApp::'color_from_hex'(string)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
    stfld class [mscorlib]System.Collections.Generic.List`1<class Color> StyleTheme::'palette'
    ldloc.s 0
    ret
  }
  .method public static class CoordinateTransform 'make_coord_transform'(int32 'scale', float64 'data_min', float64 'data_max', float64 'target_min', float64 'target_max') cil managed
  {
    .maxstack 17
    .locals init (float64 'rg', float64 't_rg', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 2
    ldarg.s 1
    sub
    stloc.s 0
    ldloc.s 0
    ldc.r8 0.0
    clt
    brfalse make_coord_transform_If1_else
    ldloc.s 0
    neg
    stloc.s 0
  make_coord_transform_If1_else:
    ldloc.s 0
    ldc.r8 0.000000000001
    clt
    brfalse make_coord_transform_If2_else
    ldc.r8 1.0
    stloc.s 0
  make_coord_transform_If2_else:
    ldarg.s 4
    ldarg.s 3
    sub
    stloc.s 1
    ldarg.s 0
    ldarg.s 1
    ldarg.s 2
    ldarg.s 3
    ldarg.s 4
    ldarg.s 1
    ldarg.s 2
    ldloc.s 0
    ldloc.s 1
    newobj instance void CoordinateTransform::.ctor(int32, float64, float64, float64, float64, float64, float64, float64, float64)
    ret
  }
  .method public static float64 'transform_to_target'(class CoordinateTransform 'ct', float64 'data_val') cil managed
  {
    .maxstack 8
    .locals init (float64 'norm', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 1
    ldarg.s 0
    ldfld float64 CoordinateTransform::'trans_min'
    sub
    ldarg.s 0
    ldfld float64 CoordinateTransform::'trans_range'
    div
    stloc.s 0
    ldarg.s 0
    ldfld float64 CoordinateTransform::'target_min'
    ldloc.s 0
    ldarg.s 0
    ldfld float64 CoordinateTransform::'target_range'
    mul
    add
    ret
  }
  .method public static float64 'transform_to_data'(class CoordinateTransform 'ct', float64 'target_val') cil managed
  {
    .maxstack 8
    .locals init (float64 'norm', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 1
    ldarg.s 0
    ldfld float64 CoordinateTransform::'target_min'
    sub
    ldarg.s 0
    ldfld float64 CoordinateTransform::'target_range'
    div
    stloc.s 0
    ldarg.s 0
    ldfld float64 CoordinateTransform::'trans_min'
    ldloc.s 0
    ldarg.s 0
    ldfld float64 CoordinateTransform::'trans_range'
    mul
    add
    ret
  }
  .method public static class Tick 'make_tick'(float64 'pos', string 'label', int32 'is_major') cil managed
  {
    .maxstack 11
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    ldarg.s 1
    ldarg.s 2
    newobj instance void Tick::.ctor(float64, string, int32)
    ret
  }
  .method public static class [mscorlib]System.Collections.Generic.List`1<class Tick> 'ticks_generate_linear'(float64 'min_val', float64 'max_val', int32 'target_count') cil managed
  {
    .maxstack 11
    .locals init (class [mscorlib]System.Collections.Generic.List`1<class Tick> 'ticks', float64 'diff', float64 'lo', float64 'hi', float64 'tmp', float64 'step', int32 'i', float64 'val', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<class Tick>::.ctor()
    stloc.s 0
    ldarg.s 1
    ldarg.s 0
    sub
    stloc.s 1
    ldloc.s 1
    ldc.r8 0.0
    clt
    brfalse ticks_generate_linear_If1_else
    ldloc.s 1
    neg
    stloc.s 1
  ticks_generate_linear_If1_else:
    ldloc.s 1
    ldc.r8 0.000000000001
    clt
    brfalse ticks_generate_linear_If2_else
    ldloc.s 0
    ldarg.s 0
    ldarg.s 0
    call string TkvStr::F64(float64)
    ldc.i4 1
    call class Tick TKVApp::'make_tick'(float64, string, int32)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Tick>::Add(!0)
    ldloc.s 0
    ret
  ticks_generate_linear_If2_else:
    ldarg.s 0
    stloc.s 2
    ldarg.s 1
    stloc.s 3
    ldloc.s 2
    ldloc.s 3
    cgt
    brfalse ticks_generate_linear_If3_else
    ldloc.s 2
    stloc.s 4
    ldloc.s 3
    stloc.s 2
    ldloc.s 4
    stloc.s 3
  ticks_generate_linear_If3_else:
    ldloc.s 3
    ldloc.s 2
    sub
    ldarg.s 2
    ldc.i4 1
    sub.ovf
    conv.r8
    div
    stloc.s 5
    ldc.i4.0
    stloc.s 6
  ticks_generate_linear_L4_start:
    ldloc.s 6
    ldarg.s 2
    bge ticks_generate_linear_L4_end
    ldloc.s 2
    ldloc.s 6
    conv.r8
    ldloc.s 5
    mul
    add
    stloc.s 7
    ldloc.s 0
    ldloc.s 7
    ldloc.s 7
    call string TkvStr::F64(float64)
    ldc.i4 1
    call class Tick TKVApp::'make_tick'(float64, string, int32)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Tick>::Add(!0)
  ticks_generate_linear_L4_cont:
    ldloc.s 6
    ldc.i4 1
    add
    stloc.s 6
    br ticks_generate_linear_L4_start
  ticks_generate_linear_L4_end:
    ldloc.s 0
    ret
  }
  .method public static class SvgRenderer 'make_svg_renderer'(float64 'width', float64 'height', float64 'dpi') cil managed
  {
    .maxstack 11
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    ldarg.s 1
    ldarg.s 2
    newobj instance void SvgRenderer::.ctor(float64, float64, float64)
    ret
  }
  .method public static int32 'svg_draw_rect'(class SvgRenderer 'svg', float64 'x', float64 'y', float64 'width', float64 'height', class Color 'fill', class Color 'stroke', float64 'stroke_width') cil managed
  {
    .maxstack 10
    .locals init (string 'line', float64 '__strtmp2081116023408', class [mscorlib]System.Collections.Generic.List`1<string> '__hoist5', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldstr "<rect x=\""
    ldarg.s 1
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" y=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 2
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" width=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 3
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" height=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 4
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\""
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
    ldarg.s 5
    ldfld int32 Color::'a'
    ldc.i4 0
    cgt
    brfalse svg_draw_rect_If1_else
    ldloc.s 0
    ldstr " fill=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 5
    call string TKVApp::'color_to_hex'(class Color)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\""
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
    ldarg.s 5
    ldfld int32 Color::'a'
    ldc.i4 255
    clt
    brfalse svg_draw_rect_If2_else
    ldloc.s 0
    ldstr " fill-opacity=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 5
    ldfld int32 Color::'a'
    conv.r8
    ldc.r8 255.0
    div
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\""
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
  svg_draw_rect_If2_else:
    br svg_draw_rect_If1_end
  svg_draw_rect_If1_else:
    ldloc.s 0
    ldstr " fill=\"none\""
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
  svg_draw_rect_If1_end:
    ldarg.s 6
    ldfld int32 Color::'a'
    ldc.i4 0
    cgt
    dup
    brfalse svg_draw_rect_sc4_end
    pop
    ldarg.s 7
    ldc.r8 0.0
    cgt
  svg_draw_rect_sc4_end:
    brfalse svg_draw_rect_If3_else
    ldloc.s 0
    ldstr " stroke=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 6
    call string TKVApp::'color_to_hex'(class Color)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" stroke-width=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 7
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\""
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
    br svg_draw_rect_If3_end
  svg_draw_rect_If3_else:
    ldloc.s 0
    ldstr " stroke=\"none\""
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
  svg_draw_rect_If3_end:
    ldloc.s 0
    ldstr " />"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
    ldarg.s 0
    ldfld class [mscorlib]System.Collections.Generic.List`1<string> SvgRenderer::'body'
    stloc.s 2
    ldloc.s 2
    ldloc.s 0
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<string>::Add(!0)
    ldc.i4 0
    ret
  }
  .method public static int32 'svg_draw_line'(class SvgRenderer 'svg', float64 'x1', float64 'y1', float64 'x2', float64 'y2', class Color 'stroke', float64 'stroke_width') cil managed
  {
    .maxstack 10
    .locals init (string 'line', class [mscorlib]System.Collections.Generic.List`1<string> '__hoist6', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 5
    ldfld int32 Color::'a'
    ldc.i4 0
    ceq
    brfalse svg_draw_line_If1_else
    ldc.i4 0
    ret
  svg_draw_line_If1_else:
    ldstr "<line x1=\""
    ldarg.s 1
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" y1=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 2
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" x2=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 3
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" y2=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 4
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\""
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
    ldloc.s 0
    ldstr " stroke=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 5
    call string TKVApp::'color_to_hex'(class Color)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" stroke-width=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 6
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" />"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
    ldarg.s 0
    ldfld class [mscorlib]System.Collections.Generic.List`1<string> SvgRenderer::'body'
    stloc.s 1
    ldloc.s 1
    ldloc.s 0
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<string>::Add(!0)
    ldc.i4 0
    ret
  }
  .method public static int32 'svg_draw_circle'(class SvgRenderer 'svg', float64 'cx', float64 'cy', float64 'r', class Color 'fill', class Color 'stroke', float64 'stroke_width') cil managed
  {
    .maxstack 10
    .locals init (string 'line', class [mscorlib]System.Collections.Generic.List`1<string> '__hoist7', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldstr "<circle cx=\""
    ldarg.s 1
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" cy=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 2
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" r=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 3
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\""
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
    ldarg.s 4
    ldfld int32 Color::'a'
    ldc.i4 0
    cgt
    brfalse svg_draw_circle_If1_else
    ldloc.s 0
    ldstr " fill=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 4
    call string TKVApp::'color_to_hex'(class Color)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\""
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
    br svg_draw_circle_If1_end
  svg_draw_circle_If1_else:
    ldloc.s 0
    ldstr " fill=\"none\""
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
  svg_draw_circle_If1_end:
    ldarg.s 5
    ldfld int32 Color::'a'
    ldc.i4 0
    cgt
    dup
    brfalse svg_draw_circle_sc3_end
    pop
    ldarg.s 6
    ldc.r8 0.0
    cgt
  svg_draw_circle_sc3_end:
    brfalse svg_draw_circle_If2_else
    ldloc.s 0
    ldstr " stroke=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 5
    call string TKVApp::'color_to_hex'(class Color)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" stroke-width=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 6
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\""
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
    br svg_draw_circle_If2_end
  svg_draw_circle_If2_else:
    ldloc.s 0
    ldstr " stroke=\"none\""
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
  svg_draw_circle_If2_end:
    ldloc.s 0
    ldstr " />"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
    ldarg.s 0
    ldfld class [mscorlib]System.Collections.Generic.List`1<string> SvgRenderer::'body'
    stloc.s 1
    ldloc.s 1
    ldloc.s 0
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<string>::Add(!0)
    ldc.i4 0
    ret
  }
  .method public static int32 'svg_draw_text'(class SvgRenderer 'svg', string 'text', float64 'x', float64 'y', class Color 'color', float64 'font_size') cil managed
  {
    .maxstack 10
    .locals init (string 'line', class [mscorlib]System.Collections.Generic.List`1<string> '__hoist8', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 4
    ldfld int32 Color::'a'
    ldc.i4 0
    ceq
    brfalse svg_draw_text_If1_else
    ldc.i4 0
    ret
  svg_draw_text_If1_else:
    ldstr "<text x=\""
    ldarg.s 2
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" y=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 3
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" font-size=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 5
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "px\" fill=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 4
    call string TKVApp::'color_to_hex'(class Color)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\">"
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 1
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "</text>"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 0
    ldarg.s 0
    ldfld class [mscorlib]System.Collections.Generic.List`1<string> SvgRenderer::'body'
    stloc.s 1
    ldloc.s 1
    ldloc.s 0
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<string>::Add(!0)
    ldc.i4 0
    ret
  }
  .method public static int32 'svg_draw_polyline'(class SvgRenderer 'svg', class [mscorlib]System.Collections.Generic.List`1<float64> 'xs', class [mscorlib]System.Collections.Generic.List`1<float64> 'ys', class Color 'stroke', float64 'stroke_width') cil managed
  {
    .maxstack 10
    .locals init (int32 'n', string 'pts', int32 'i', float64 '__strtmp2081117556704', float64 '__strtmp2081117556864', string 'line', class [mscorlib]System.Collections.Generic.List`1<string> '__hoist9', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 1
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Count()
    stloc.s 0
    ldloc.s 0
    ldc.i4 2
    clt
    dup
    brtrue svg_draw_polyline_sc2_end
    pop
    ldarg.s 3
    ldfld int32 Color::'a'
    ldc.i4 0
    ceq
  svg_draw_polyline_sc2_end:
    brfalse svg_draw_polyline_If1_else
    ldc.i4 0
    ret
  svg_draw_polyline_If1_else:
    ldstr ""
    stloc.s 1
    ldc.i4.0
    stloc.s 2
  svg_draw_polyline_L3_start:
    ldloc.s 2
    ldloc.s 0
    bge svg_draw_polyline_L3_end
    ldloc.s 2
    ldc.i4 0
    cgt
    brfalse svg_draw_polyline_If4_else
    ldloc.s 1
    ldstr " "
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 1
  svg_draw_polyline_If4_else:
    ldloc.s 1
    ldarg.s 1
    ldloc.s 2
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr ","
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 2
    ldloc.s 2
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 1
  svg_draw_polyline_L3_cont:
    ldloc.s 2
    ldc.i4 1
    add
    stloc.s 2
    br svg_draw_polyline_L3_start
  svg_draw_polyline_L3_end:
    ldstr "<polyline points=\""
    ldloc.s 1
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" fill=\"none\" stroke=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 3
    call string TKVApp::'color_to_hex'(class Color)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" stroke-width=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldarg.s 4
    call string TkvStr::F64(float64)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" />"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 5
    ldarg.s 0
    ldfld class [mscorlib]System.Collections.Generic.List`1<string> SvgRenderer::'body'
    stloc.s 6
    ldloc.s 6
    ldloc.s 5
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<string>::Add(!0)
    ldc.i4 0
    ret
  }
  .method public static string 'svg_build'(class SvgRenderer 'svg') cil managed
  {
    .maxstack 10
    .locals init (string 'w_str', float64 '__strtmp2081117563024', string 'h_str', float64 '__strtmp2081117562864', string 'res', class [mscorlib]System.Collections.Generic.List`1<string> '__hoist10', int32 'i', class [mscorlib]System.Collections.Generic.List`1<string> '__hoist11', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    ldfld float64 SvgRenderer::'width'
    call string TkvStr::F64(float64)
    stloc.s 0
    ldarg.s 0
    ldfld float64 SvgRenderer::'height'
    call string TkvStr::F64(float64)
    stloc.s 2
    ldstr "<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"no\"?>\n"
    stloc.s 4
    ldloc.s 4
    ldstr "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 4
    ldloc.s 4
    ldstr "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldloc.s 0
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "px\" height=\""
    call string [mscorlib]System.String::Concat(string, string)
    ldloc.s 2
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "px\" viewBox=\"0 0 "
    call string [mscorlib]System.String::Concat(string, string)
    ldloc.s 0
    call string [mscorlib]System.String::Concat(string, string)
    ldstr " "
    call string [mscorlib]System.String::Concat(string, string)
    ldloc.s 2
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\" version=\"1.1\">\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 4
    ldarg.s 0
    ldfld class [mscorlib]System.Collections.Generic.List`1<string> SvgRenderer::'body'
    stloc.s 5
    ldc.i4.0
    stloc.s 6
  svg_build_L1_start:
    ldloc.s 6
    ldloc.s 5
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<string>::get_Count()
    bge svg_build_L1_end
    ldarg.s 0
    ldfld class [mscorlib]System.Collections.Generic.List`1<string> SvgRenderer::'body'
    stloc.s 7
    ldloc.s 4
    ldstr "  "
    call string [mscorlib]System.String::Concat(string, string)
    ldloc.s 7
    ldloc.s 6
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<string>::get_Item(int32)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 4
  svg_build_L1_cont:
    ldloc.s 6
    ldc.i4 1
    add
    stloc.s 6
    br svg_build_L1_start
  svg_build_L1_end:
    ldloc.s 4
    ldstr "</svg>\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 4
    ldloc.s 4
    ret
  }
  .method public static class PlotElement 'make_line_plot'(class [mscorlib]System.Collections.Generic.List`1<float64> 'xs', class [mscorlib]System.Collections.Generic.List`1<float64> 'ys', string 'label', class Color 'c', float64 'width') cil managed
  {
    .maxstack 20
    .locals init (float64 'xmin', float64 'xmax', float64 'ymin', float64 'ymax', int32 'n', int32 'i', class PlotElement 'elem', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldc.r8 0.0
    stloc.s 0
    ldc.r8 0.0
    stloc.s 1
    ldc.r8 0.0
    stloc.s 2
    ldc.r8 0.0
    stloc.s 3
    ldarg.s 0
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Count()
    stloc.s 4
    ldloc.s 4
    ldc.i4 0
    cgt
    brfalse make_line_plot_If1_else
    ldarg.s 0
    ldc.i4 0
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    stloc.s 0
    ldarg.s 0
    ldc.i4 0
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    stloc.s 1
    ldarg.s 1
    ldc.i4 0
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    stloc.s 2
    ldarg.s 1
    ldc.i4 0
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    stloc.s 3
    ldc.i4.0
    stloc.s 5
  make_line_plot_L2_start:
    ldloc.s 5
    ldloc.s 4
    bge make_line_plot_L2_end
    ldarg.s 0
    ldloc.s 5
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    ldloc.s 0
    clt
    brfalse make_line_plot_If3_else
    ldarg.s 0
    ldloc.s 5
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    stloc.s 0
  make_line_plot_If3_else:
    ldarg.s 0
    ldloc.s 5
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    ldloc.s 1
    cgt
    brfalse make_line_plot_If4_else
    ldarg.s 0
    ldloc.s 5
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    stloc.s 1
  make_line_plot_If4_else:
    ldarg.s 1
    ldloc.s 5
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    ldloc.s 2
    clt
    brfalse make_line_plot_If5_else
    ldarg.s 1
    ldloc.s 5
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    stloc.s 2
  make_line_plot_If5_else:
    ldarg.s 1
    ldloc.s 5
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    ldloc.s 3
    cgt
    brfalse make_line_plot_If6_else
    ldarg.s 1
    ldloc.s 5
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    stloc.s 3
  make_line_plot_If6_else:
  make_line_plot_L2_cont:
    ldloc.s 5
    ldc.i4 1
    add
    stloc.s 5
    br make_line_plot_L2_start
  make_line_plot_L2_end:
  make_line_plot_If1_else:
    ldc.i4 1
    ldarg.s 2
    ldc.i4 1
    ldarg.s 3
    ldarg.s 4
    ldc.i4 0
    ldc.i4 0
    ldloc.s 0
    ldloc.s 1
    ldloc.s 2
    ldloc.s 3
    ldc.r8 1.0
    newobj instance void PlotElement::.ctor(int32, string, int32, class Color, float64, int32, int32, float64, float64, float64, float64, float64)
    stloc.s 6
    ldloc.s 6
    ldarg.s 0
    stfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'xs'
    ldloc.s 6
    ldarg.s 1
    stfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'ys'
    ldloc.s 6
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<float64>::.ctor()
    stfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'grid_data'
    ldloc.s 6
    ret
  }
  .method public static class PlotElement 'make_scatter_plot'(class [mscorlib]System.Collections.Generic.List`1<float64> 'xs', class [mscorlib]System.Collections.Generic.List`1<float64> 'ys', string 'label', class Color 'c', float64 'point_size') cil managed
  {
    .maxstack 13
    .locals init (class PlotElement 'elem', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    ldarg.s 1
    ldarg.s 2
    ldarg.s 3
    ldc.r8 1.0
    call class PlotElement TKVApp::'make_line_plot'(class [mscorlib]System.Collections.Generic.List`1<float64>, class [mscorlib]System.Collections.Generic.List`1<float64>, string, class Color, float64)
    stloc.s 0
    ldloc.s 0
    ldc.i4 2
    stfld int32 PlotElement::'kind'
    ldloc.s 0
    ldarg.s 4
    stfld float64 PlotElement::'point_size'
    ldloc.s 0
    ret
  }
  .method public static class PlotElement 'make_bar_plot'(class [mscorlib]System.Collections.Generic.List`1<float64> 'xs', class [mscorlib]System.Collections.Generic.List`1<float64> 'ys', string 'label', class Color 'c') cil managed
  {
    .maxstack 13
    .locals init (class PlotElement 'elem', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    ldarg.s 1
    ldarg.s 2
    ldarg.s 3
    ldc.r8 1.0
    call class PlotElement TKVApp::'make_line_plot'(class [mscorlib]System.Collections.Generic.List`1<float64>, class [mscorlib]System.Collections.Generic.List`1<float64>, string, class Color, float64)
    stloc.s 0
    ldloc.s 0
    ldc.i4 3
    stfld int32 PlotElement::'kind'
    ldloc.s 0
    ldfld float64 PlotElement::'y_min'
    ldc.r8 0.0
    cgt
    brfalse make_bar_plot_If1_else
    ldloc.s 0
    ldc.r8 0.0
    stfld float64 PlotElement::'y_min'
  make_bar_plot_If1_else:
    ldloc.s 0
    ret
  }
  .method public static class PlotElement 'make_heatmap_plot'(class [mscorlib]System.Collections.Generic.List`1<float64> 'grid', int32 'rows', int32 'cols', string 'label', class Color 'c') cil managed
  {
    .maxstack 20
    .locals init (class PlotElement 'elem', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldc.i4 4
    ldarg.s 3
    ldc.i4 1
    ldarg.s 4
    ldc.r8 1.0
    ldarg.s 1
    ldarg.s 2
    ldc.r8 0.0
    ldarg.s 2
    conv.r8
    ldc.r8 0.0
    ldarg.s 1
    conv.r8
    ldc.r8 1.0
    newobj instance void PlotElement::.ctor(int32, string, int32, class Color, float64, int32, int32, float64, float64, float64, float64, float64)
    stloc.s 0
    ldloc.s 0
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<float64>::.ctor()
    stfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'xs'
    ldloc.s 0
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<float64>::.ctor()
    stfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'ys'
    ldloc.s 0
    ldarg.s 0
    stfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'grid_data'
    ldloc.s 0
    ret
  }
  .method public static class PlotElement 'make_box_plot'(float64 'series_idx', float64 'q0_min', float64 'q1', float64 'med', float64 'q3', float64 'q4_max', string 'label', class Color 'c') cil managed
  {
    .maxstack 20
    .locals init (class [mscorlib]System.Collections.Generic.List`1<float64> 'b_ys', class [mscorlib]System.Collections.Generic.List`1<float64> 'b_xs', class PlotElement 'elem', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<float64>::.ctor()
    stloc.s 0
    ldloc.s 0
    ldarg.s 1
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<float64>::Add(!0)
    ldloc.s 0
    ldarg.s 2
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<float64>::Add(!0)
    ldloc.s 0
    ldarg.s 3
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<float64>::Add(!0)
    ldloc.s 0
    ldarg.s 4
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<float64>::Add(!0)
    ldloc.s 0
    ldarg.s 5
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<float64>::Add(!0)
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<float64>::.ctor()
    stloc.s 1
    ldloc.s 1
    ldarg.s 0
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<float64>::Add(!0)
    ldc.i4 5
    ldarg.s 6
    ldc.i4 1
    ldarg.s 7
    ldc.r8 1.5
    ldc.i4 0
    ldc.i4 0
    ldarg.s 0
    ldc.r8 0.5
    sub
    ldarg.s 0
    ldc.r8 0.5
    add
    ldarg.s 1
    ldarg.s 5
    ldc.r8 1.0
    newobj instance void PlotElement::.ctor(int32, string, int32, class Color, float64, int32, int32, float64, float64, float64, float64, float64)
    stloc.s 2
    ldloc.s 2
    ldloc.s 1
    stfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'xs'
    ldloc.s 2
    ldloc.s 0
    stfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'ys'
    ldloc.s 2
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<float64>::.ctor()
    stfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'grid_data'
    ldloc.s 2
    ret
  }
  .method public static class Axes2D 'make_axes2d'() cil managed
  {
    .maxstack 11
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldstr ""
    ldstr ""
    ldstr ""
    newobj instance void Axes2D::.ctor(string, string, string)
    ret
  }
  .method public static int32 'axes2d_add_element'(class Axes2D 'ax', class PlotElement 'elem') cil managed
  {
    .maxstack 10
    .locals init (class [mscorlib]System.Collections.Generic.List`1<class PlotElement> '__hoist12', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    ldfld class [mscorlib]System.Collections.Generic.List`1<class PlotElement> Axes2D::'elements'
    stloc.s 0
    ldloc.s 0
    ldarg.s 1
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class PlotElement>::Add(!0)
    ldc.i4 0
    ret
  }
  .method public static class Figure 'make_figure'(float64 'width_inches', float64 'height_inches', float64 'dpi') cil managed
  {
    .maxstack 14
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    ldarg.s 1
    ldarg.s 2
    call class StyleTheme TKVApp::'make_theme_science'()
    ldstr ""
    call class Axes2D TKVApp::'make_axes2d'()
    newobj instance void Figure::.ctor(float64, float64, float64, class StyleTheme, string, class Axes2D)
    ret
  }
  .method public static string 'figure_to_svg'(class Figure 'fig') cil managed
  {
    .maxstack 16
    .locals init (float64 'px_w', float64 'px_h', class SvgRenderer 'svg', class StyleTheme 'th', float64 'plot_l', float64 'plot_t', float64 'plot_w', float64 'plot_h', float64 'xmin', float64 'xmax', float64 'ymin', float64 'ymax', class Axes2D 'ax', class [mscorlib]System.Collections.Generic.List`1<class PlotElement> 'elems', valuetype TkvInt 'has_init', int32 'i', class PlotElement 'e', float64 'x_pad', float64 'y_pad', class CoordinateTransform 'tx', class CoordinateTransform 'ty', class [mscorlib]System.Collections.Generic.List`1<class Tick> 'x_ticks', class Tick 'tk', float64 'sx', class [mscorlib]System.Collections.Generic.List`1<class Tick> 'y_ticks', float64 'sy', class ColorMap 'viridis', valuetype TkvInt 'has_legend', class [mscorlib]System.Collections.Generic.List`1<string> 'legend_labels', class [mscorlib]System.Collections.Generic.List`1<class Color> 'legend_colors', class [mscorlib]System.Collections.Generic.List`1<float64> 'pxs', class [mscorlib]System.Collections.Generic.List`1<float64> 'pys', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist13', int32 'k', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist14', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist15', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist16', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist17', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist18', float64 'bar_w', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist19', int32 'num_bars', float64 'zero_y', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist20', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist21', float64 'bx', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist22', float64 'by', float64 'bh', int32 'r_cnt', int32 'c_cnt', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist23', float64 'g_min', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist24', float64 'g_max', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist25', int32 'total_cells', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist26', float64 'v', float64 'g_range', float64 'cell_w', float64 'cell_h', int32 'r', int32 'c', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist27', float64 'cell_val', float64 'norm_t', class Color 'cell_col', float64 'cx', float64 'cy', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist28', float64 'center_x', float64 'box_w', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist29', float64 'sy_min', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist30', float64 'sy_q1', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist31', float64 'sy_med', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist32', float64 'sy_q3', class [mscorlib]System.Collections.Generic.List`1<float64> '__hoist33', float64 'sy_max', float64 'box_top', float64 'box_height', class Color 'ec', class Color 'box_c', float64 'leg_x', float64 'leg_y', float64 'leg_h', float64 'item_y', string '__hoist34', string '__hoist35', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    ldfld float64 Figure::'width_inches'
    ldarg.s 0
    ldfld float64 Figure::'dpi'
    mul
    stloc.s 0
    ldarg.s 0
    ldfld float64 Figure::'height_inches'
    ldarg.s 0
    ldfld float64 Figure::'dpi'
    mul
    stloc.s 1
    ldloc.s 0
    ldloc.s 1
    ldarg.s 0
    ldfld float64 Figure::'dpi'
    call class SvgRenderer TKVApp::'make_svg_renderer'(float64, float64, float64)
    stloc.s 2
    ldarg.s 0
    ldfld class StyleTheme Figure::'theme'
    stloc.s 3
    ldloc.s 2
    ldc.r8 0.0
    ldc.r8 0.0
    ldloc.s 0
    ldloc.s 1
    ldloc.s 3
    ldfld class Color StyleTheme::'bg_color'
    call class Color TKVApp::'color_transparent'()
    ldc.r8 0.0
    call int32 TKVApp::'svg_draw_rect'(class SvgRenderer, float64, float64, float64, float64, class Color, class Color, float64)
    pop
    ldc.r8 75.0
    stloc.s 4
    ldc.r8 60.0
    stloc.s 5
    ldloc.s 0
    ldc.r8 110.0
    sub
    stloc.s 6
    ldloc.s 1
    ldc.r8 130.0
    sub
    stloc.s 7
    ldloc.s 2
    ldloc.s 4
    ldloc.s 5
    ldloc.s 6
    ldloc.s 7
    ldloc.s 3
    ldfld class Color StyleTheme::'plot_area_color'
    ldloc.s 3
    ldfld class Color StyleTheme::'axis_color'
    ldloc.s 3
    ldfld float64 StyleTheme::'axis_line_width'
    call int32 TKVApp::'svg_draw_rect'(class SvgRenderer, float64, float64, float64, float64, class Color, class Color, float64)
    pop
    ldc.r8 0.0
    stloc.s 8
    ldc.r8 1.0
    stloc.s 9
    ldc.r8 0.0
    stloc.s 10
    ldc.r8 1.0
    stloc.s 11
    ldarg.s 0
    ldfld class Axes2D Figure::'axes'
    stloc.s 12
    ldloc.s 12
    ldfld class [mscorlib]System.Collections.Generic.List`1<class PlotElement> Axes2D::'elements'
    stloc.s 13
    ldc.i8 0
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 14
    ldc.i4.0
    stloc.s 15
  figure_to_svg_L1_start:
    ldloc.s 15
    ldloc.s 13
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<class PlotElement>::get_Count()
    bge figure_to_svg_L1_end
    ldloc.s 13
    ldloc.s 15
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<class PlotElement>::get_Item(int32)
    stloc.s 16
    ldloc.s 16
    ldfld int32 PlotElement::'visible'
    ldc.i4 1
    ceq
    brfalse figure_to_svg_If2_else
    ldloc.s 14
    ldc.i8 0
    call valuetype TkvInt TkvInt::FromI64(int64)
    call int32 TkvInt::Cmp(valuetype TkvInt, valuetype TkvInt)
    ldc.i4.0
    ceq
    brfalse figure_to_svg_If3_else
    ldloc.s 16
    ldfld float64 PlotElement::'x_min'
    stloc.s 8
    ldloc.s 16
    ldfld float64 PlotElement::'x_max'
    stloc.s 9
    ldloc.s 16
    ldfld float64 PlotElement::'y_min'
    stloc.s 10
    ldloc.s 16
    ldfld float64 PlotElement::'y_max'
    stloc.s 11
    ldc.i8 1
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 14
    br figure_to_svg_If3_end
  figure_to_svg_If3_else:
    ldloc.s 16
    ldfld float64 PlotElement::'x_min'
    ldloc.s 8
    clt
    brfalse figure_to_svg_If4_else
    ldloc.s 16
    ldfld float64 PlotElement::'x_min'
    stloc.s 8
  figure_to_svg_If4_else:
    ldloc.s 16
    ldfld float64 PlotElement::'x_max'
    ldloc.s 9
    cgt
    brfalse figure_to_svg_If5_else
    ldloc.s 16
    ldfld float64 PlotElement::'x_max'
    stloc.s 9
  figure_to_svg_If5_else:
    ldloc.s 16
    ldfld float64 PlotElement::'y_min'
    ldloc.s 10
    clt
    brfalse figure_to_svg_If6_else
    ldloc.s 16
    ldfld float64 PlotElement::'y_min'
    stloc.s 10
  figure_to_svg_If6_else:
    ldloc.s 16
    ldfld float64 PlotElement::'y_max'
    ldloc.s 11
    cgt
    brfalse figure_to_svg_If7_else
    ldloc.s 16
    ldfld float64 PlotElement::'y_max'
    stloc.s 11
  figure_to_svg_If7_else:
  figure_to_svg_If3_end:
  figure_to_svg_If2_else:
  figure_to_svg_L1_cont:
    ldloc.s 15
    ldc.i4 1
    add
    stloc.s 15
    br figure_to_svg_L1_start
  figure_to_svg_L1_end:
    ldloc.s 8
    ldloc.s 9
    clt
    ldc.i4.0
    ceq
    brfalse figure_to_svg_If8_else
    ldc.r8 0.0
    stloc.s 8
    ldc.r8 1.0
    stloc.s 9
  figure_to_svg_If8_else:
    ldloc.s 10
    ldloc.s 11
    clt
    ldc.i4.0
    ceq
    brfalse figure_to_svg_If9_else
    ldc.r8 0.0
    stloc.s 10
    ldc.r8 1.0
    stloc.s 11
  figure_to_svg_If9_else:
    ldloc.s 9
    ldloc.s 8
    sub
    ldc.r8 0.05
    mul
    stloc.s 17
    ldloc.s 11
    ldloc.s 10
    sub
    ldc.r8 0.05
    mul
    stloc.s 18
    ldloc.s 8
    ldloc.s 17
    sub
    stloc.s 8
    ldloc.s 9
    ldloc.s 17
    add
    stloc.s 9
    ldloc.s 10
    ldloc.s 18
    sub
    stloc.s 10
    ldloc.s 11
    ldloc.s 18
    add
    stloc.s 11
    ldc.i4 0
    ldloc.s 8
    ldloc.s 9
    ldloc.s 4
    ldloc.s 4
    ldloc.s 6
    add
    call class CoordinateTransform TKVApp::'make_coord_transform'(int32, float64, float64, float64, float64)
    stloc.s 19
    ldc.i4 0
    ldloc.s 10
    ldloc.s 11
    ldloc.s 5
    ldloc.s 7
    add
    ldloc.s 5
    call class CoordinateTransform TKVApp::'make_coord_transform'(int32, float64, float64, float64, float64)
    stloc.s 20
    ldloc.s 8
    ldloc.s 9
    ldc.i4 6
    call class [mscorlib]System.Collections.Generic.List`1<class Tick> TKVApp::'ticks_generate_linear'(float64, float64, int32)
    stloc.s 21
    ldc.i4.0
    stloc.s 15
  figure_to_svg_L10_start:
    ldloc.s 15
    ldloc.s 21
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<class Tick>::get_Count()
    bge figure_to_svg_L10_end
    ldloc.s 21
    ldloc.s 15
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<class Tick>::get_Item(int32)
    stloc.s 22
    ldloc.s 19
    ldloc.s 22
    ldfld float64 Tick::'position'
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    stloc.s 23
    ldloc.s 23
    ldloc.s 4
    clt
    ldc.i4.0
    ceq
    dup
    brfalse figure_to_svg_sc12_end
    pop
    ldloc.s 23
    ldloc.s 4
    ldloc.s 6
    add
    cgt
    ldc.i4.0
    ceq
  figure_to_svg_sc12_end:
    brfalse figure_to_svg_If11_else
    ldloc.s 2
    ldloc.s 23
    ldloc.s 5
    ldloc.s 23
    ldloc.s 5
    ldloc.s 7
    add
    ldloc.s 3
    ldfld class Color StyleTheme::'grid_color'
    ldloc.s 3
    ldfld float64 StyleTheme::'grid_line_width'
    call int32 TKVApp::'svg_draw_line'(class SvgRenderer, float64, float64, float64, float64, class Color, float64)
    pop
    ldloc.s 2
    ldloc.s 22
    ldfld string Tick::'label'
    ldloc.s 23
    ldc.r8 10.0
    sub
    ldloc.s 5
    ldloc.s 7
    add
    ldc.r8 18.0
    add
    ldloc.s 3
    ldfld class Color StyleTheme::'text_color'
    ldloc.s 3
    ldfld float64 StyleTheme::'tick_label_font_size'
    call int32 TKVApp::'svg_draw_text'(class SvgRenderer, string, float64, float64, class Color, float64)
    pop
  figure_to_svg_If11_else:
  figure_to_svg_L10_cont:
    ldloc.s 15
    ldc.i4 1
    add
    stloc.s 15
    br figure_to_svg_L10_start
  figure_to_svg_L10_end:
    ldloc.s 10
    ldloc.s 11
    ldc.i4 6
    call class [mscorlib]System.Collections.Generic.List`1<class Tick> TKVApp::'ticks_generate_linear'(float64, float64, int32)
    stloc.s 24
    ldc.i4.0
    stloc.s 15
  figure_to_svg_L13_start:
    ldloc.s 15
    ldloc.s 24
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<class Tick>::get_Count()
    bge figure_to_svg_L13_end
    ldloc.s 24
    ldloc.s 15
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<class Tick>::get_Item(int32)
    stloc.s 22
    ldloc.s 20
    ldloc.s 22
    ldfld float64 Tick::'position'
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    stloc.s 25
    ldloc.s 25
    ldloc.s 5
    clt
    ldc.i4.0
    ceq
    dup
    brfalse figure_to_svg_sc15_end
    pop
    ldloc.s 25
    ldloc.s 5
    ldloc.s 7
    add
    cgt
    ldc.i4.0
    ceq
  figure_to_svg_sc15_end:
    brfalse figure_to_svg_If14_else
    ldloc.s 2
    ldloc.s 4
    ldloc.s 25
    ldloc.s 4
    ldloc.s 6
    add
    ldloc.s 25
    ldloc.s 3
    ldfld class Color StyleTheme::'grid_color'
    ldloc.s 3
    ldfld float64 StyleTheme::'grid_line_width'
    call int32 TKVApp::'svg_draw_line'(class SvgRenderer, float64, float64, float64, float64, class Color, float64)
    pop
    ldloc.s 2
    ldloc.s 22
    ldfld string Tick::'label'
    ldloc.s 4
    ldc.r8 40.0
    sub
    ldloc.s 25
    ldc.r8 4.0
    add
    ldloc.s 3
    ldfld class Color StyleTheme::'text_color'
    ldloc.s 3
    ldfld float64 StyleTheme::'tick_label_font_size'
    call int32 TKVApp::'svg_draw_text'(class SvgRenderer, string, float64, float64, class Color, float64)
    pop
  figure_to_svg_If14_else:
  figure_to_svg_L13_cont:
    ldloc.s 15
    ldc.i4 1
    add
    stloc.s 15
    br figure_to_svg_L13_start
  figure_to_svg_L13_end:
    call class ColorMap TKVApp::'get_viridis_colormap'()
    stloc.s 26
    ldc.i8 0
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 27
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<string>::.ctor()
    stloc.s 28
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::.ctor()
    stloc.s 29
    ldc.i4.0
    stloc.s 15
  figure_to_svg_L16_start:
    ldloc.s 15
    ldloc.s 13
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<class PlotElement>::get_Count()
    bge figure_to_svg_L16_end
    ldloc.s 13
    ldloc.s 15
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<class PlotElement>::get_Item(int32)
    stloc.s 16
    ldloc.s 16
    ldfld int32 PlotElement::'visible'
    ldc.i4 0
    ceq
    brfalse figure_to_svg_If17_else
    br figure_to_svg_L16_cont
  figure_to_svg_If17_else:
    ldloc.s 16
    ldfld string PlotElement::'label'
    callvirt instance int32 [mscorlib]System.String::get_Length()
    ldc.i4 0
    cgt
    brfalse figure_to_svg_If18_else
    ldc.i8 1
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 27
    ldloc.s 28
    ldloc.s 16
    ldfld string PlotElement::'label'
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<string>::Add(!0)
    ldloc.s 29
    ldloc.s 16
    ldfld class Color PlotElement::'color'
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<class Color>::Add(!0)
  figure_to_svg_If18_else:
    ldloc.s 16
    ldfld int32 PlotElement::'kind'
    ldc.i4 1
    ceq
    brfalse figure_to_svg_If19_else
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<float64>::.ctor()
    stloc.s 30
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<float64>::.ctor()
    stloc.s 31
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'xs'
    stloc.s 32
    ldc.i4.0
    stloc.s 33
  figure_to_svg_L20_start:
    ldloc.s 33
    ldloc.s 32
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Count()
    bge figure_to_svg_L20_end
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'xs'
    stloc.s 34
    ldloc.s 30
    ldloc.s 19
    ldloc.s 34
    ldloc.s 33
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<float64>::Add(!0)
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'ys'
    stloc.s 35
    ldloc.s 31
    ldloc.s 20
    ldloc.s 35
    ldloc.s 33
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    callvirt instance void class [mscorlib]System.Collections.Generic.List`1<float64>::Add(!0)
  figure_to_svg_L20_cont:
    ldloc.s 33
    ldc.i4 1
    add
    stloc.s 33
    br figure_to_svg_L20_start
  figure_to_svg_L20_end:
    ldloc.s 2
    ldloc.s 30
    ldloc.s 31
    ldloc.s 16
    ldfld class Color PlotElement::'color'
    ldloc.s 16
    ldfld float64 PlotElement::'line_width'
    call int32 TKVApp::'svg_draw_polyline'(class SvgRenderer, class [mscorlib]System.Collections.Generic.List`1<float64>, class [mscorlib]System.Collections.Generic.List`1<float64>, class Color, float64)
    pop
    br figure_to_svg_If19_end
  figure_to_svg_If19_else:
    ldloc.s 16
    ldfld int32 PlotElement::'kind'
    ldc.i4 2
    ceq
    brfalse figure_to_svg_If21_else
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'xs'
    stloc.s 36
    ldc.i4.0
    stloc.s 33
  figure_to_svg_L22_start:
    ldloc.s 33
    ldloc.s 36
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Count()
    bge figure_to_svg_L22_end
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'xs'
    stloc.s 37
    ldloc.s 19
    ldloc.s 37
    ldloc.s 33
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    stloc.s 23
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'ys'
    stloc.s 38
    ldloc.s 20
    ldloc.s 38
    ldloc.s 33
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    stloc.s 25
    ldloc.s 2
    ldloc.s 23
    ldloc.s 25
    ldloc.s 16
    ldfld float64 PlotElement::'point_size'
    ldloc.s 16
    ldfld class Color PlotElement::'color'
    call class Color TKVApp::'color_transparent'()
    ldc.r8 0.0
    call int32 TKVApp::'svg_draw_circle'(class SvgRenderer, float64, float64, float64, class Color, class Color, float64)
    pop
  figure_to_svg_L22_cont:
    ldloc.s 33
    ldc.i4 1
    add
    stloc.s 33
    br figure_to_svg_L22_start
  figure_to_svg_L22_end:
    br figure_to_svg_If21_end
  figure_to_svg_If21_else:
    ldloc.s 16
    ldfld int32 PlotElement::'kind'
    ldc.i4 3
    ceq
    brfalse figure_to_svg_If23_else
    ldc.r8 20.0
    stloc.s 39
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'xs'
    stloc.s 40
    ldloc.s 40
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Count()
    stloc.s 41
    ldloc.s 41
    ldc.i4 0
    cgt
    brfalse figure_to_svg_If24_else
    ldloc.s 6
    ldloc.s 41
    conv.r8
    div
    ldc.r8 0.7
    mul
    stloc.s 39
  figure_to_svg_If24_else:
    ldloc.s 20
    ldc.r8 0.0
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    stloc.s 42
    ldloc.s 42
    ldloc.s 5
    ldloc.s 7
    add
    cgt
    brfalse figure_to_svg_If25_else
    ldloc.s 5
    ldloc.s 7
    add
    stloc.s 42
  figure_to_svg_If25_else:
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'xs'
    stloc.s 43
    ldc.i4.0
    stloc.s 33
  figure_to_svg_L26_start:
    ldloc.s 33
    ldloc.s 43
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Count()
    bge figure_to_svg_L26_end
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'xs'
    stloc.s 44
    ldloc.s 19
    ldloc.s 44
    ldloc.s 33
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    ldloc.s 39
    ldc.r8 0.5
    mul
    sub
    stloc.s 45
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'ys'
    stloc.s 46
    ldloc.s 20
    ldloc.s 46
    ldloc.s 33
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    stloc.s 47
    ldloc.s 42
    ldloc.s 47
    sub
    stloc.s 48
    ldloc.s 48
    ldc.r8 0.0
    clt
    brfalse figure_to_svg_If27_else
    ldloc.s 48
    neg
    stloc.s 48
    ldloc.s 42
    stloc.s 47
  figure_to_svg_If27_else:
    ldloc.s 2
    ldloc.s 45
    ldloc.s 47
    ldloc.s 39
    ldloc.s 48
    ldloc.s 16
    ldfld class Color PlotElement::'color'
    ldloc.s 3
    ldfld class Color StyleTheme::'axis_color'
    ldc.r8 1.0
    call int32 TKVApp::'svg_draw_rect'(class SvgRenderer, float64, float64, float64, float64, class Color, class Color, float64)
    pop
  figure_to_svg_L26_cont:
    ldloc.s 33
    ldc.i4 1
    add
    stloc.s 33
    br figure_to_svg_L26_start
  figure_to_svg_L26_end:
    br figure_to_svg_If23_end
  figure_to_svg_If23_else:
    ldloc.s 16
    ldfld int32 PlotElement::'kind'
    ldc.i4 4
    ceq
    brfalse figure_to_svg_If28_else
    ldloc.s 16
    ldfld int32 PlotElement::'grid_rows'
    stloc.s 49
    ldloc.s 16
    ldfld int32 PlotElement::'grid_cols'
    stloc.s 50
    ldloc.s 49
    ldc.i4 0
    cgt
    dup
    brfalse figure_to_svg_sc30_end
    pop
    ldloc.s 50
    ldc.i4 0
    cgt
  figure_to_svg_sc30_end:
    brfalse figure_to_svg_If29_else
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'grid_data'
    stloc.s 51
    ldloc.s 51
    ldc.i4 0
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    stloc.s 52
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'grid_data'
    stloc.s 53
    ldloc.s 53
    ldc.i4 0
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    stloc.s 54
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'grid_data'
    stloc.s 55
    ldloc.s 55
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Count()
    stloc.s 56
    ldc.i4.0
    stloc.s 33
  figure_to_svg_L31_start:
    ldloc.s 33
    ldloc.s 56
    bge figure_to_svg_L31_end
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'grid_data'
    stloc.s 57
    ldloc.s 57
    ldloc.s 33
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    stloc.s 58
    ldloc.s 58
    ldloc.s 52
    clt
    brfalse figure_to_svg_If32_else
    ldloc.s 58
    stloc.s 52
  figure_to_svg_If32_else:
    ldloc.s 58
    ldloc.s 54
    cgt
    brfalse figure_to_svg_If33_else
    ldloc.s 58
    stloc.s 54
  figure_to_svg_If33_else:
  figure_to_svg_L31_cont:
    ldloc.s 33
    ldc.i4 1
    add
    stloc.s 33
    br figure_to_svg_L31_start
  figure_to_svg_L31_end:
    ldloc.s 54
    ldloc.s 52
    sub
    stloc.s 59
    ldloc.s 59
    ldc.r8 0.000000001
    clt
    brfalse figure_to_svg_If34_else
    ldc.r8 1.0
    stloc.s 59
  figure_to_svg_If34_else:
    ldloc.s 6
    ldloc.s 50
    conv.r8
    div
    stloc.s 60
    ldloc.s 7
    ldloc.s 49
    conv.r8
    div
    stloc.s 61
    ldc.i4.0
    stloc.s 62
  figure_to_svg_L35_start:
    ldloc.s 62
    ldloc.s 49
    bge figure_to_svg_L35_end
    ldc.i4.0
    stloc.s 63
  figure_to_svg_L36_start:
    ldloc.s 63
    ldloc.s 50
    bge figure_to_svg_L36_end
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'grid_data'
    stloc.s 64
    ldloc.s 64
    ldloc.s 62
    ldloc.s 50
    mul.ovf
    ldloc.s 63
    add.ovf
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    stloc.s 65
    ldloc.s 65
    ldloc.s 52
    sub
    ldloc.s 59
    div
    stloc.s 66
    ldloc.s 26
    ldloc.s 66
    call class Color TKVApp::'colormap_sample'(class ColorMap, float64)
    stloc.s 67
    ldloc.s 4
    ldloc.s 63
    conv.r8
    ldloc.s 60
    mul
    add
    stloc.s 68
    ldloc.s 5
    ldloc.s 62
    conv.r8
    ldloc.s 61
    mul
    add
    stloc.s 69
    ldloc.s 2
    ldloc.s 68
    ldloc.s 69
    ldloc.s 60
    ldc.r8 0.5
    add
    ldloc.s 61
    ldc.r8 0.5
    add
    ldloc.s 67
    call class Color TKVApp::'color_transparent'()
    ldc.r8 0.0
    call int32 TKVApp::'svg_draw_rect'(class SvgRenderer, float64, float64, float64, float64, class Color, class Color, float64)
    pop
  figure_to_svg_L36_cont:
    ldloc.s 63
    ldc.i4 1
    add
    stloc.s 63
    br figure_to_svg_L36_start
  figure_to_svg_L36_end:
  figure_to_svg_L35_cont:
    ldloc.s 62
    ldc.i4 1
    add
    stloc.s 62
    br figure_to_svg_L35_start
  figure_to_svg_L35_end:
  figure_to_svg_If29_else:
    br figure_to_svg_If28_end
  figure_to_svg_If28_else:
    ldloc.s 16
    ldfld int32 PlotElement::'kind'
    ldc.i4 5
    ceq
    brfalse figure_to_svg_If37_else
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'ys'
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Count()
    ldc.i4 5
    clt
    ldc.i4.0
    ceq
    dup
    brfalse figure_to_svg_sc39_end
    pop
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'xs'
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Count()
    ldc.i4 1
    clt
    ldc.i4.0
    ceq
  figure_to_svg_sc39_end:
    brfalse figure_to_svg_If38_else
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'xs'
    stloc.s 70
    ldloc.s 19
    ldloc.s 70
    ldc.i4 0
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    stloc.s 71
    ldc.r8 30.0
    stloc.s 72
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'ys'
    stloc.s 73
    ldloc.s 20
    ldloc.s 73
    ldc.i4 0
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    stloc.s 74
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'ys'
    stloc.s 75
    ldloc.s 20
    ldloc.s 75
    ldc.i4 1
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    stloc.s 76
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'ys'
    stloc.s 77
    ldloc.s 20
    ldloc.s 77
    ldc.i4 2
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    stloc.s 78
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'ys'
    stloc.s 79
    ldloc.s 20
    ldloc.s 79
    ldc.i4 3
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    stloc.s 80
    ldloc.s 16
    ldfld class [mscorlib]System.Collections.Generic.List`1<float64> PlotElement::'ys'
    stloc.s 81
    ldloc.s 20
    ldloc.s 81
    ldc.i4 4
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<float64>::get_Item(int32)
    call float64 TKVApp::'transform_to_target'(class CoordinateTransform, float64)
    stloc.s 82
    ldloc.s 2
    ldloc.s 71
    ldloc.s 74
    ldloc.s 71
    ldloc.s 76
    ldloc.s 16
    ldfld class Color PlotElement::'color'
    ldc.r8 1.5
    call int32 TKVApp::'svg_draw_line'(class SvgRenderer, float64, float64, float64, float64, class Color, float64)
    pop
    ldloc.s 2
    ldloc.s 71
    ldloc.s 80
    ldloc.s 71
    ldloc.s 82
    ldloc.s 16
    ldfld class Color PlotElement::'color'
    ldc.r8 1.5
    call int32 TKVApp::'svg_draw_line'(class SvgRenderer, float64, float64, float64, float64, class Color, float64)
    pop
    ldloc.s 2
    ldloc.s 71
    ldloc.s 72
    ldc.r8 0.3
    mul
    sub
    ldloc.s 74
    ldloc.s 71
    ldloc.s 72
    ldc.r8 0.3
    mul
    add
    ldloc.s 74
    ldloc.s 16
    ldfld class Color PlotElement::'color'
    ldc.r8 1.5
    call int32 TKVApp::'svg_draw_line'(class SvgRenderer, float64, float64, float64, float64, class Color, float64)
    pop
    ldloc.s 2
    ldloc.s 71
    ldloc.s 72
    ldc.r8 0.3
    mul
    sub
    ldloc.s 82
    ldloc.s 71
    ldloc.s 72
    ldc.r8 0.3
    mul
    add
    ldloc.s 82
    ldloc.s 16
    ldfld class Color PlotElement::'color'
    ldc.r8 1.5
    call int32 TKVApp::'svg_draw_line'(class SvgRenderer, float64, float64, float64, float64, class Color, float64)
    pop
    ldloc.s 80
    stloc.s 83
    ldloc.s 76
    ldloc.s 80
    sub
    stloc.s 84
    ldloc.s 16
    ldfld class Color PlotElement::'color'
    stloc.s 85
    ldloc.s 85
    ldfld int32 Color::'r'
    ldloc.s 85
    ldfld int32 Color::'g'
    ldloc.s 85
    ldfld int32 Color::'b'
    ldc.i4 120
    call class Color TKVApp::'make_color'(int32, int32, int32, int32)
    stloc.s 86
    ldloc.s 2
    ldloc.s 71
    ldloc.s 72
    ldc.r8 0.5
    mul
    sub
    ldloc.s 83
    ldloc.s 72
    ldloc.s 84
    ldloc.s 86
    ldloc.s 85
    ldc.r8 1.5
    call int32 TKVApp::'svg_draw_rect'(class SvgRenderer, float64, float64, float64, float64, class Color, class Color, float64)
    pop
    ldloc.s 2
    ldloc.s 71
    ldloc.s 72
    ldc.r8 0.5
    mul
    sub
    ldloc.s 78
    ldloc.s 71
    ldloc.s 72
    ldc.r8 0.5
    mul
    add
    ldloc.s 78
    call class Color TKVApp::'color_black'()
    ldc.r8 2.0
    call int32 TKVApp::'svg_draw_line'(class SvgRenderer, float64, float64, float64, float64, class Color, float64)
    pop
  figure_to_svg_If38_else:
  figure_to_svg_If37_else:
  figure_to_svg_If28_end:
  figure_to_svg_If23_end:
  figure_to_svg_If21_end:
  figure_to_svg_If19_end:
  figure_to_svg_L16_cont:
    ldloc.s 15
    ldc.i4 1
    add
    stloc.s 15
    br figure_to_svg_L16_start
  figure_to_svg_L16_end:
    ldloc.s 27
    ldc.i8 1
    call valuetype TkvInt TkvInt::FromI64(int64)
    call int32 TkvInt::Cmp(valuetype TkvInt, valuetype TkvInt)
    ldc.i4.0
    ceq
    brfalse figure_to_svg_If40_else
    ldloc.s 4
    ldloc.s 6
    add
    ldc.r8 140.0
    sub
    stloc.s 87
    ldloc.s 5
    ldc.r8 15.0
    add
    stloc.s 88
    ldloc.s 28
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<string>::get_Count()
    conv.r8
    ldc.r8 22.0
    mul
    ldc.r8 15.0
    add
    stloc.s 89
    ldloc.s 2
    ldloc.s 87
    ldloc.s 88
    ldc.r8 130.0
    ldloc.s 89
    ldloc.s 3
    ldfld class Color StyleTheme::'legend_bg'
    ldloc.s 3
    ldfld class Color StyleTheme::'legend_border'
    ldc.r8 1.0
    call int32 TKVApp::'svg_draw_rect'(class SvgRenderer, float64, float64, float64, float64, class Color, class Color, float64)
    pop
    ldc.i4.0
    stloc.s 15
  figure_to_svg_L41_start:
    ldloc.s 15
    ldloc.s 28
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<string>::get_Count()
    bge figure_to_svg_L41_end
    ldloc.s 88
    ldloc.s 15
    conv.r8
    ldc.r8 22.0
    mul
    add
    ldc.r8 16.0
    add
    stloc.s 90
    ldloc.s 2
    ldloc.s 87
    ldc.r8 10.0
    add
    ldloc.s 90
    ldloc.s 87
    ldc.r8 30.0
    add
    ldloc.s 90
    ldloc.s 29
    ldloc.s 15
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<class Color>::get_Item(int32)
    ldc.r8 2.5
    call int32 TKVApp::'svg_draw_line'(class SvgRenderer, float64, float64, float64, float64, class Color, float64)
    pop
    ldloc.s 2
    ldloc.s 87
    ldc.r8 20.0
    add
    ldloc.s 90
    ldc.r8 3.5
    ldloc.s 29
    ldloc.s 15
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<class Color>::get_Item(int32)
    call class Color TKVApp::'color_transparent'()
    ldc.r8 0.0
    call int32 TKVApp::'svg_draw_circle'(class SvgRenderer, float64, float64, float64, class Color, class Color, float64)
    pop
    ldloc.s 2
    ldloc.s 28
    ldloc.s 15
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<string>::get_Item(int32)
    ldloc.s 87
    ldc.r8 38.0
    add
    ldloc.s 90
    ldc.r8 4.0
    add
    ldloc.s 3
    ldfld class Color StyleTheme::'text_color'
    ldloc.s 3
    ldfld float64 StyleTheme::'legend_font_size'
    call int32 TKVApp::'svg_draw_text'(class SvgRenderer, string, float64, float64, class Color, float64)
    pop
  figure_to_svg_L41_cont:
    ldloc.s 15
    ldc.i4 1
    add
    stloc.s 15
    br figure_to_svg_L41_start
  figure_to_svg_L41_end:
  figure_to_svg_If40_else:
    ldloc.s 12
    ldfld string Axes2D::'title'
    callvirt instance int32 [mscorlib]System.String::get_Length()
    ldc.i4 0
    cgt
    brfalse figure_to_svg_If42_else
    ldloc.s 12
    ldfld string Axes2D::'title'
    stloc.s 91
    ldloc.s 2
    ldloc.s 12
    ldfld string Axes2D::'title'
    ldloc.s 4
    ldloc.s 6
    ldc.r8 0.5
    mul
    add
    ldloc.s 91
    callvirt instance int32 [mscorlib]System.String::get_Length()
    conv.r8
    ldc.r8 4.0
    mul
    sub
    ldloc.s 5
    ldc.r8 20.0
    sub
    ldloc.s 3
    ldfld class Color StyleTheme::'title_color'
    ldloc.s 3
    ldfld float64 StyleTheme::'title_font_size'
    call int32 TKVApp::'svg_draw_text'(class SvgRenderer, string, float64, float64, class Color, float64)
    pop
  figure_to_svg_If42_else:
    ldloc.s 12
    ldfld string Axes2D::'xlabel'
    callvirt instance int32 [mscorlib]System.String::get_Length()
    ldc.i4 0
    cgt
    brfalse figure_to_svg_If43_else
    ldloc.s 12
    ldfld string Axes2D::'xlabel'
    stloc.s 92
    ldloc.s 2
    ldloc.s 12
    ldfld string Axes2D::'xlabel'
    ldloc.s 4
    ldloc.s 6
    ldc.r8 0.5
    mul
    add
    ldloc.s 92
    callvirt instance int32 [mscorlib]System.String::get_Length()
    conv.r8
    ldc.r8 3.5
    mul
    sub
    ldloc.s 5
    ldloc.s 7
    add
    ldc.r8 45.0
    add
    ldloc.s 3
    ldfld class Color StyleTheme::'text_color'
    ldloc.s 3
    ldfld float64 StyleTheme::'axis_label_font_size'
    call int32 TKVApp::'svg_draw_text'(class SvgRenderer, string, float64, float64, class Color, float64)
    pop
  figure_to_svg_If43_else:
    ldloc.s 12
    ldfld string Axes2D::'ylabel'
    callvirt instance int32 [mscorlib]System.String::get_Length()
    ldc.i4 0
    cgt
    brfalse figure_to_svg_If44_else
    ldloc.s 2
    ldloc.s 12
    ldfld string Axes2D::'ylabel'
    ldloc.s 4
    ldc.r8 55.0
    sub
    ldloc.s 5
    ldc.r8 15.0
    sub
    ldloc.s 3
    ldfld class Color StyleTheme::'text_color'
    ldloc.s 3
    ldfld float64 StyleTheme::'axis_label_font_size'
    call int32 TKVApp::'svg_draw_text'(class SvgRenderer, string, float64, float64, class Color, float64)
    pop
  figure_to_svg_If44_else:
    ldloc.s 2
    call string TKVApp::'svg_build'(class SvgRenderer)
    ret
  }
  .method public static string 'figure_to_interactive_html'(class Figure 'fig') cil managed
  {
    .maxstack 10
    .locals init (string 'svg_str', class StyleTheme 'th', string 'html', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldarg.s 0
    call string TKVApp::'figure_to_svg'(class Figure)
    stloc.s 0
    ldarg.s 0
    ldfld class StyleTheme Figure::'theme'
    stloc.s 1
    ldstr "<!DOCTYPE html>\n<html>\n<head>\n"
    stloc.s 2
    ldloc.s 2
    ldstr "  <meta charset=\"utf-8\" />\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "  <title>TokenVector.Plot Interactive View</title>\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "  <style>\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "    body { margin: 0; padding: 20px; background: "
    call string [mscorlib]System.String::Concat(string, string)
    ldloc.s 1
    ldfld class Color StyleTheme::'bg_color'
    call string TKVApp::'color_to_hex'(class Color)
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "; font-family: "
    call string [mscorlib]System.String::Concat(string, string)
    ldloc.s 1
    ldfld string StyleTheme::'font_family'
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "; display: flex; flex-direction: column; align-items: center; justify-content: center; }\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "    .chart-card { background: white; padding: 16px; border-radius: 8px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "    .controls { margin-top: 10px; display: flex; gap: 8px; }\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "    button { padding: 6px 12px; border-radius: 4px; border: 1px solid #ccc; background: #fafafa; cursor: pointer; }\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "    button:hover { background: #eee; }\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "  </style>\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "</head>\n<body>\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "  <div class=\"chart-card\">\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "    <div id=\"svg-container\">\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "      "
    call string [mscorlib]System.String::Concat(string, string)
    ldloc.s 0
    call string [mscorlib]System.String::Concat(string, string)
    ldstr "\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "    </div>\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "    <div class=\"controls\">\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "      <button onclick=\"window.print()\">Print / Save PDF</button>\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "    </div>\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "  </div>\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ldstr "</body>\n</html>\n"
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 2
    ldloc.s 2
    ret
  }
  .method public static string 'run'() cil managed
  {
    .maxstack 8
    .locals init (valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldstr "LIBOK_PLOT"
    ret
  }

}
