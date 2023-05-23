import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'User-mgmt/LoginPage.dart';
import 'package:get/get.dart';
import 'package:medv/components/auth_controller.dart';
import 'package:medv/constants.dart';

// late final LocalNotificationaService service;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // service = LocalNotificationaService();
  // service.intialize();
  Firebase.initializeApp();
  Get.put(AuthController());
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
      home: LoginScreen(),
    );
  }
}
