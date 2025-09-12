part of '../theme.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  final Color backgroundSubjectColor;

  const ThemeColors({
    required this.backgroundSubjectColor,
  });

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? backgroundSubjectColor,
  }) {
    return ThemeColors(
      backgroundSubjectColor:
          backgroundSubjectColor ?? this.backgroundSubjectColor,
    );
  }

  @override
  ThemeExtension<ThemeColors> lerp(
    ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors(
      backgroundSubjectColor:
          Color.lerp(backgroundSubjectColor, other.backgroundSubjectColor, t)!,
    );
  }

  static get light => ThemeColors(
        backgroundSubjectColor: AppColors.shyGrey,
      );

  static get dark => ThemeColors(
        backgroundSubjectColor: AppColors.softRed,
      );
}
