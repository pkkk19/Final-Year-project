import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medv/User-mgmt/email_field.dart';
import 'package:medv/User-mgmt/get_started_button.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:medv/User-mgmt/password_field.dart';
import 'package:medv/components/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signUPbutton.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthController authController = Get.find();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  double _elementsOpacity = 1;

  bool loadingBallAppear = false;

  double loadingBallSize = 1;

  //==========================================================
  String endpoint = "http://100.22.160.236:8000/";
  String hostEndpoint = "https://medical-vault-medv.onrender.com";
  Future<void> createUser(String email, String password) async {
    final url = Uri.parse('http://192.168.1.88:8000/api/users');

    final response = await post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      authController.login();
      final Map<String, dynamic> data = jsonDecode(response.body);
      final token = data['access_token'];
      final type = data['token_type'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('type', type);
      return token;
    } else {
      print('Failed to create user.');
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  //==========================================================

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 238, 245),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: w,
                height: h * 0.3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Logo3.png"),
                        fit: BoxFit.contain)),
                child: Column(children: [
                  SizedBox(
                    height: h * 0.16,
                  ),
                ])),
            Container(
              margin: const EdgeInsets.only(left: 60, right: 60),
              width: w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    EmailField(
                        fadeEmail: _elementsOpacity == 0,
                        emailController: emailController),
                    SizedBox(height: 20),
                    SizedBox(height: 30),
                    PasswordField(
                        fadePassword: _elementsOpacity == 0,
                        passwordController: passwordController),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: Container()),
                      ],
                    )
                  ]),
            ),
            SizedBox(height: 60),
            SignUpButton(
              elementsOpacity: _elementsOpacity,
              onTap: () {
                createUser(emailController.text.toString(),
                    passwordController.text.toString());
                setState(() {});
              },
              onAnimatinoEnd: () async {
                await Future.delayed(Duration(milliseconds: 500));
                setState(() {
                  loadingBallAppear = true;
                });
              },
            ),
            SizedBox(height: 10),
            RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.back(),
                    text: "Have an account?",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 81, 54, 54)))),
            SizedBox(height: w * 0.15),
          ],
        ),
      ),
    );
  }
}
