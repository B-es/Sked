import 'package:flutter/material.dart';
import 'package:sked/utils/themes/theme.dart';

extension BuildContextExt on BuildContext {
  ThemeTextStyles get text => Theme.of(this).extension<ThemeTextStyles>()!;

  ThemeColors get color => Theme.of(this).extension<ThemeColors>()!;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
