import 'package:login_demo/config.dart';

enum ThemeType {
  light,
  dark,
}

class AppTheme {
  static ThemeType defaultTheme = ThemeType.light;

  //Theme Colors
  bool isDark;
  Color primary;
  Color primaryDark;
  Color primaryLight;
  Color black;
  Color darkGray;
  Color lightGray;
  Color border;
  Color white;
  Color success;
  Color error;
  Color like;

  /// Default constructor
  AppTheme({
    required this.isDark,
    required this.primary,
    required this.primaryDark,
    required this.primaryLight,
    required this.black,
    required this.darkGray,
    required this.lightGray,
    required this.border,
    required this.white,
    required this.success,
    required this.error,
    required this.like,
  });

  /// fromType factory constructor
  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.light:
        return AppTheme(
          isDark: false,
          primary: const Color(0xFF42003f),
          primaryDark: const Color(0xFF42003f),
          primaryLight: const Color(0xFFFFFFFF),
          black: const Color(0xFF001928),
          darkGray: const Color(0xFF777777),
          lightGray: const Color(0xFFf7f7f7),
          border: const Color(0xFFE6E8EA),
          white: const Color(0xFFFFFFFF),
          success: const Color(0xFF27AE60),
          error: const Color(0xFFD32F2F),
          like: const Color(0xFFD32F2F),
        );

      case ThemeType.dark:
        return AppTheme(
          isDark: true,
          primary: const Color(0xFF42003f),
          primaryDark: const Color(0xFF42003f),
          primaryLight: const Color(0xFF2B3D49),
          black: const Color(0xFFEDEDED),
          darkGray: const Color(0xFF999999),
          lightGray: const Color(0xFF212528),
          border: const Color(0xFF3A3A3A),
          white: const Color(0xFF1A1E21),
          success: const Color(0xFF1F8B4D),
          error: const Color(0xFFA92626),
          like: const Color(0xFFA92626),
        );
    }
  }

  ThemeData get themeData {
    var t = ThemeData.from(
      textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: primary,
        secondary: primary,
        background: white,
        surface: white,
        onBackground: black,
        onSurface: black,
        onError: black,
        onPrimary: black,
        onSecondary: black,
        error: error,
      ),
    );

    return t.copyWith(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      checkboxTheme: CheckboxThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Insets.i5))),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: appCtrl.appTheme.black),
        displayMedium: TextStyle(color: appCtrl.appTheme.black),
        displaySmall: TextStyle(color: appCtrl.appTheme.black),
        headlineMedium: TextStyle(color: appCtrl.appTheme.black),
        headlineSmall: TextStyle(color: appCtrl.appTheme.black),
        bodyLarge: TextStyle(color: appCtrl.appTheme.black),
        titleLarge: TextStyle(color: appCtrl.appTheme.black),
        bodyMedium: TextStyle(color: appCtrl.appTheme.black),
        titleMedium: TextStyle(color: appCtrl.appTheme.black),
        titleSmall: TextStyle(color: appCtrl.appTheme.black),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: border,
        selectionHandleColor: Colors.transparent,
        cursorColor: primary,
      ),
      appBarTheme: AppBarTheme(backgroundColor: white, elevation: 0, titleTextStyle: AppCss.h1.textColor(black)),
      scaffoldBackgroundColor: white,
      highlightColor: Colors.transparent,
      // toggleableActiveColor: primary,
    );
  }

  // Color shift(Color c, double d) => shiftHsl(c, d * (isDark ? -1 : 1));
}