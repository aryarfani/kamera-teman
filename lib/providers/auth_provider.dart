import 'package:flutter/foundation.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/providers/base_provider.dart';
import 'package:kamera_teman/services/api.dart';
import 'package:kamera_teman/utils/constant.dart';

class AuthProvider extends BaseProvider {
  ApiService apiService = locator<ApiService>();

  String message;

  Future login({@required String email, @required String password}) async {
    setState(ViewState.Busy);
    var result = await apiService.login(email, password);
    message = result;
    setState(ViewState.Idle);

    return result;
  }
}
