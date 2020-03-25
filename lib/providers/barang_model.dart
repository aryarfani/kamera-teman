import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/models/barang.dart';
import 'package:kamera_teman/providers/base_model.dart';
import 'package:kamera_teman/services/barang_api.dart';
import 'package:kamera_teman/utils/constant.dart';

class BarangModel extends BaseModel {
  BarangApi barangApi = locator<BarangApi>();

  BarangModel() {
    getBarangs();
  }

  List<Barang> barangs;

  void getBarangs() async {
    setState(ViewState.Busy);
    barangs = await barangApi.getBarangs();
    setState(ViewState.Idle);
  }

  void addBarang({
    @required File imageFile,
    @required String nama,
    @required String stock,
    @required String harga,
  }) async {
    try {
      setState(ViewState.Busy);
      var isUploadSuccess = await barangApi.uploadBarang(imageFile, nama, stock, harga);
      setState(ViewState.Idle);

      return isUploadSuccess;
    } catch (e) {
      print(e);
    }
  }
}
