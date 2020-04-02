import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/core/providers/auth_provider.dart';
import 'package:kamera_teman/ui/widgets/app_header.dart';
import 'package:kamera_teman/ui/widgets/text_field_widget.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:kamera_teman/core/utils/router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController cEmail = TextEditingController();
  final TextEditingController cPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => locator<AuthProvider>(),
      child: Consumer<AuthProvider>(builder: (context, model, child) {
        return Scaffold(
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
                          isTheLast: true,
                        ),
                        SizedBox(height: 20),
                        Text(
                          model.message ?? ' ',
                          style: GoogleFonts.openSans(
                            color: Colors.red,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 10),
                        RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.all(13.0),
                          color: Color(0xFF51427E),
                          child: model.state == ViewState.Busy
                              ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
                              : Text('Login',
                                  style: GoogleFonts.openSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  )),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            var res = await model.login(email: cEmail.text, password: cPassword.text);
                            if (res == '') {
                              showToast('Login berhasil');
                              Navigator.pushReplacementNamed(context, RouteName.home);
                            }
                          },
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
      }),
    );
  }
}
