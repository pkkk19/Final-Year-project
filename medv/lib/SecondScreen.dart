import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String? payload;

  SecondScreen(this.payload);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Text('Payload: $payload'),
      ),
    );
  }
}
