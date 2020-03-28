import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/core/providers/member_provider.dart';
import 'package:kamera_teman/core/services/image.dart';
import 'package:kamera_teman/ui/widgets/app_header.dart';
import 'package:kamera_teman/ui/widgets/rounded_button.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class AddMemberScreen extends StatefulWidget {
  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
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
    return ChangeNotifierProvider<MemberProvider>(
      create: (context) => locator<MemberProvider>(),
      child: Consumer<MemberProvider>(
        builder: (context, model, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            body: SafeArea(
              child: AppHeader(
                mq: mq,
                iconAdd: false,
                title: 'Tambah Member',
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

  Widget buildRoundedButton(MemberProvider model) {
    print(model.state);
    return model.state == ViewState.Busy
        ? Center(child: CupertinoActivityIndicator())
        : RoundedButton(
            color: Color(0xFF6C63FF),
            text: 'Post',
            textColor: Colors.white,
            onPressed: () async {
              var cek = await model.addMember(
                imageFile: _image,
                nama: cNama.text,
                alamat: cAlamat.text,
                email: cEmail.text,
                phone: cPhone.text,
                password: cPassword.text,
              );

              cek ? showToast('Berhasil menambahkan pelanggan') : showToast('Gagal menambahkan pelanggan');
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
