import 'dart:convert';

import 'package:kamera_teman/core/models/barang.dart';
import 'package:kamera_teman/core/models/barang_borrowed.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/core/services/image.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';

class ApiService {
  ImageService imageService = locator<ImageService>();

  Future delete(String type, int id) async {
    print('delete is working');

    var url = Uri.parse(linkApi + '$type' + '/$id');
    var request = http.MultipartRequest('POST', url);
    request.fields['_method'] = 'delete';

    var res = await request.send();

    print('delete $id done');
    if (res.statusCode == 200) {
      showToast('Berhasil dihapus');
      return true;
    }

    return false;
  }

  Future login(String email, String password) async {
    var url = Uri.parse(linkApi + 'loginAdmin');
    var request = http.MultipartRequest('POST', url);
    request.fields['email'] = email;
    request.fields['password'] = password;

    var res = await request.send();
    print(res.statusCode);
    if (res.statusCode == 200) {
      return '';
    } else if (res.statusCode == 401) {
      return 'Email atau password salah';
    } else {
      return 'Login gagal, cek koneksi internet';
    }
  }

  static Future<List<Barang>> jsonToBarangList(http.Response res) async {
    var jsonObject = await json.decode(res.body);
    if (jsonObject == []) {
      return null;
    }
    List<dynamic> dataJson = jsonObject;
    List<Barang> barangs = [];

    for (var data in dataJson) barangs.add(Barang.fromJson(data));
    return barangs;
  }

  static Future<List<BarangBorrowed>> jsonToBarangBorrowedList(http.Response res) async {
    var jsonObject = await json.decode(res.body);
    if (jsonObject == []) {
      return null;
    }
    List<dynamic> dataJson = jsonObject;
    List<BarangBorrowed> barangs = [];

    for (var data in dataJson) barangs.add(BarangBorrowed.fromJson(data));
    return barangs;
  }
}
