import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(App());
}
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          backgroundColor: Color(0xFFE7626C),
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Color(0xFF232B55),
            ),
          ),
          cardColor: Color(0xFFF4EDDB),
        ),
        home: HomeScreen()
    );
  }
}