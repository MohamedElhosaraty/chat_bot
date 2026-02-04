import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color primaryColor = Color(0xFF3369FF);
  static const Color grey = Color(0xFF757575);
  static const Color lightBlack = Color(0xFF292D32);
  static const Color lightGreen = Color(0xFF3ABF38);
  static const Color lightGrey = Color(0xFFECECEC);
  static const Color moreGrey = Color(0xFFA1A1A1);
  static const Color lighterGrey = Color(0xFFEEEEEE);
  static const Color darkGrey = Color(0xFF656565);
  static const Color lighterBlack = Color(0xFF3F3F3F);
  static const Color lightGrey2 = Color(0xFFF4F4F4);
  static const Color lightBlack2 = Color(0xFF3E3E3E);








  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFF2F2F2);
  static const Color coffee = Color(0xFFC1A77C);
  static const Color darkBlue = Color(0xFF0E1025);
  static const Color grey2 = Color(0xFF757575);
  static const Color coffee2 = Color(0xFFE1C6A0);
  static const Color moreWhite = Color(0xFFF9F9F9);
  static const Color neutral = Color(0xFFF5F5F5);
  static const Color grey400 = Color(0xFF979797);
  static const Color grey500 = Color(0xFF363434);
  static const Color grey600 = Color(0xFF40403E);
  static const Color dark = Color(0xFF212121);
  static const Color green = Color(0xFF0B3631);
  static const Color moreBlack = Color(0xFF0C0C0C);
  static const Color primaryColor2 = Color(0xFF1A201D);
  static const Color yellow = Color(0xFFFABF35);
  static const Color grey200 = Color(0xFF95959C);
  static const Color coffee3 = Color(0xFFC0A67C);
  static const Color lightWhite = Color(0xD7EFEFEE);
  static const Color grey100 = Color(0xFFBDBDBD);
  static const Color darkGrey2 = Color(0xFF4C4C4C);


  static const Color grey300 = Color(0xFFE0E0E0);
   static const Color red = Color(0xFFFF4C5E);


  static const Color transparent = Colors.transparent;

  // Optional: Add a method to create a MaterialColor from a single Color
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}
