import 'package:flutter/material.dart';

ThemeData _themeLight = ThemeData.light();

final _mainColor = Colors.deepOrange[100];
const _secondaryColor = Colors.black54;

ThemeData themeLight = _themeLight.copyWith(
  textTheme: _textLight(_themeLight.textTheme),
  primaryColor: _mainColor,
  iconTheme: IconThemeData(
    color: _mainColor,
  ),
  appBarTheme: AppBarTheme(
    color: _secondaryColor,
    foregroundColor: _mainColor,
    centerTitle: false,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _secondaryColor,
    selectedItemColor: _mainColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _mainColor,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  cardTheme: CardTheme(
    color: _mainColor,
    elevation: 8,
    clipBehavior: Clip.hardEdge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: _mainColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    suffixIconColor: _mainColor,
    focusColor: _mainColor,
    hoverColor: _mainColor,
    labelStyle: TextStyle(
      color: _mainColor,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: _mainColor!),
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: _secondaryColor,
  ),
  chipTheme: ChipThemeData(
    labelStyle: const TextStyle(
      color: Colors.white,
    ),
    elevation: 4,
    showCheckmark: false,
    selectedColor: _mainColor,
    backgroundColor: _secondaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.grey,
  ),
);

TextTheme _textLight(TextTheme base) {
  return base.copyWith(
    headlineMedium: const TextStyle(
      color: _secondaryColor,
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
    ),
  );
}
