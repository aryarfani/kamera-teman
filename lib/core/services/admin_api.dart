import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:kamera_teman/core/models/admin.dart';
import 'package:kamera_teman/core/services/api.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:path/path.dart' as Path;

class AdminApi extends ApiService {
  Future<List<Admin>> getAdmins() async {
    var response = await http.get(linkApi + 'admin');
    var jsonObject = await json.decode(response.body);
    List<dynamic> dataJson = jsonObject;
    List<Admin> admins = [];

    for (var data in dataJson) admins.add(Admin.fromJson(data));
    return admins;
  }

  Future<Admin> getAdminById(int id) async {
    var response = await http.get(linkApi + 'admin/$id');
    var jsonObject = await json.decode(response.body);
    Admin admin = Admin.fromJson(jsonObject);
    return admin;
  }

  Future uploadAdmin(File imageFile, String nama, String alamat, String email, String phone, String password) async {
    var compressedImg = await imageService.compressFile(imageFile);
    //* Upload Process
    var stream = http.ByteStream(DelegatingStream.typed(compressedImg.openRead()));
    var length = await compressedImg.length();
    var uri = Uri.parse(linkApi + 'admin');

    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('gambar', stream, length, filename: Path.basename(compressedImg.path));

    // masukan field sama dengan key pada api
    request.fields['nama'] = nama;
    request.fields['alamat'] = alamat;
    request.fields['email'] = email;
    request.fields['phone'] = phone;
    request.fields['password'] = password;
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
