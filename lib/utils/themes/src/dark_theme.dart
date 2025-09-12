part of '../theme.dart';

ThemeData createDarkTheme() {
  return ThemeData(
    textTheme: createTextTheme(),
    scaffoldBackgroundColor: AppColors.softGrey,
    extensions: <ThemeExtension<dynamic>>[
      ThemeColors.dark,
      ThemeTextStyles.dark,
    ],
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.softGrey,
      iconTheme: const IconThemeData(color: AppColors.white),
    ),
  );
}
