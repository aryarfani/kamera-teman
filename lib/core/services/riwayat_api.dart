import 'package:http/http.dart' as http;
import 'package:kamera_teman/core/models/barang_borrowed.dart';
import 'package:kamera_teman/core/services/api.dart';
import 'package:kamera_teman/core/utils/constant.dart';

class RiwayatApi {
  Future checkOutPesanan(int id) async {
    print('checkOutPesanan working');
    var res = await http.get(linkApi + 'checkOutPesanan/$id');
    if (res.statusCode == 200) {
      print('checkOutPesanan success');

      return true;
    } else {
      print('checkOutPesanan failed' + res.statusCode.toString());

      return false;
    }
  }

  Future<List<BarangBorrowed>> getAllRiwayat() async {
    var res = await http.get(linkApi + 'getAllRiwayat/');
    print('getAllRiwayat done');
    List<BarangBorrowed> data = [];
    if (res.statusCode == 200 && res.body != '[]') {
      data = await ApiService.jsonToBarangBorrowedList(res);
    }
    return data;
  }

  Future<List<BarangBorrowed>> getBorrowedRiwayat() async {
    print('getBorrowedRiwayat working');
    var res = await http.get(linkApi + 'getBorrowedRiwayat/');
    List<BarangBorrowed> data = [];
    if (res.statusCode == 200 && res.body != '[]') {
      data = await ApiService.jsonToBarangBorrowedList(res);
    }
    return data;
  }

  Future<List<BarangBorrowed>> getUnconfirmedRiwayat() async {
    print('getUnconfirmedRiwayat working');
    var res = await http.get(linkApi + 'getUnconfirmedRiwayat/');
    List<BarangBorrowed> data = [];
    if (res.statusCode == 200 && res.body != '[]') {
      data = await ApiService.jsonToBarangBorrowedList(res);
    }
    return data;
  }

  Future confirmBarang(int id) async {
    print('confirmBarang working');
    var res = await http.get(linkApi + 'confirmBarang/$id');
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
    var res = await http.get(linkApi + 'cancelBarang/$id');
    if (res.statusCode == 200) {
      print('cancelBarang success');
      return true;
    } else {
      print('cancelBarang false');
      return false;
    }
  }
}
