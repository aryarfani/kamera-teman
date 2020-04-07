import 'package:flutter/material.dart';

enum ViewState { Idle, Busy }
enum EndIcon { Cart, Clear, Nothing, Confirming, Borrowing, Done, Cancelled }

String url = 'http://8e93a9e9.ngrok.io';
String linkImage = '$url/lumen/kamera-teman/public/images/';
String linkApi = '$url/lumen/kamera-teman/public/api/';

class Styles {
  static Color darkPurple = Color(0xFF665CA9);
  static Color coolWhite = Color(0xFFEBEDF4);
  static List<BoxShadow> boxShadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 0.5,
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];
}
