import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:kamera_teman/core/services/api.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:kamera_teman/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  ApiService apiService = locator<ApiService>();

  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  String _namaCurrent;
  String get namaCurrent => _namaCurrent;
  int _idCurrent;
  int get idCurrent => _idCurrent;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  String _message;
  String get message => _message;

  Future login({@required String email, @required String password}) async {
    setState(ViewState.Busy);

    Response res = await apiService.login(email, password);
    if (res.statusCode == 200) {
      var apiResponse = json.decode(res.body);

      //* wait till user data saved to SharedPreferences
      if (await storeUserData(apiResponse['id'], apiResponse['nama']) == true) {
        print('user data saved done');
        return res.statusCode;
      }
      _message = '';
    } else if (res.statusCode == 401) {
      _message = 'Email atau password salah';
    } else {
      _message = 'Login gagal, cek koneksi internet';
    }
    setState(ViewState.Idle);
  }

  Future<bool> storeUserData(int id, String nama) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    _namaCurrent = nama;
    _idCurrent = id;
    await storage.setString('namaAdmin', nama);
    await storage.setInt('idAdmin', id);
    return true;
  }

  void getUserData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    _idCurrent = storage.get('idAdmin');
    _namaCurrent = storage.getString('namaAdmin');
    notifyListeners();
  }
}
