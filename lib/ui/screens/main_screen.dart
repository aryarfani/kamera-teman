import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:kamera_teman/ui/screens/chat_list_screen.dart';
import 'package:kamera_teman/ui/screens/home_screen.dart';
import 'package:kamera_teman/ui/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;

  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 45,
        backgroundColor: Styles.darkPurple,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.account_circle, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: IndexedStack(index: _page, children: [
        HomeScreen(),
        ChatListScreen(),
        ProfileScreen(),
      ]),
    );
  }
}
