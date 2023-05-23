import 'package:flutter/material.dart';
import 'package:medv/User-mgmt/email_field.dart';
import 'package:medv/User-mgmt/get_started_button.dart';
import 'package:medv/User-mgmt/password_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medv/screens/home_screen.dart';
import 'package:medv/User-mgmt/signup_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as responses;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:medv/components/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  //==================================================
  String endpoint = "http://100.22.160.236:8000/";
  String hostEndpoint = "https://medical-vault-medv.onrender.com";
  Future<String> authenticate(String username, String password) async {
    // Get.to(() => HomeScreen());
    try {
      final response = await post(
        Uri.parse('http://192.168.11.238/api/token'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': '',
          'username': username,
          'password': password,
          'scope': '',
          'client_id': '',
          'client_secret': '',
        },
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
        throw Exception('Failed to authenticate user');
      }
    } catch (e) {
      return e.toString();
    }
  }
  //=================================================================================

  double _elementsOpacity = 1;
  bool loadingBallAppear = false;
  double loadingBallSize = 1;
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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: loadingBallAppear
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30.0),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 70),
                      TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 300),
                        tween: Tween(begin: 1, end: _elementsOpacity),
                        builder: (_, value, __) => Opacity(
                          opacity: value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: w,
                                height: h * 0.3,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/Logo3.png"),
                                        fit: BoxFit.contain)),
                              ),
                              SizedBox(height: 25),
                              Text(
                                "Welcome,",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 35),
                              ),
                              Text(
                                "Login to continue",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 35),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            EmailField(
                                fadeEmail: _elementsOpacity == 0,
                                emailController: emailController),
                            SizedBox(height: 20),
                            PasswordField(
                                fadePassword: _elementsOpacity == 0,
                                passwordController: passwordController),
                            SizedBox(height: 25),
                            GetStartedButton(
                              elementsOpacity: _elementsOpacity,
                              onTap: () {
                                setState(() {
                                  authenticate(emailController.text.toString(),
                                      passwordController.text.toString());
                                });
                              },
                              onAnimatinoEnd: () async {
                                await Future.delayed(
                                    Duration(milliseconds: 500));
                                setState(() {
                                  loadingBallAppear = true;
                                });
                              },
                            ),
                            SizedBox(height: 25),
                            RichText(
                              text: TextSpan(
                                  text: "Don\'t have an account? ",
                                  style: TextStyle(
                                      color: Colors.grey[500], fontSize: 20),
                                  children: [
                                    TextSpan(
                                        text: " Register",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap =
                                              () => Get.to(() => SignUpPage()))
                                  ]),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
