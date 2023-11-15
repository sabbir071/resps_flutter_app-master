import 'package:flutter/material.dart';
ThemeData lightTheme = ThemeData(
  fontFamily: 'Kalapurush',
  primarySwatch: Colors.green,
  primaryColor: Colors.green,
  brightness: Brightness.light,
  secondaryHeaderColor: Colors.red,
  backgroundColor: const Color(0xFFE5E5E5),
  dividerColor: const Color(0xff757575),
  colorScheme: ColorScheme(
      primary: Color(0xFF0DA151),
      brightness: Brightness.light,
      onPrimary: Colors.white,
      secondary: Colors.white,
      onSecondary: Colors.white,
      error: Colors.redAccent,
      onError: Colors.redAccent,
      background: Colors.grey.shade300,
      onBackground: Colors.grey.shade300,
      surface: Colors.grey,
      onSurface: Colors.grey),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.black),
    ),
  ),
  textTheme: const TextTheme(
      headline1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 14,
          fontStyle: FontStyle.normal),
      headline2: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      )),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.grey,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  dividerColor: Colors.black54,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
    ),
  ),
  textTheme: const TextTheme(
    subtitle1: TextStyle(color: Colors.white),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.grey, unselectedItemColor: Colors.white),
);