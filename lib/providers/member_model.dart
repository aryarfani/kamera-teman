import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/models/member.dart';
import 'package:kamera_teman/providers/base_model.dart';
import 'package:kamera_teman/services/member_api.dart';
import 'package:kamera_teman/utils/constant.dart';

class MemberModel extends BaseModel {
  MemberApi memberApi = locator<MemberApi>();

  MemberModel() {
    getMembers();
  }

  List<Member> members;

  void getMembers() async {
    setState(ViewState.Busy);
    members = await memberApi.getMembers();
    setState(ViewState.Idle);
  }

  void addMember(
      {@required File imageFile,
      @required String nama,
      @required String alamat,
      @required String email,
      @required String phone,
      @required String password}) async {
    try {
      setState(ViewState.Busy);
      var isUploadSuccess = await memberApi.uploadMember(imageFile, nama, alamat, email, phone, password);
      setState(ViewState.Idle);

      return isUploadSuccess;
    } catch (e) {
      print(e);
    }
  }

  void deleteMember({@required Member member}) async {
    int id = member.id;
    try {
      await apiService.delete('member', id);
    } catch (e) {
      print(e);
    }
    members.remove(member);
    notifyListeners();
  }
}
