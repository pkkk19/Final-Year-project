import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as responses;
import 'package:medv/constants.dart';
import 'package:day_picker/day_picker.dart';
import 'package:intl/intl.dart';
import 'package:medv/screens/components/Add/Medication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveDetails extends StatefulWidget {
  SaveDetails({super.key});

  @override
  State<SaveDetails> createState() => _SaveDetailsState();
}

class _SaveDetailsState extends State<SaveDetails> {
  String dateTime = "";
  DateTime Time = DateTime.now();
  int _selectedValue = 1;
  List<DayInWeek> _days = [
    DayInWeek(
      "Sun",
    ),
    DayInWeek(
      "Mon",
    ),
    DayInWeek("Tue", isSelected: true),
    DayInWeek(
      "Wed",
    ),
    DayInWeek(
      "Thu",
    ),
    DayInWeek(
      "Fri",
    ),
    DayInWeek(
      "Sat",
    ),
  ];
  String daysofuse = "";

  // Future<String> savingMedicine(String medicineName, String days, String time) async{

  //   try {
  //     final response = await post(
  //       Uri.parse('http://192.168.1.88:8000/api/token'),
  //       headers: {
  //         'accept': 'application/json',
  //         'Content-Type': 'application/x-www-form-urlencoded',
  //       },
  //       body: {
  //         "MedicineName": medicineName,
  // "time": time,
  // "days": days,
  //       },
  //     );
  //     if (response.statusCode == 200) {

  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final arguments = Get.arguments;
    final medicationName = arguments['medicationName'];

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Medicine Reminder",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Medicine Name",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: KBackgroundColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2))
                      ]),
                  child: TextField(
                    controller: TextEditingController()..text = medicationName,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: kPrimaryColor, width: 2.0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Time",
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            buildDatePicker(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Days in week of use",
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            SelectWeekDays(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              days: _days,
              border: true,
              boxDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  colors: [
                    Color.fromARGB(255, 14, 98, 14),
                    Color.fromARGB(255, 13, 187, 42)
                  ],
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
              onSelect: (values) {
                // <== Callback to handle the selected days
                daysofuse = values.join(' ');
                print(daysofuse);
              },
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                medicineSave(medicationName, dateTime, daysofuse);
              },
              child: Container(
                width: w * 0.5,
                height: h * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: kPrimaryColor, //                   <--- border color
                    width: 3.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDatePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: Time,
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (newDateTime) {
            dateTime = DateFormat('HH:mm').format(newDateTime);
            setState(() {
              dateTime = DateFormat('HH:mm').format(newDateTime);
              print(dateTime);
            });
          },
        ),
      );
}

Future<String> _getAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('token') ?? '';
  return accessToken;
}

Future<String> medicineSave(
    String medicineName, String datetime, String days) async {
  String Btoken = await _getAccessToken();
  try {
    final medicineData = {
      "medicineName": medicineName,
      "time": datetime,
      "days": days
    };
    final response = await post(
      Uri.parse('http://192.168.1.88:8000/medicine-post'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $Btoken",
      },
      body: jsonEncode(medicineData),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final medicationName = data['medicineName'];
      return medicationName;
    } else {
      throw Exception("Failed to Save Medication Information");
    }
  } catch (e) {
    return e.toString();
  }
}
