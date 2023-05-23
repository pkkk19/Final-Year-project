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

Future<void> deleteMedicine(int medicineId) async {
  final url = Uri.parse('http://localhost:8000/medicine-delete/$medicineId');

  final response = await delete(url);

  if (response.statusCode == 204) {
    print('Medicine deleted successfully.');
  } else {
    print('Failed to delete medicine.');
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
