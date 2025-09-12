part of '../theme.dart';

const fontFamily = "M PLUS Rounded 1c";

const titleMedium = TextStyle(
    fontWeight: FontWeight.w400, fontSize: 16, fontFamily: fontFamily);
const displayMedium = TextStyle(
    fontWeight: FontWeight.w400, fontSize: 14, fontFamily: fontFamily);
const labelMedium = TextStyle(
    fontWeight: FontWeight.w400, fontSize: 12, fontFamily: fontFamily);

abstract class AppColors {
  static const white = Colors.white;
  static const black = Colors.black;
  static const softRed = Color.fromARGB(255, 197, 22, 22);

  static const softGrey = Color.fromARGB(255, 20, 20, 20);
  static const shyGrey = Color.fromARGB(255, 175, 175, 175);

  static const lighterDark = Color(0xFF272727);
  static const lightDark = Color(0xFF1b1b1b);
}
