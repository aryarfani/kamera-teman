import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kamera_teman/core/models/member.dart';
import 'package:kamera_teman/core/providers/base_provider.dart';
import 'package:kamera_teman/core/services/member_api.dart';
import 'package:kamera_teman/core/utils/constant.dart';

class MemberProvider extends BaseProvider {
  MemberProvider() {
    getMembers();
  }

  MemberApi memberApi = MemberApi();
  List<Member> members;

  //Function to get all member data
  void getMembers() async {
    members = await memberApi.getMembers();
    notifyListeners();
  }

  //Function to add new member
  Future addMember(
      {@required File imageFile,
      @required String nama,
      @required String alamat,
      @required String email,
      @required String phone,
      @required String password}) async {
    try {
      setState(viewState: ViewState.Busy);
      var isUploadSuccess = await memberApi.uploadMember(imageFile, nama, alamat, email, phone, password);
      setState(viewState: ViewState.Idle);

      return isUploadSuccess;
    } catch (e) {
      print(e);
    }
  }

  //Function to delete an existing member
  void deleteMember({@required Member member}) async {
    int id = member.id;
    members.remove(member);
    try {
      await apiService.delete('member', id);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
