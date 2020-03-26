import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/ui/widgets/app_header.dart';
import 'package:kamera_teman/ui/widgets/text_field_widget.dart';

class RegisterScreen extends StatelessWidget {
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
          child: SingleChildScrollView(
            reverse: true,
            child: AppHeader(
              topPadding: mq.height * 0.1,
              mq: mq,
              title: 'Welcome to\n      Kamera Teman',
              iconAdd: false,
              widget: Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFieldWidget(
                      hintText: 'Nama',
                      cText: cEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
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
                    TextFieldWidget(
                      hintText: 'Konfirmasi Password',
                      cText: cPassword,
                      isPassword: true,
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(13.0),
                      color: Color(0xFF51427E),
                      child: Text('Daftar',
                          style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                      onPressed: () {},
                    ),
                    SizedBox(height: mq.height - mq.height * 0.715)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
