import '../../config.dart';

part 'scale.dart';

class AppCss {
  static TextStyle plusJakartaSans = const TextStyle(
    fontFamily: Fonts.plusJakartaSans,
    fontWeight: FontWeight.w400,
    fontFamilyFallback: [Fonts.plusJakartaSans],
  );

  static TextStyle get h1 => plusJakartaSans.bold.size(FontSizes.s20).textHeight(LineHeight.lh26(FontSizes.s20));
  static TextStyle get h2 => plusJakartaSans.bold.size(FontSizes.s18).textHeight(LineHeight.lh22(FontSizes.s18));
  static TextStyle get h3 => plusJakartaSans.bold.size(FontSizes.s16).textHeight(LineHeight.lh20(FontSizes.s16));
  static TextStyle get h4 => plusJakartaSans.semiBold.size(FontSizes.s14).textHeight(LineHeight.lh18(FontSizes.s14));

  static TextStyle get paragraph => plusJakartaSans.size(FontSizes.s16).textHeight(LineHeight.lh20(FontSizes.s16));
  static TextStyle get paragraphMedium => plusJakartaSans.medium.size(FontSizes.s16).textHeight(LineHeight.lh20(FontSizes.s16));
  static TextStyle get paragraphSemiBold => plusJakartaSans.semiBold.size(FontSizes.s16).textHeight(LineHeight.lh20(FontSizes.s16));

  static TextStyle get paragraphTall => plusJakartaSans.size(FontSizes.s16).textHeight(LineHeight.lh24(FontSizes.s16));
  static TextStyle get paragraphSmall => plusJakartaSans.size(FontSizes.s14).textHeight(LineHeight.lh18(FontSizes.s14));
  static TextStyle get paragraphSmallTall => plusJakartaSans.size(FontSizes.s14).textHeight(LineHeight.lh22(FontSizes.s14));

  static TextStyle get caption => plusJakartaSans.size(FontSizes.s12).textHeight(LineHeight.lh14(FontSizes.s12));
  static TextStyle get captionSemiBold => plusJakartaSans.semiBold.size(FontSizes.s12).textHeight(LineHeight.lh14(FontSizes.s12));
}