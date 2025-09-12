part of '../theme.dart';

class ThemeTextStyles extends ThemeExtension<ThemeTextStyles> {
  final TextStyle appTitle;
  final TextStyle appDisplay;
  final TextStyle appLabel;
  final TextStyle appSubLabel;
  final TextStyle appWeekNumberLable;
  final TextStyle appName;

  ThemeTextStyles({
    required this.appTitle,
    required this.appDisplay,
    required this.appLabel,
    required this.appSubLabel,
    required this.appWeekNumberLable,
    required this.appName,
  });

  @override
  ThemeExtension<ThemeTextStyles> copyWith({
    TextStyle? appTitle,
    TextStyle? appDisplay,
    TextStyle? appLabel,
    TextStyle? appSubLabel,
    TextStyle? appWeekNumberLable,
    TextStyle? appName,
  }) {
    return ThemeTextStyles(
      appTitle: appTitle ?? this.appTitle,
      appDisplay: appDisplay ?? this.appDisplay,
      appLabel: appLabel ?? this.appLabel,
      appSubLabel: appSubLabel ?? this.appSubLabel,
      appWeekNumberLable: appWeekNumberLable ?? this.appWeekNumberLable,
      appName: appName ?? this.appName,
    );
  }

  @override
  ThemeExtension<ThemeTextStyles> lerp(
    ThemeExtension<ThemeTextStyles>? other,
    double t,
  ) {
    if (other is! ThemeTextStyles) {
      return this;
    }

    return ThemeTextStyles(
      appTitle: TextStyle.lerp(appTitle, other.appTitle, t)!,
      appDisplay: TextStyle.lerp(appDisplay, other.appDisplay, t)!,
      appLabel: TextStyle.lerp(appLabel, other.appLabel, t)!,
      appSubLabel: TextStyle.lerp(appSubLabel, other.appSubLabel, t)!,
      appWeekNumberLable:
          TextStyle.lerp(appWeekNumberLable, other.appWeekNumberLable, t)!,
      appName: TextStyle.lerp(appName, other.appName, t)!,
    );
  }

  static get light => ThemeTextStyles(
        appTitle: titleMedium.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
        ),
        appDisplay: displayMedium.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
        appLabel: labelMedium.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        appSubLabel: labelMedium.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.shyGrey,
        ),
        appWeekNumberLable: labelMedium.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          fontSize: 18,
        ),
        appName: titleMedium.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          fontSize: 25,
        ),
      );

  static get dark => ThemeTextStyles(
        appTitle: titleMedium.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
        ),
        appDisplay: displayMedium.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
        appLabel: labelMedium.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
        appSubLabel: labelMedium.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.shyGrey,
        ),
        appWeekNumberLable: labelMedium.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.white,
          fontSize: 18,
        ),
        appName: titleMedium.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.white,
          fontSize: 25,
        ),
      );
}
