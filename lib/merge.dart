

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_screen_model.dart';
import 'main_screen_widget.dart';


class Merge extends StatelessWidget {
  const Merge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ChangeNotifierProvider(
          child: const MainScreenWidget(),
          create: (_) => MainScreenModel(),
          lazy: false,
        ),
      ),
    );
  }
}
