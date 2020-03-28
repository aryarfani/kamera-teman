import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/services/image.dart';
import 'package:kamera_teman/utils/constant.dart';
import 'package:http/http.dart' as http;

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
      return true;
    }

    return false;
  }

  Future login(String email, String password) async {
    var url = Uri.parse(linkApi + 'login');
    var request = http.MultipartRequest('POST', url);
    request.fields['email'] = email;
    request.fields['password'] = password;

    var res = await request.send();

    if (res.statusCode == 200) {
      return 'success';
    } else if (res.statusCode == 404) {
      return 'Email atau password salah';
    } else {
      return 'Login gagal, cek koneksi internet';
    }
  }
}
