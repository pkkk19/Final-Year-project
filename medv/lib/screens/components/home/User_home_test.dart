import 'package:flutter/material.dart';
import 'package:medv/components/greeting_functions.dart';
import 'package:medv/screens/components/Add/storageReports/userdetail.dart';
import 'package:medv/screens/components/home/Home_Body.dart';
import 'package:medv/screens/components/home/Medicines.dart';
import 'package:medv/screens/components/home/Reports.dart';
import 'package:medv/screens/components/home/title_with_more_btn.dart';

import 'Header.dart';

class UserHomeTest extends StatefulWidget {
  @override
  State<UserHomeTest> createState() => _UserHomeTestState();
}

class _UserHomeTestState extends State<UserHomeTest> {
  @override
  Widget build(BuildContext context) {
    //It will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(size: size),
          SizedBox(
            height: 20,
          ),
          Center(child: homeBody())
        ],
      ),
    );
  }
}
