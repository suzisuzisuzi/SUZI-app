import 'package:flutter/material.dart';

final theme = ThemeData(
  textTheme: textTheme,
  colorScheme: colorScheme,
  fontFamily: 'Erode',
  useMaterial3: true,
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 24,
          fontFamily: 'Erode',
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(
        const Color.fromRGBO(255, 66, 0, 1),
      ),
      foregroundColor: MaterialStateProperty.all(
        const Color.fromRGBO(255, 230, 180, 1),
      ),
    ),
  ),
);

final colorScheme = ColorScheme(
  primary: const Color.fromRGBO(255, 100, 2, 1),
  error: Colors.red,
  onBackground: const Color.fromRGBO(255, 230, 180, 1),
  onError: Colors.red.shade100,
  onPrimary: const Color.fromRGBO(15, 15, 25, 1),
  onSecondary: const Color.fromRGBO(255, 230, 180, 1),
  onSurface: const Color.fromRGBO(255, 230, 180, 1),
  secondary: const Color.fromRGBO(255, 66, 0, 1),
  surface: const Color.fromRGBO(15, 15, 25, 1),
  brightness: Brightness.dark,
  background: const Color.fromRGBO(15, 15, 25, 1),
);

const textTheme = TextTheme(
  headlineLarge: TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w900,
    fontFamily: 'Technor',
    color: Color.fromRGBO(255, 230, 180, 1),
  ),
);
