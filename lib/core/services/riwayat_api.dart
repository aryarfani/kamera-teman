import 'package:http/http.dart' as http;
import 'package:kamera_teman/core/models/barang_borrowed.dart';
import 'package:kamera_teman/core/services/api.dart';
import 'package:kamera_teman/core/utils/constant.dart';

class RiwayatApi {
  Future<List<BarangBorrowed>> getAllRiwayat() async {
    var res = await http.get(linkApi + 'riwayat');
    print('getAllRiwayat done');
    List<BarangBorrowed> data = [];
    if (res.statusCode == 200 && res.body != '[]') {
      data = await ApiService.jsonToBarangBorrowedList(res);
    }
    return data;
  }

  Future<List<BarangBorrowed>> getBorrowedRiwayat() async {
    print('getBorrowedRiwayat working');
    var res = await http.get(linkApi + 'borrowed-riwayat');
    List<BarangBorrowed> data = [];
    if (res.statusCode == 200 && res.body != '[]') {
      data = await ApiService.jsonToBarangBorrowedList(res);
    }
    return data;
  }

  Future<List<BarangBorrowed>> getUnconfirmedRiwayat() async {
    print('getUnconfirmedRiwayat working');
    var res = await http.get(linkApi + 'unconfirmed-riwayat');
    List<BarangBorrowed> data = [];
    if (res.statusCode == 200 && res.body != '[]') {
      data = await ApiService.jsonToBarangBorrowedList(res);
    }
    return data;
  }

  Future confirmBarang(int id) async {
    print('confirmBarang working');
    var res = await http.get(linkApi + 'barang/$id/confirm');
    if (res.statusCode == 200) {
      print('confirmBarang success');
      return true;
    } else {
      print('confirmBarang false');
      return false;
    }
  }

  Future cancelBarang(int id) async {
    print('cancelBarang working');
    var res = await http.get(linkApi + 'barang/$id/cancel');
    if (res.statusCode == 200) {
      print('cancelBarang success');
      return true;
    } else {
      print('cancelBarang false');
      return false;
    }
  }
}
