import 'package:flutter/material.dart';

// accentColor: icon colors
class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.purple),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: Colors.white,
      ),
    ),
    // TextTheme().apply(
    //   bodyColor: Colors.pink,
    //   displayColor: Colors.pink,
    // ),
    accentColor: Colors.green,
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(
      color: Colors.red,
      // opacity: 0.8
    ),
    accentColor: Colors.amber,
  );
}
