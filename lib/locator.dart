import 'package:get_it/get_it.dart';
import 'package:kamera_teman/providers/admin_model.dart';
import 'package:kamera_teman/providers/barang_model.dart';
import 'package:kamera_teman/providers/member_model.dart';
import 'package:kamera_teman/services/admin_api.dart';
import 'package:kamera_teman/services/api.dart';
import 'package:kamera_teman/services/barang_api.dart';
import 'package:kamera_teman/services/image.dart';
import 'package:kamera_teman/services/member_api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => BarangModel());
  locator.registerFactory(() => AdminModel());
  locator.registerFactory(() => MemberModel());

  locator.registerLazySingleton(() => ImageService());
  locator.registerLazySingleton(() => AdminApi());
  locator.registerLazySingleton(() => MemberApi());
  locator.registerLazySingleton(() => BarangApi());
  locator.registerLazySingleton(() => ApiService());
}
