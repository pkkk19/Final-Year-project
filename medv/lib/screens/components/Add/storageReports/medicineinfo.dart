import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class medicineinfo {
  Future<String> _getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('token') ?? '';
    return accessToken;
  }

  Future<List<dynamic>> medicines() async {
    String Btoken = await _getAccessToken();
    print("something");

    final response = await get(
      Uri.parse('http://192.168.1.88:8000/medicine-get'),
      headers: {
        'accept': 'application/json',
        'Authorization': "Bearer " + Btoken,
      },
    );
    if (response.statusCode == 200) {
      print("checker");
      final List<dynamic> fetcheddata = jsonDecode(response.body);
      // final List<Medicine> meddetails =
      //     fetcheddata.map((json) => Medicine.fromJson(json)).toList();

      print(fetcheddata[0]["medicineName"]);

      return fetcheddata;
    } else {
      print("failed");
      throw Exception('Failed');
    }
  }
}

class Medicine {
  final String medicineName;
  final String time;
  final String days;
  final String id;
  final String ownerId;
  final String dateCreated;

  Medicine({
    required this.medicineName,
    required this.time,
    required this.days,
    required this.id,
    required this.ownerId,
    required this.dateCreated,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicineName: json['medicineName'],
      time: json['time'],
      days: json['days'],
      id: json['id'],
      ownerId: json['owner_id'],
      dateCreated: json['date_created'],
    );
  }
}
