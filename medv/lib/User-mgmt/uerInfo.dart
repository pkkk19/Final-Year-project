// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:http/http.dart';
// import 'package:medv/constants.dart';
// import 'package:medv/screens/components/Add/storageReports/userdetail.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class userInfo extends StatefulWidget {
//   const userInfo({super.key});

//   @override
//   State<userInfo> createState() => _userInfoState();
// }

// class _userInfoState extends State<userInfo> {
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     final dob = "";
//     final height = "";
//     final weight = "";
//     final bloodtype = "";
//     final organdonor = "";
//     final pmc = "";
//     final medication = "";
//     final allergies = "";

//     return Container(
//       child: Column(
//         children: [
//           SingleChildScrollView(
//             child: Scaffold(
//               body: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: TextEditingController()..text = dob,
//                       decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: Colors.white, width: 1.0)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: kPrimaryColor, width: 2.0)),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30))),
//                     ),
//                     TextField(
//                       controller: TextEditingController()..text = height,
//                       decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: Colors.white, width: 1.0)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: kPrimaryColor, width: 2.0)),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30))),
//                     ),
//                     TextField(
//                       controller: TextEditingController()..text = weight,
//                       decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: Colors.white, width: 1.0)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: kPrimaryColor, width: 2.0)),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30))),
//                     ),
//                     TextField(
//                       controller: TextEditingController()..text = bloodtype,
//                       decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: Colors.white, width: 1.0)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: kPrimaryColor, width: 2.0)),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30))),
//                     ),
//                     TextField(
//                       controller: TextEditingController()..text = organdonor,
//                       decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: Colors.white, width: 1.0)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: kPrimaryColor, width: 2.0)),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30))),
//                     ),
//                     TextField(
//                       controller: TextEditingController()..text = pmc,
//                       decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: Colors.white, width: 1.0)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: kPrimaryColor, width: 2.0)),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30))),
//                     ),
//                     TextField(
//                       controller: TextEditingController()..text = medication,
//                       decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: Colors.white, width: 1.0)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: kPrimaryColor, width: 2.0)),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30))),
//                     ),
//                     TextField(
//                       controller: TextEditingController()..text = allergies,
//                       decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: Colors.white, width: 1.0)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   BorderSide(color: kPrimaryColor, width: 2.0)),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30))),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         createUserInfo(dob, height, weight, bloodtype,
//                             organdonor, pmc, medication, allergies);
//                       },
//                       child: Container(
//                         width: w * 0.5,
//                         height: h * 0.08,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(
//                             color:
//                                 kPrimaryColor, //                   <--- border color
//                             width: 3.0,
//                           ),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "Submit",
//                             style: TextStyle(
//                                 fontSize: 36,
//                                 fontWeight: FontWeight.bold,
//                                 color: kPrimaryColor),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<String> _getAccessToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String accessToken = prefs.getString('token') ?? '';
//     return accessToken;
//   }

//   Future<void> createUserInfo(
//       String dob,
//       String height,
//       String weight,
//       String blood_type,
//       String organ_donor,
//       String pmc,
//       String medication,
//       String allergies) async {
//     String Btoken = await _getAccessToken();
//     final url = Uri.parse('http://192.168.1.88:8000/userinfo');

//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $Btoken',
//     };

//     final body = jsonEncode({
//       'dob': dob,
//       'height': height,
//       'weight': weight,
//       'blood_type': blood_type,
//       'organ_donor': organ_donor,
//       'pmc': pmc,
//       'medication': medication,
//       'allergies': allergies,
//     });

//     final response = await post(url, headers: headers, body: body);

//     if (response.statusCode == 200) {
//       final userInfo = jsonDecode(response.body);
//       // Handle the userInfo object or any other response data as needed
//       print('User info created successfully. User ID: ${userInfo['id']}');
//     } else {
//       print('Failed to create user info.');
//       print('Response status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//   }
// }
