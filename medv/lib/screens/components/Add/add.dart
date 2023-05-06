import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:medv/screens/components/Add/Medication.dart';
import 'package:medv/screens/components/Add/Reports.dart';
import 'package:medv/screens/components/Add/custom_title.dart';
import 'package:medv/screens/components/Add/scanner/OpenCVScanner.dart';
import 'package:medv/screens/scanner/Scanner.dart';

import '../../../constants.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  bool darkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? Colors.grey[850] : KBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              "Add ",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 23,
            ),
            InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              onTap: () => Get.to(() => Scanner()),
              child: Container(
                width: 340,
                height: 270,
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    ImageIcon(AssetImage("assets/icons/Report.png"),
                        size: 80,
                        color: darkMode ? Colors.white : Colors.black),
                    Text(
                      "Clinical Documents",
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Spacer()
                  ],
                ),
                decoration: BoxDecoration(
                    color: darkMode ? Colors.grey[850] : kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                          color: darkMode ? Colors.black54 : Colors.grey,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                      BoxShadow(
                          color: darkMode ? Colors.grey : Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                    ]),
              ),
            ),
            Spacer(),
            InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              onTap: () => Get.to(() => medication()),
              child: Container(
                width: 340,
                height: 270,
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    ImageIcon(AssetImage("assets/icons/Pill.png"),
                        size: 80,
                        color: darkMode ? Colors.white : Colors.black),
                    Text(
                      "Medications",
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Spacer()
                  ],
                ),
                decoration: BoxDecoration(
                    color: darkMode ? Colors.grey[850] : kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                          color: darkMode ? Colors.black54 : Colors.grey,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                      BoxShadow(
                          color: darkMode ? Colors.grey : Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                    ]),
              ),
            ),
            Spacer(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Padding(
            //       padding: EdgeInsets.only(top: 50, right: 3),
            //       child: ElevatedButton(
            //         child: Text(
            //           'Light',
            //           style: TextStyle(color: Colors.black),
            //         ),
            //         onPressed: () {
            //           setState(() {
            //             darkMode = false;
            //           });
            //         },
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(top: 50, left: 3),
            //       child: ElevatedButton(
            //         child: Text(
            //           'Dark',
            //           style: TextStyle(color: Colors.white),
            //         ),
            //         onPressed: () {
            //           setState(() {
            //             darkMode = true;
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
