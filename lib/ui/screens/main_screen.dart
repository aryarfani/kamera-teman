import 'package:flutter/material.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:kamera_teman/ui/screens/chat_list_screen.dart';
import 'package:kamera_teman/ui/screens/dashboard_screen.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.white,
        selectedItemColor: Styles.darkPurple,
        currentIndex: _page,
        iconSize: 25,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('Message')),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('Profile')),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: IndexedStack(index: _page, children: [
        DashboardScreen(),
        ChatListScreen(),
        ProfileScreen(),
      ]),
    );
  }
}
