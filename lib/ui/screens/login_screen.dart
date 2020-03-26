import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/ui/widgets/app_header.dart';
import 'package:kamera_teman/ui/widgets/text_field_widget.dart';
import 'package:kamera_teman/utils/router.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController cEmail = TextEditingController();
  final TextEditingController cPassword = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: AppHeader(
            topPadding: mq.height * 0.1,
            mq: mq,
            title: 'Welcome to\n      Kamera Teman',
            iconAdd: false,
            widget: SingleChildScrollView(
              reverse: true,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFieldWidget(
                      hintText: 'E-mail',
                      cText: cEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFieldWidget(
                      hintText: 'Password',
                      cText: cPassword,
                      isPassword: true,
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(13.0),
                      color: Color(0xFF51427E),
                      child: Text('Login',
                          style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                      onPressed: () {},
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Lupa Password?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        color: Color(0xFF403269),
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Tidak punya akun ?',
                          style: GoogleFonts.openSans(
                            color: Color(0xFF403269),
                            fontSize: 13,
                          ),
                        ),
                        FlatButton(
                          child: Text('Daftar Sekarang'),
                          textColor: Color(0xFF51427E),
                          onPressed: () {
                            Navigator.pushNamed(context, RouteName.register);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
