import 'package:azul_project/helpers/colors.dart';
import 'package:azul_project/helpers/constants.dart';
import 'package:azul_project/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      transitionDuration: Duration(milliseconds: 300),
      defaultTransition: Transition.fadeIn,
      home: HomeScreen(),
    );
  }
}
