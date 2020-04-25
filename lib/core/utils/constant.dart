import 'package:flutter/material.dart';

enum ViewState { Idle, Busy }
enum EndIcon { Cart, Clear, Nothing, Confirming, Borrowing, Done, Cancelled }

String url = 'http://aryarfani.galih.pw';
String linkImage = '$url/images/';
String linkApi = '$url/api/';

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
