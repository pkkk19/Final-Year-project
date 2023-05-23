import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class medicalID {
  Future<String> _getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('token') ?? '';
    return accessToken;
  }

  Future<Map<String, dynamic>> Infos() async {
    String Btoken = await _getAccessToken();

    final response = await get(
      Uri.parse('http://192.168.1.88:8000/userinfo'),
      headers: {
        'accept': 'application/json',
        'Authorization': "Bearer " + Btoken,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> fetchedData = jsonDecode(response.body);

      // Sort the data list based on 'date_created' in descending order
      fetchedData.sort((a, b) => DateTime.parse(b['date_created'])
          .compareTo(DateTime.parse(a['date_created'])));

      // Get the latest upload (first element after sorting)
      Map<String, dynamic> latestUpload = fetchedData.first;

      return latestUpload;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
