import 'package:flutter/material.dart';

class ColorHelper {
  static final MaterialColor white = const MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );

  static const MaterialColor primary = const MaterialColor(
    0xFFD24726,
    const <int, Color>{50: const Color(0x7FD24726)},
  );

  static final red = Color(0xFFFF4759);
  static final dark_red = Color(0xFFE03E4E);
  static final dark_bg = Color(0xFF18191A);
}
