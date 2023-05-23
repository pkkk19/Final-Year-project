import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:medv/constants.dart';
import 'package:medv/main.dart';
import 'package:medv/screens/components/Add/storageReports/medicineinfo.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  List<bool> _switch = [
    false,
    true,
    false,
    true,
    false,
    true,
    false,
    true,
    false,
    true
  ];
  int alarmid = 1;
  final medicineinfo meds = medicineinfo();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Med Reminder",
              style: TextStyle(
                  fontFamily: 'avenir',
                  fontWeight: FontWeight.w700,
                  color: kPrimaryColor,
                  fontSize: 24),
            ),
            FutureBuilder<List<dynamic>>(
              future: meds.medicines(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<dynamic>? medicineList = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: medicineList?.length,
                      itemBuilder: (context, index) {
                        dynamic medicine = medicineList?[index];
                        Map<String, dynamic> switchItem = medicineList?[index];

                        return Column(
                          children: [
                            SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              decoration: BoxDecoration(
                                  // image: DecorationImage(
                                  //   image: AssetImage("assets/images/ID.jpg"),
                                  //   fit: BoxFit.cover,
                                  //   colorFilter: ColorFilter.mode(
                                  //       Color.fromARGB(10, 0, 0, 0).withOpacity(0.1),
                                  //       BlendMode.dstATop),
                                  // ),
                                  gradient: LinearGradient(
                                    colors: [
                                      kPrimaryColor,
                                      Colors.blueAccent,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: kPrimaryColor,
                                        offset: Offset(4.0, 4.0),
                                        blurRadius: 15.0,
                                        spreadRadius: 1.0),
                                    BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-4.0, -4.0),
                                        blurRadius: 15.0,
                                        spreadRadius: 1.0),
                                  ]),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.label,
                                            color: Colors.white, size: 24),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 185,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Medicine Name: ${medicine["medicineName"]}",
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'avenir',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 15),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${medicine["days"]}",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'avenir',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${medicine["time"]}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'avenir',
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ],
                                              ),

                                              // Text("ID: ${medicine["id"]}"),
                                              // Text(
                                              //     "Owner ID: ${medicine["owner_id"]}"),
                                              // Text(
                                              //     "Date Created: ${medicine["date_created"]}"),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Switch(
                                              value: _switch[index],
                                              onChanged: (newValue) {
                                                int alarmid = medicine['id'];
                                                setState(() {
                                                  _switch[index] =
                                                      !_switch[index];
                                                });
                                                if (newValue) {
                                                  AndroidAlarmManager.oneShot(
                                                      Duration(seconds: 5),
                                                      alarmid,
                                                      medReminder);
                                                } else {
                                                  AndroidAlarmManager.cancel(
                                                      alarmid);
                                                }
                                              },
                                              activeColor: Colors.white,
                                            ),
                                            SizedBox.fromSize(
                                              size: Size(24, 24),
                                              child: ClipOval(
                                                child: Material(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  child: InkWell(
                                                    splashColor: Color.fromARGB(
                                                        255, 24, 47, 24),
                                                    onTap: () {},
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.delete,
                                                        ) // <-- Icon
                                                        // <-- Text
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the future is still loading
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  // If there was an error while fetching the data
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  // If there is no data available
                  return Center(
                    child: Text('No data available'),
                  );
                }
              },
            ),
          ].followedBy([
            DottedBorder(
              strokeWidth: 3,
              color: kPrimaryColor,
              borderType: BorderType.RRect,
              radius: Radius.circular(24),
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(77, 82, 125, 86),
                      borderRadius: BorderRadius.all(Radius.circular(22))),
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    onPressed: () async {
                      // await service.showNotification(
                      //     id: 1,
                      //     title: "Medicine name",
                      //     body:
                      //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry.");
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/add_alarm.png',
                          scale: 1.5,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Add Reminder",
                          style: TextStyle(
                              color: kPrimaryColor, fontFamily: 'avenir'),
                        )
                      ],
                    ),
                  )),
            ),
          ]).toList(),
        ));
  }
}

void medReminder() {
  print("Alarm Fired at ${DateTime.now()}");
}
