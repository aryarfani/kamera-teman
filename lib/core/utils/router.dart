import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kamera_teman/ui/screens/add_admin_screen.dart';
import 'package:kamera_teman/ui/screens/add_barang_screen.dart';
import 'package:kamera_teman/ui/screens/add_member_screen.dart';
import 'package:kamera_teman/ui/screens/admin_screen.dart';
import 'package:kamera_teman/ui/screens/barang_screen.dart';

import 'package:kamera_teman/ui/screens/chat_list_screen.dart';
import 'package:kamera_teman/ui/screens/chat_screen.dart';
import 'package:kamera_teman/ui/screens/dashboard_screen.dart';
import 'package:kamera_teman/ui/screens/laporan_screens.dart';

import 'package:kamera_teman/ui/screens/login_screen.dart';
import 'package:kamera_teman/ui/screens/main_screen.dart';
import 'package:kamera_teman/ui/screens/member_screen.dart';
import 'package:kamera_teman/ui/screens/profile_screen.dart';
import 'package:kamera_teman/ui/screens/register_screen.dart';
import 'package:kamera_teman/ui/screens/riwayat_screen.dart';
import 'package:kamera_teman/ui/screens/splash_screen.dart';

class RouteName {
  static const String splash = 'splash';
  static const String dashboard = 'dashboard';
  static const String main = 'main';
  static const String login = 'login';
  static const String register = 'register';
  static const String chatList = 'chatList';
  static const String chat = 'chat';
  static const String profile = 'profile';
  static const String laporan = 'laporan';
  static const String adminList = 'adminList';
  static const String barangList = 'barangList';
  static const String riwayat = 'riwayat';
  static const String memberList = 'memberList';
  static const String addAdmin = 'addAdmin';
  static const String addMember = 'addMember';
  static const String addBarang = 'addBarang';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.dashboard:
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case RouteName.main:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case RouteName.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RouteName.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RouteName.chatList:
        return CupertinoPageRoute(builder: (_) => ChatListScreen());
      case RouteName.barangList:
        return CupertinoPageRoute(builder: (_) => BarangScreen());
      case RouteName.chat:
        return CupertinoPageRoute(builder: (_) => ChatScreen(settings.arguments));
      case RouteName.register:
        return CupertinoPageRoute(builder: (_) => RegisterScreen());
      case RouteName.profile:
        return CupertinoPageRoute(builder: (_) => ProfileScreen());
      case RouteName.laporan:
        return MaterialPageRoute(builder: (_) => LaporanScreen());
      case RouteName.adminList:
        return MaterialPageRoute(builder: (_) => AdminScreen());
      case RouteName.riwayat:
        return MaterialPageRoute(builder: (_) => RiwayatScreen());
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
