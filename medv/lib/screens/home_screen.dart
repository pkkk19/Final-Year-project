import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medv/constants.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:medv/screens/components/Add/add.dart';
import 'package:medv/screens/components/Notifications/notification.dart';
import 'package:medv/screens/components/home/User_home_test.dart';
import 'package:medv/screens/components/profile/profile_screen.dart';

import 'components/home/User_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _navigate(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    UserHomeTest(),
    Add(),
    notification(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
          color: KBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: GNav(
              backgroundColor: KBackgroundColor,
              color: kPrimaryColor,
              activeColor: kPrimaryColor,
              tabBackgroundColor: Colors.grey.shade300,
              gap: 8,
              padding: EdgeInsets.all(15),
//=====================================================================
              onTabChange: _navigate,

//=====================================================================
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.add,
                  text: 'Add',
                ),
                GButton(
                  icon: Icons.notifications,
                  text: "Notification",
                ),
                GButton(
                  icon: Icons.person_outline_rounded,
                  text: 'Profile',
                ),
              ],
            ),
          )),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      // leading: IconButton(
      //   icon: SvgPicture.asset("assets/icons/menu.svg"),
      //   onPressed: () {},
      // ),
    );
  }
}
