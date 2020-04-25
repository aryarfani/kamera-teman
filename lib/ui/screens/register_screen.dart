import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/core/providers/admin_provider.dart';
import 'package:kamera_teman/core/services/image.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:kamera_teman/core/utils/validate.dart';
import 'package:kamera_teman/ui/widgets/app_header.dart';
import 'package:kamera_teman/ui/widgets/text_field_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File _image;
  ImageService imageService = ImageService();

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
    return Consumer<AdminProvider>(
      builder: (context, model, child) {
        return Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          body: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: AppHeader(
                mq: mq,
                isRegisterScreen: true,
                title: 'Kamera Teman',
                iconAdd: false,
                widget: Container(
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
                                    height: 170,
                                    width: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(90),
                                      border: Border.all(width: 1),
                                    ),
                                    child: Center(child: Icon(Icons.add_a_photo, size: 50)),
                                  ),
                                )
                              : Container(
                                  constraints: BoxConstraints(maxHeight: 170, maxWidth: 170),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(90),
                                      border: Border.all(width: 1),
                                      image: DecorationImage(image: FileImage(_image), fit: BoxFit.cover)),
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
                          isTheLast: true,
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
          ),
        );
      },
    );
  }

  Widget buildRaisedButton(AdminProvider model) {
    return model.state == ViewState.Busy
        ? Container(child: Center(child: CupertinoActivityIndicator()), height: 50)
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
            onPressed: () async {
              FocusScope.of(context).unfocus();
              if (_formKey.currentState.validate()) {
                var cek = await model.addAdmin(
                  imageFile: _image,
                  nama: cNama.text,
                  alamat: cAlamat.text,
                  email: cEmail.text,
                  phone: cPhone.text,
                  password: cPassword.text,
                );
                if (cek != null) {
                  showToast('Registrasi berhasil');
                  Navigator.pop(context);
                } else {
                  showToast('Registrasi gagal');
                }
              }
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
