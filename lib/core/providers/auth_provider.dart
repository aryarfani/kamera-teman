import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kamera_teman/core/models/admin.dart';
import 'package:kamera_teman/core/services/admin_api.dart';
import 'package:kamera_teman/core/services/api.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:kamera_teman/core/utils/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  ApiService apiService = ApiService();

  //Property state
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  String _namaCurrent;
  String get namaCurrent => _namaCurrent;

  int _idCurrent;
  int get idCurrent => _idCurrent;

  Admin _currentAdmin;
  Admin get currentAdmin => _currentAdmin;

  //Property message to login error
  String _message;
  String get message => _message;

  //Function to change state
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  //Function to admin login
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

  Future logout(BuildContext context) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    _currentAdmin = null;
    if (await storage.clear()) {
      Navigator.of(context).pushReplacementNamed(RouteName.login);
    }
  }

  //Function save admin data to sharedpreferences
  Future<bool> storeUserData(int id, String nama) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    _namaCurrent = nama;
    _idCurrent = id;
    await storage.setString('namaAdmin', nama);
    await storage.setInt('idAdmin', id);
    return true;
  }

  //Function get admin data for sharedpreferences
  Future getUserData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    _idCurrent = storage.get('idAdmin');
    _namaCurrent = storage.getString('namaAdmin');
  }

  Future getCurrentAdminData() async {
    await getUserData();
    print("getCurrentAdminData");
    try {
      _currentAdmin = await AdminApi().getAdminById(idCurrent);
    } on Exception catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
