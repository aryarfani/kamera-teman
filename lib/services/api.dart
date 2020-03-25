import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/services/image.dart';
import 'package:kamera_teman/utils/constant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ImageService imageService = locator<ImageService>();

  Future delete(String type, int id) async {
    print('delete is working');

    var uri = Uri.parse(linkApi + '$type' + '/$id');
    var request = http.MultipartRequest('POST', uri);
    request.fields['_method'] = 'delete';

    var res = await request.send();

    print('delete $id done');
    if (res.statusCode == 200) {
      return true;
    }

    return false;
  }
}
