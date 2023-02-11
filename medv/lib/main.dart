import 'package:flutter/material.dart';
import 'package:medv/Splash.dart';
import 'package:get/get.dart';
import 'package:medv/constants.dart';
import 'package:medv/screens/home/home_screen.dart';
import 'package:medv/screens/scanner/Scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Med V',
      theme: ThemeData(
        scaffoldBackgroundColor: KBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: KTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scanner(),
    );
  }
}
