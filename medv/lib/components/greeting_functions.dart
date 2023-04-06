import 'dart:async';
import 'package:flutter/material.dart';

Future<void> setGreetingMessage(Function(String) setState) async {
  var hour = DateTime.now().hour;
  var message = '';

  if (hour < 12) {
    message = 'Good morning';
  } else if (hour < 18) {
    message = 'Good afternoon';
  } else {
    message = 'Good evening';
  }

  setState(message);
}
