import 'package:flutter/material.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/utils/router.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamera Teman',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: RouteName.login,
      onGenerateRoute: Router.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
