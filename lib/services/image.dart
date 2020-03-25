import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;

class ImageService {
  Future getImageGallery() async {
    return await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future getImageCamera() async {
    return await ImagePicker.pickImage(source: ImageSource.camera);
  }

  // 2. compress file and get file.
  Future<File> compressFile(File file) async {
    // mengambil directori sementara untuk proses pengecilan gambar
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    Img.Image image = Img.decodeImage(file.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, height: 800);

    var compressedImg = File("$path/image.jpg")..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 90));

    return compressedImg;
  }
}
