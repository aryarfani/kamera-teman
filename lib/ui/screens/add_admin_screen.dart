import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/providers/admin_model.dart';
import 'package:kamera_teman/services/image.dart';
import 'package:kamera_teman/ui/widgets/app_header.dart';
import 'package:kamera_teman/ui/widgets/rounded_button.dart';
import 'package:kamera_teman/utils/constant.dart';
import 'package:provider/provider.dart';

class AddAdminScreen extends StatefulWidget {
  @override
  _AddAdminScreenState createState() => _AddAdminScreenState();
}

class _AddAdminScreenState extends State<AddAdminScreen> {
  File _image;
  ImageService imageService = locator<ImageService>();

  TextEditingController cNama = TextEditingController();
  TextEditingController cAlamat = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPhone = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return ChangeNotifierProvider<AdminModel>(
      create: (context) => locator<AdminModel>(),
      child: Consumer<AdminModel>(
        builder: (context, model, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            body: SafeArea(
              child: AppHeader(
                mq: mq,
                iconAdd: false,
                title: 'Tambah Admin',
                widget: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: _image == null
                            ? InkWell(
                                onTap: () {
                                  buildShowDialog(context);
                                },
                                child: Container(
                                  height: 200,
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
                      TextField(
                        controller: cNama,
                        decoration: InputDecoration(hintText: "Nama"),
                      ),
                      TextField(
                        controller: cEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(hintText: "Email"),
                      ),
                      TextField(
                        controller: cPhone,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "Phone"),
                      ),
                      TextField(
                        controller: cAlamat,
                        decoration: InputDecoration(hintText: "Alamat"),
                      ),
                      TextField(
                        controller: cPassword,
                        decoration: InputDecoration(hintText: "Password"),
                      ),
                      SizedBox(height: 10),
                      buildRoundedButton(model)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildRoundedButton(AdminModel model) {
    print(model.state);
    return model.state == ViewState.Busy
        ? Center(child: CupertinoActivityIndicator())
        : RoundedButton(
            color: Color(0xFF6C63FF),
            text: 'Post',
            textColor: Colors.white,
            onPressed: () {
              model.addAdmin(
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
