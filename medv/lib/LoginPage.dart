import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medv/screens/home_screen.dart';
import 'package:medv/signup_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as responses;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:medv/components/auth_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.find();

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  void login(String email, password) async {
    try {
      responses.Response response = await post(
          Uri.parse("https://medical-vault-medv.onrender.com/api/token"),
          body: {'username': email, 'password': password});

      if (response.statusCode == 200) {
        print('logged in');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String endpoint = "http://100.22.160.236:8000/";
  String hostEndpoint = "https://medical-vault-medv.onrender.com";
  Future<String> authenticate(String username, String password) async {
    // Get.to(() => HomeScreen());
    try {
      final response = await post(
        Uri.parse('http://192.168.1.88:8000/api/token'),
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
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style:
                          TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Sign into your account",
                      style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                    ),
                    SizedBox(height: 40),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Text(
                          "Forgot your password?",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[500]),
                        )
                      ],
                    )
                  ]),
            ),
            SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                authenticate(emailcontroller.text.toString(),
                    passwordcontroller.text.toString());
              },
              child: Container(
                width: w * 0.5,
                height: h * 0.08,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: AssetImage("assets/gradient.jpg"),
                        fit: BoxFit.cover)),
                child: Center(
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: w * 0.15),
            RichText(
              text: TextSpan(
                  text: "Don\'t have an account? ",
                  style: TextStyle(color: Colors.grey[500], fontSize: 20),
                  children: [
                    TextSpan(
                        text: " Create",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => SignUpPage()))
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
