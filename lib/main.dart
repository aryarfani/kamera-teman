import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/utils/router.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      backgroundColor: Colors.grey[600],
      textStyle: GoogleFonts.openSans(),
      textPadding: EdgeInsets.all(10.0),
      child: MaterialApp(
        title: 'Kamera Teman',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: RouteName.login,
        onGenerateRoute: Router.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
