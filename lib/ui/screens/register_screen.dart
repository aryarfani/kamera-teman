import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/providers/member_provider.dart';
import 'package:kamera_teman/services/image.dart';
import 'package:kamera_teman/ui/widgets/app_header.dart';
import 'package:kamera_teman/ui/widgets/text_field_widget.dart';
import 'package:kamera_teman/utils/constant.dart';
import 'package:kamera_teman/utils/validate.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File _image;
  ImageService imageService = locator<ImageService>();

  TextEditingController cNama = TextEditingController();
  TextEditingController cAlamat = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPhone = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cPassword2 = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return ChangeNotifierProvider<MemberProvider>(
      create: (context) => locator<MemberProvider>(),
      child: Consumer<MemberProvider>(
        builder: (context, model, child) {
          return Scaffold(
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              resizeToAvoidBottomPadding: false,
              body: SafeArea(
                child: AppHeader(
                  mq: mq,
                  title: 'Kamera Teman',
                  iconAdd: false,
                  widget: SingleChildScrollView(
                    reverse: true,
                    child: Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Center(
                              child: _image == null
                                  ? InkWell(
                                      onTap: () {
                                        buildShowDialog(context);
                                      },
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(90),
                                          border: Border.all(width: 1),
                                        ),
                                        child: Center(child: Icon(Icons.add_a_photo, size: 50)),
                                      ),
                                    )
                                  : Container(
                                      constraints: BoxConstraints(maxHeight: 350),
                                      child: Image.file(
                                        _image,
                                      ),
                                    ),
                            ),
                            TextFieldWidget(
                              hintText: 'Nama',
                              cText: cNama,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                return Validate.requiredField(value, 'Name wajib diisi');
                              },
                            ),
                            TextFieldWidget(
                              hintText: 'E-mail',
                              cText: cEmail,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                return Validate.validateEmail(value);
                              },
                            ),
                            TextFieldWidget(
                              hintText: 'Alamat',
                              cText: cAlamat,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                return Validate.requiredField(value, 'Alamat wajib diisi');
                              },
                            ),
                            TextFieldWidget(
                              hintText: 'Phone',
                              cText: cPhone,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                return Validate.requiredField(value, 'Phone wajib diisi');
                              },
                            ),
                            TextFieldWidget(
                              hintText: 'Password',
                              cText: cPassword,
                              isPassword: true,
                              validator: (value) {
                                return Validate.requiredField(value, 'Password wajib diisi');
                              },
                            ),
                            TextFieldWidget(
                              hintText: 'Konfirmasi Password',
                              cText: cPassword2,
                              isPassword: true,
                              validator: (value) {
                                return Validate.validateConfirmPassword(cPassword, cPassword2);
                              },
                            ),
                            SizedBox(height: 20),
                            buildRaisedButton(model),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  RaisedButton buildRaisedButton(MemberProvider model) {
    return model.state == ViewState.Busy
        ? Center(child: CupertinoActivityIndicator())
        : RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.all(13.0),
            color: Color(0xFF51427E),
            child: Text(
              'Daftar',
              style: GoogleFonts.openSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              model.addMember(
                imageFile: _image,
                nama: cNama.text,
                alamat: cAlamat.text,
                email: cEmail.text,
                phone: cPhone.text,
                password: cPassword.text,
              );
            },
          );
  }

  buildShowDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Pick from camera'),
              onTap: () async {
                var imageFile = await imageService.getImageCamera();
                setState(() {
                  _image = imageFile;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.insert_photo),
              title: Text('Pick from gallery'),
              onTap: () async {
                var imageFile = await imageService.getImageGallery();
                setState(() {
                  _image = imageFile;
                });
              },
            )
          ],
        );
      },
    );
  }
}
