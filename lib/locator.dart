import 'package:get_it/get_it.dart';
import 'package:kamera_teman/providers/admin_provider.dart';
import 'package:kamera_teman/providers/auth_provider.dart';
import 'package:kamera_teman/providers/barang_provider.dart';
import 'package:kamera_teman/providers/member_provider.dart';
import 'package:kamera_teman/services/admin_api.dart';
import 'package:kamera_teman/services/api.dart';
import 'package:kamera_teman/services/barang_api.dart';
import 'package:kamera_teman/services/image.dart';
import 'package:kamera_teman/services/member_api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => BarangProvider());
  locator.registerFactory(() => AdminProvider());
  locator.registerFactory(() => MemberProvider());

  locator.registerLazySingleton(() => ImageService());
  locator.registerLazySingleton(() => AuthProvider());
  locator.registerLazySingleton(() => AdminApi());
  locator.registerLazySingleton(() => MemberApi());
  locator.registerLazySingleton(() => BarangApi());
  locator.registerLazySingleton(() => ApiService());
}
