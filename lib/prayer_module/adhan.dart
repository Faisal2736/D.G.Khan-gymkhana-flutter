import 'package:flutter/material.dart';
import 'package:gymkhana_club/prayer_module/screen/addcity_screen.dart';
import 'package:gymkhana_club/prayer_module/screen/adhanscreen.dart';

class Adhan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => CityPage(),
        '/times': (context) => TimesPage(),
      },
    );
  }
}
