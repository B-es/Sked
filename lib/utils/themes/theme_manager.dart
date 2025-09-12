import 'package:flutter/material.dart';

import 'theme.dart';

class ThemeManager {
  static final darkTheme = createDarkTheme();
  static final lightTheme = createLightTheme();

  static ThemeData get dark => darkTheme;
  static ThemeData get light => lightTheme;

  // static ThemeData get dark => createDarkTheme();
  // static ThemeData get light => createLightTheme();
}
