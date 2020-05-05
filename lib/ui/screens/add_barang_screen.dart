import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kamera_teman/core/providers/barang_provider.dart';
import 'package:kamera_teman/core/services/image.dart';
import 'package:kamera_teman/ui/widgets/app_header.dart';
import 'package:kamera_teman/ui/widgets/rounded_button.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class AddBarangScreen extends StatefulWidget {
  @override
  _AddBarangScreenState createState() => _AddBarangScreenState();
}

class _AddBarangScreenState extends State<AddBarangScreen> {
  File _image;
  ImageService imageService = ImageService();

  TextEditingController cNama = TextEditingController();
  TextEditingController cStock = TextEditingController();
  TextEditingController cHarga = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Consumer<BarangProvider>(
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          body: SafeArea(
            child: AppHeader(
              mq: mq,
              iconAdd: false,
              title: 'Tambah Barang',
              widget: SingleChildScrollView(
                reverse: true,
                child: Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                        controller: cStock,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "Stock"),
                      ),
                      TextField(
                        controller: cHarga,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "Harga"),
                      ),
                      SizedBox(height: 10),
                      buildRoundedButton(model)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildRoundedButton(BarangProvider model) {
    return model.state == ViewState.Busy
        ? Center(child: CupertinoActivityIndicator())
        : RoundedButton(
            color: Color(0xFF6C63FF),
            text: 'Post',
            textColor: Colors.white,
            onPressed: () async {
              var cek = await model.addBarang(
                imageFile: _image,
                nama: cNama.text,
                stock: cStock.text,
                harga: cHarga.text,
              );
              cek ? showToast('Berhasil menambahkan barang') : showToast('Gagal menambahkan barang');
              cNama.text = '';
              cStock.text = '';
              cHarga.text = '';
              _image = null;
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
