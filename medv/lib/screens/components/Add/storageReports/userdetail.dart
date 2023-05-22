import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetail {
  Future<String> _getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('token') ?? '';
    return accessToken;
  }

  Future<String> _getAccessType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('type') ?? '';
    return accessToken;
  }

  Future<String> getName() async {
    String Btoken = await _getAccessToken();
    String Btype = await _getAccessType();
    try {
      final response = await get(
        Uri.parse('http://192.168.1.88:8000/user-details-get'),
        headers: {
          'accept': 'application/json',
          'Authorization': "Bearer " + Btoken,
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print(data[0]);
        var firstName = data[0]["FirstName"];
        return firstName;
      } else {
        throw Exception('Failed');
      }
    } catch (e) {
      return e.toString();
    }
  }

  String storedname = "";
  Storename() async {
    final name = getName();
    storedname = await name;
    return storedname;
  }

  gettername() {
    String name = storedname;
    return name;
  }
}
