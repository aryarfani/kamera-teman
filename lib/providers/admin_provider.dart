import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/models/admin.dart';
import 'package:kamera_teman/providers/base_provider.dart';
import 'package:kamera_teman/services/admin_api.dart';
import 'package:kamera_teman/utils/constant.dart';

class AdminProvider extends BaseProvider {
  AdminApi adminApi = locator<AdminApi>();

  AdminProvider() {
    getAdmins();
  }

  List<Admin> admins;

  void getAdmins() async {
    admins = await adminApi.getAdmins();
    notifyListeners();
  }

  void addAdmin(
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
