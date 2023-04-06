import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medv/components/greeting_functions.dart';
import 'package:medv/constants.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<Header> createState() => _HeaderState();
}

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: KDefaultPadding + 155,
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
          Text(
            _greetingMessage + ",",
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: KDefaultPadding + 100,
            ),
            child: Text(
              " User!",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
