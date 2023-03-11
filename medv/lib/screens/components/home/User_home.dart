import 'package:flutter/material.dart';
import 'package:medv/screens/components/home/Medicines.dart';
import 'package:medv/screens/components/home/Reports.dart';
import 'package:medv/screens/components/home/title_with_more_btn.dart';

import 'Header.dart';

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //It will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(size: size),
          TitleWithMoreBtn(title: "Medical Reports", press: () {}),
          Reports(),
          TitleWithMoreBtn(title: "Medicines In Use", press: () {}),
          Medicine(),
        ],
      ),
    );
  }
}
