import 'package:azul_project/helpers/colors.dart';
import 'package:azul_project/helpers/constants.dart';
import 'package:azul_project/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'AlJazeera',
        scaffoldBackgroundColor: kColorWhite,
      ),
      builder: (BuildContext context, Widget child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Builder(
            builder: (BuildContext context) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.0,
                ),
                child: child,
              );
            },
          ),
        );
      },
      home: HomeScreen(),
    );
  }
}
