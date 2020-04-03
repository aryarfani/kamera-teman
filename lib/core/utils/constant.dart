import 'package:flutter/material.dart';

enum ViewState { Idle, Busy }
enum EndIcon { Cart, Clear, Nothing, Confirming, Borrowing, Done, Cancelled }

String url = 'http://5a5520de.ngrok.io';
String linkImage = '$url/lumen/kamera-teman/public/images/';
String linkApi = '$url/lumen/kamera-teman/public/api/';

class Styles {
  static Color darkPurple = Color(0xFF665CA9);
  static Color coolWhite = Color(0xFFEBEDF4);
}
