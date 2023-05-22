import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medv/constants.dart';
import 'package:medv/screens/components/Add/storageReports/medicineinfo.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  final medicineinfo meds = medicineinfo();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Alarm",
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
                        dynamic medicine = medicineList![index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Medicine Name: ${medicine["medicineName"]}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text("Time: ${medicine["time"]}"),
                                Text("Days: ${medicine["days"]}"),
                                Text("ID: ${medicine["id"]}"),
                                Text("Owner ID: ${medicine["owner_id"]}"),
                                Text(
                                    "Date Created: ${medicine["date_created"]}"),
                              ],
                            ),
                          ),
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
          ],
        ));
  }
}
