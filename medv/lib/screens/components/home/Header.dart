import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medv/components/greeting_functions.dart';
import 'package:medv/constants.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<Header> createState() => _HeaderState();
}

//========================================================
class _HeaderState extends State<Header> {
  String _greetingMessage = '';

  @override
  void initState() {
    super.initState();
    setGreetingMessage(_setMessageState);
  }

  void _setMessageState(String message) {
    setState(() {
      _greetingMessage = message;
    });
  }
//=============================================================

  bool Username = false;
  String fetchedUsername = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: KDefaultPadding + 140,
      ),
      width: widget.size.width,
      height: widget.size.height * 0.28 - 28,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: Column(
        children: <Widget>[
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text(
              _greetingMessage + ",",
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.only(
                left: KDefaultPadding,
              ),
              child: FutureBuilder(
                  future: getName(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        " ${(snapshot.data)}!",
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  })),
          Spacer()
        ],
      ),
    );
  }

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
        print(data[0]["FirstName"]);
        var firstName = data[0]["FirstName"];
        return firstName;
      } else {
        throw Exception('Failed');
      }
    } catch (e) {
      return e.toString();
    }
  }
}
