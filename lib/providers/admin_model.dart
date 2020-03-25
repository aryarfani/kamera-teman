import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/models/admin.dart';
import 'package:kamera_teman/providers/base_model.dart';
import 'package:kamera_teman/services/admin_api.dart';
import 'package:kamera_teman/utils/constant.dart';

class AdminModel extends BaseModel {
  AdminApi adminApi = locator<AdminApi>();

  AdminModel() {
    getAdmins();
  }

  List<Admin> admins;

  void getAdmins() async {
    setState(ViewState.Busy);
    admins = await adminApi.getAdmins();
    setState(ViewState.Idle);
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
    try {
      await apiService.delete('admin', id);
    } on Exception catch (e) {
      print(e);
    }

    admins.remove(admin);
    notifyListeners();
  }
}
