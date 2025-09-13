part of '../theme.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  final Color backgroundSubjectColor;
  final Color borderWeekSubjectColor;

  const ThemeColors({
    required this.backgroundSubjectColor,
    required this.borderWeekSubjectColor,
  });

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? backgroundSubjectColor,
    Color? borderWeekSubjectColor,
  }) {
    return ThemeColors(
      backgroundSubjectColor:
          backgroundSubjectColor ?? this.backgroundSubjectColor,
      borderWeekSubjectColor:
          borderWeekSubjectColor ?? this.borderWeekSubjectColor,
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
      borderWeekSubjectColor:
          Color.lerp(borderWeekSubjectColor, other.borderWeekSubjectColor, t)!,
    );
  }

  static get light => ThemeColors(
        backgroundSubjectColor: AppColors.shyGrey,
        borderWeekSubjectColor: AppColors.shyGrey.withAlpha(50),
      );

  static get dark => ThemeColors(
        backgroundSubjectColor: AppColors.softRed,
        borderWeekSubjectColor: AppColors.softRed.withAlpha(50),
      );
}
