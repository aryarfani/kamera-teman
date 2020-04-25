import 'package:flutter/foundation.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/core/services/api.dart';
import 'package:kamera_teman/core/utils/constant.dart';

// this is base viewmodel  with basic state
class BaseProvider extends ChangeNotifier {
  ApiService apiService = locator<ApiService>();

  ViewState _state = ViewState.Busy;

  ViewState get state => _state;

  void setState({ViewState viewState, bool notify = true}) {
    _state = viewState;
    if (notify) notifyListeners();
  }
}
