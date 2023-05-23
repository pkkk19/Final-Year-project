import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medv/components/auth_controller.dart';
import 'package:medv/screens/components/Settings/Account.dart';
import 'package:medv/screens/components/Settings/Settings.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 100),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Account Info Update",
            icon: "assets/icons/User Icon.svg",
            press: () => Get.to(() => account()),
          ),
          // ProfileMenu(
          //     text: "Settings",
          //     icon: "assets/icons/Settings.svg",
          //     press: () => Get.to(() => settings())),
          // ProfileMenu(
          //   text: "Help Center",
          //   icon: "assets/icons/Question mark.svg",
          //   press: () {},
          // ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              authController.logout();
            },
          ),
        ],
      ),
    );
  }
}
