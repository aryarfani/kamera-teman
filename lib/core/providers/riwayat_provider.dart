import 'package:flutter/cupertino.dart';
import 'package:kamera_teman/core/models/barang_borrowed.dart';
import 'package:kamera_teman/core/services/riwayat_api.dart';

class RiwayatProvider extends ChangeNotifier {
  RiwayatApi riwayatApi = RiwayatApi();

  List<BarangBorrowed> unconfirmedRiwayat;
  List<BarangBorrowed> borrowedRiwayat;
  List<BarangBorrowed> allRiwayat;

  //Function to get all barang from members in riwayat
  Future getAllRiwayat() async {
    allRiwayat = await riwayatApi.getAllRiwayat();
    notifyListeners();
  }

  //Function to get all uncofirmed barang from members in riwayat
  Future getUnconfirmedRiwayat() async {
    unconfirmedRiwayat = await riwayatApi.getUnconfirmedRiwayat();
    notifyListeners();
  }

  //Function to get all borrowed barang from members in riwayat
  Future getBorrowedRiwayat() async {
    borrowedRiwayat = await riwayatApi.getBorrowedRiwayat();
    notifyListeners();
  }

  //Function to confirm barang and move to borrowed barang
  Future<bool> confirmBarang({@required int id}) async {
    var res = await riwayatApi.confirmBarang(id);
    getUnconfirmedRiwayat();
    getBorrowedRiwayat();
    return res;
  }

  //Function to cancel and move to cancelled barang
  Future<bool> cancelBarang({@required int id}) async {
    var res = await riwayatApi.cancelBarang(id);
    getUnconfirmedRiwayat();
    getAllRiwayat();
    return res;
  }
}
