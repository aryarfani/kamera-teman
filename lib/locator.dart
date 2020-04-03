import 'package:get_it/get_it.dart';
import 'package:kamera_teman/core/providers/admin_provider.dart';
import 'package:kamera_teman/core/providers/auth_provider.dart';
import 'package:kamera_teman/core/providers/barang_provider.dart';
import 'package:kamera_teman/core/providers/member_provider.dart';
import 'package:kamera_teman/core/providers/riwayat_provider.dart';
import 'package:kamera_teman/core/services/admin_api.dart';
import 'package:kamera_teman/core/services/api.dart';
import 'package:kamera_teman/core/services/barang_api.dart';
import 'package:kamera_teman/core/services/image.dart';
import 'package:kamera_teman/core/services/member_api.dart';
import 'package:kamera_teman/core/services/riwayat_api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => BarangProvider());
  locator.registerFactory(() => AdminProvider());
  locator.registerFactory(() => MemberProvider());
  locator.registerFactory(() => RiwayatProvider());

  locator.registerLazySingleton(() => ImageService());
  locator.registerLazySingleton(() => AuthProvider());
  locator.registerLazySingleton(() => AdminApi());
  locator.registerLazySingleton(() => MemberApi());
  locator.registerLazySingleton(() => BarangApi());
  locator.registerLazySingleton(() => RiwayatApi());
  locator.registerLazySingleton(() => ApiService());
}
