import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medv/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //It will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          //this will help us cover the 20% of our total height
          height: size.height * 0.2,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: 15 + KDefaultPadding,
                  right: KDefaultPadding,
                  bottom: 36 + KDefaultPadding,
                ),
                height: size.height * 0.2 - 27,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Hi User!',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: KDefaultPadding),
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimaryColor.withOpacity(0.23),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "     Search",
                            hintStyle: TextStyle(
                              color: kPrimaryColor.withOpacity(0.3),
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            // suffixIcon:
                            //     SvgPicture.asset("assets/icons/search.svg"),
                          ),
                        ),
                      ),
                      SvgPicture.asset("assets/icons/search.svg"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
