import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/core/providers/chat_provider.dart';
import 'package:kamera_teman/core/services/push_notification_service.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:kamera_teman/core/utils/router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/simple_animations.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    final PushNotificationService _pushNotificationService =
        PushNotificationService(Provider.of<ChatProvider>(context, listen: false));
    _pushNotificationService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Styles.coolWhite,
        child: PlayAnimation<double>(
          tween: Tween(begin: -300, end: 0),
          duration: Duration(milliseconds: 1200),
          curve: Curves.bounceOut,
          builder: (context, child, value) {
            return Transform.translate(offset: Offset(0, value), child: child);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Admin \nKamera Teman',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF403269),
                ),
              ),
              SizedBox(height: 10),
              SvgPicture.asset('images/gambar_camera.svg', width: 300),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    Timer(Duration(milliseconds: 1700), () {
      navigateUser();
    });
  }

  void navigateUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var idCurrent = storage.get('idAdmin');
    print(idCurrent.toString());
    if (idCurrent == null) {
      Navigator.pushReplacementNamed(context, RouteName.login);
    } else {
      Navigator.pushReplacementNamed(context, RouteName.main);
    }
  }
}
