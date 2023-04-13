import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:major_try/widgets/init.dart';
import 'package:major_try/pages/hands_on_mode/choose_option_page.dart';
import 'package:major_try/pages/hands_on_mode/tap_page/common_phrase.dart';
import 'package:major_try/pages/home_page.dart';
import 'package:major_try/pages/hands_on_mode/typing_mode/typing_page.dart';
import 'package:major_try/pages/splash.dart';
import 'package:major_try/utils/themes.dart';
import 'package:major_try/utils/routes.dart';

import 'data/words_data.dart';

void main() async {
  initialize();

  //initilize Hive
  await Hive.initFlutter();
  // open HiveBox
  await Hive.openBox("hive_box");

  // referencing the box
  final myBox = Hive.box("hive_box");

  //prepopulate data with initial 3 phrases
  myBox.put(1, commonPhrase[0]);
  myBox.put(2, commonPhrase[1]);
  myBox.put(3, commonPhrase[2]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aawaj',
      theme: MyThemes.lightTheme(context),
      darkTheme: MyThemes.darkTheme(context),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routes: {
        MyRoutes.splashRoute: (context) => const SplashScreen(),
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.handsRoute: (context) => const HandsOn(),
        MyRoutes.typeRoute: (context) => const TypePage(),
        MyRoutes.tapRoute: (context) => const PhrasePage(),
      },
      home: const SplashScreen(),
    );
  }
}
