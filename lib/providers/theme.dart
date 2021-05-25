import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

// accentColor: icon colors
class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.purple),
    accentColor: Colors.green,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
    accentColor: Colors.amber,
  );
}



























// import 'package:flutter/material.dart';

// class ThemeChanger with ChangeNotifier {
//   ThemeData light =
//       ThemeData(brightness: Brightness.light, primaryColor: Colors.amber);
//   ThemeData dark =
//       ThemeData(brightness: Brightness.dark, primaryColor: Colors.green);

//   ThemeData _themeData;

//   ThemeChanger(this._themeData);

//   getTheme() => this._themeData;
//   setTheme1() {
//     _themeData = light;
//     notifyListeners();
//   }

//   setTheme2() {
//     _themeData = dark;
//     notifyListeners();
//   }

//   setTheme(ThemeData theme) {
//     _themeData = theme;
//     notifyListeners();
//   }
// }
