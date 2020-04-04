import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kamera_teman/ui/screens/add_admin_screen.dart';
import 'package:kamera_teman/ui/screens/add_barang_screen.dart';
import 'package:kamera_teman/ui/screens/add_member_screen.dart';
import 'package:kamera_teman/ui/screens/admin_screen.dart';
import 'package:kamera_teman/ui/screens/barang_screen.dart';
import 'package:kamera_teman/ui/screens/home_screen.dart';
import 'package:kamera_teman/ui/screens/laporan_screens.dart';

import 'package:kamera_teman/ui/screens/login_screen.dart';
import 'package:kamera_teman/ui/screens/member_screen.dart';
import 'package:kamera_teman/ui/screens/register_screen.dart';
import 'package:kamera_teman/ui/screens/splash_screen.dart';

class RouteName {
  static const String splash = 'splash';
  static const String home = 'home';
  static const String login = 'login';
  static const String register = 'register';
  static const String laporan = 'laporan';
  static const String adminList = 'adminList';
  static const String barangList = 'barangList';
  static const String memberList = 'memberList';
  static const String addAdmin = 'addAdmin';
  static const String addMember = 'addMember';
  static const String addBarang = 'addBarang';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RouteName.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RouteName.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RouteName.register:
        return CupertinoPageRoute(builder: (_) => RegisterScreen());
      case RouteName.laporan:
        return MaterialPageRoute(builder: (_) => LaporanScreen());
      case RouteName.adminList:
        return MaterialPageRoute(builder: (_) => AdminScreen());
      case RouteName.barangList:
        return MaterialPageRoute(builder: (_) => BarangScreen());
      case RouteName.memberList:
        return MaterialPageRoute(builder: (_) => MemberScreen());
      case RouteName.addAdmin:
        return MaterialPageRoute(builder: (_) => AddAdminScreen());
      case RouteName.addBarang:
        return MaterialPageRoute(builder: (_) => AddBarangScreen());
      case RouteName.addMember:
        return MaterialPageRoute(builder: (_) => AddMemberScreen());
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
