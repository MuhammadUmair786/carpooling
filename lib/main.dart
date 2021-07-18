import 'package:carpooling_app/providers/theme.dart';

import 'package:carpooling_app/views/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Carpooling",
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: ThemeData.dark(),
            // MyThemes.darkTheme,
            home: Login(),
          );
        },
      );
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              'Login sv  dvsdc',
            ),
          ),
          TextButton(
              onPressed: () {
                final themeProvider =
                    Provider.of<ThemeProvider>(context, listen: false);
                themeProvider.toggleTheme(true);
              },
              child: Text(
                "dark",
                style: TextStyle(color: Theme.of(context).accentColor),
              )),
          TextButton(
            onPressed: () {
              final themeProvider =
                  Provider.of<ThemeProvider>(context, listen: false);
              themeProvider.toggleTheme(false);
            },
            child: Text(
              "light",
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          )
        ],
      ),
    );
  }
}
