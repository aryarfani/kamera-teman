import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:kamera_teman/models/barang.dart';
import 'package:kamera_teman/services/api.dart';
import 'package:kamera_teman/utils/constant.dart';
import 'package:path/path.dart' as Path;

class BarangApi extends ApiService {
  Future<List<Barang>> getBarangs() async {
    var response = await http.get(linkApi + 'barang');
    var jsonObject = await json.decode(response.body);
    List<dynamic> dataJson = jsonObject;
    List<Barang> barangs = [];

    for (var data in dataJson) barangs.add(Barang.fromJson(data));
    return barangs;
  }

  Future uploadBarang(File imageFile, String nama, String stock, String harga) async {
    var compressedImg = await imageService.compressFile(imageFile);
    //* Upload Process
    var stream = http.ByteStream(DelegatingStream.typed(compressedImg.openRead()));
    var length = await compressedImg.length();
    var uri = Uri.parse(linkApi + 'barang');

    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('gambar', stream, length, filename: Path.basename(compressedImg.path));

    // masukan field sama dengan key pada api
    request.fields['nama'] = nama;
    request.fields['stock'] = stock.toString();
    request.fields['harga'] = harga.toString();
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
