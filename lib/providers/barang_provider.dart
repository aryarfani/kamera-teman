import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/models/barang.dart';
import 'package:kamera_teman/providers/base_provider.dart';
import 'package:kamera_teman/services/barang_api.dart';
import 'package:kamera_teman/utils/constant.dart';

class BarangProvider extends BaseProvider {
  BarangApi barangApi = locator<BarangApi>();

  BarangProvider() {
    getBarangs();
  }

  List<Barang> barangs;

  void getBarangs() async {
    barangs = await barangApi.getBarangs();
    notifyListeners();
  }

  Future addBarang({
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

  void deleteBarang({@required Barang barang}) async {
    int id = barang.id;
    barangs.remove(barang);

    try {
      await apiService.delete('barang', id);
    } on Exception catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
