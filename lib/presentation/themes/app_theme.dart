import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

AppThemes appThemes = AppThemes();

class AppThemes with ChangeNotifier {
  static const background = Color(0xff0C131F);
  static const primary = Color(0xff03b2cb);
  static const darkText = Color(0xff0C131F);
  static const lightText = Colors.white;
  static final _darkOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.r),
    borderSide: const BorderSide(
      color: Colors.grey,
    ),
  );

  /// SETTING DART THEME
  static ThemeData get darkTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: primary),
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        errorStyle: const TextStyle(color: Colors.white),
        hintStyle: GoogleFonts.nunitoSans(
          fontSize: 14.sp,
          color: darkText.withOpacity(0.5),
        ),
        prefixIconColor: primary,
        enabledBorder: _darkOutlineInputBorder,
        disabledBorder: _darkOutlineInputBorder,
        focusedBorder: _darkOutlineInputBorder,
        errorBorder: _darkOutlineInputBorder,
        focusedErrorBorder: _darkOutlineInputBorder,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              fontSize: 14.sp,
              color: darkText,
            ),
            bodyText2: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
            headline1: TextStyle(
              fontSize: 24.sp,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
    );
  }

  /// SETTING LIGHT THEME
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: Colors.white,
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              fontSize: 20.sp,
              color: const Color(0xff070D39),
            ),
            bodyText2: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
            headline2: TextStyle(
              fontSize: 30.sp,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: GoogleFonts.nunitoSans(
          fontSize: 18.sp,
          color: Colors.white,
        ),
        prefixIconColor: primary,
        enabledBorder: _darkOutlineInputBorder,
        disabledBorder: _darkOutlineInputBorder,
        focusedBorder: _darkOutlineInputBorder,
        errorBorder: _darkOutlineInputBorder,
        focusedErrorBorder: _darkOutlineInputBorder,
      ),
    );
  }

  static bool _isDarkTheme = true;
  ThemeMode get themeMode => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
