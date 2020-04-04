import 'package:flutter/cupertino.dart';
import 'package:kamera_teman/core/models/barang_borrowed.dart';
import 'package:kamera_teman/core/providers/base_provider.dart';
import 'package:kamera_teman/core/services/riwayat_api.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:kamera_teman/locator.dart';

class RiwayatProvider extends BaseProvider {
  RiwayatApi riwayatApi = locator<RiwayatApi>();

  List<BarangBorrowed> unconfirmedRiwayat;
  List<BarangBorrowed> borrowedRiwayat;
  List<BarangBorrowed> allRiwayat;

  Future getAllRiwayat() async {
    allRiwayat = await riwayatApi.getAllRiwayat();

    setState(ViewState.Idle);
  }

  Future getUnconfirmedRiwayat() async {
    unconfirmedRiwayat = await riwayatApi.getUnconfirmedRiwayat();

    setState(ViewState.Idle);
  }

  Future getBorrowedRiwayat() async {
    borrowedRiwayat = await riwayatApi.getBorrowedRiwayat();

    setState(ViewState.Idle);
  }

  Future<bool> confirmBarang({@required int id}) async {
    var res = await riwayatApi.confirmBarang(id);
    getUnconfirmedRiwayat();
    getBorrowedRiwayat();
    return res;
  }

  Future<bool> cancelBarang({@required int id}) async {
    var res = await riwayatApi.cancelBarang(id);
    getUnconfirmedRiwayat();
    getAllRiwayat();
    return res;
  }
}
