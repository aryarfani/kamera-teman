import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kamera_teman/core/models/admin.dart';
import 'package:kamera_teman/core/services/admin_api.dart';
import 'package:kamera_teman/core/services/api.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:kamera_teman/locator.dart';

class AdminProvider extends ChangeNotifier {
  ApiService apiService = ApiService();
  AdminApi adminApi = locator<AdminApi>();

  AdminProvider() {
    getAdmins();
  }

  List<Admin> admins;
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void getAdmins() async {
    admins = await adminApi.getAdmins();
    notifyListeners();
  }

  Future addAdmin(
      {@required File imageFile,
      @required String nama,
      @required String alamat,
      @required String email,
      @required String phone,
      @required String password}) async {
    try {
      setState(ViewState.Busy);
      var isUploadSuccess = await adminApi.uploadAdmin(imageFile, nama, alamat, email, phone, password);
      setState(ViewState.Idle);

      return isUploadSuccess;
    } catch (e) {
      print(e);
    }
  }

  void deleteAdmin({@required Admin admin}) async {
    int id = admin.id;
    admins.remove(admin);

    try {
      await apiService.delete('admin', id);
    } on Exception catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
