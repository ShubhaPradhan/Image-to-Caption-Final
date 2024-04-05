import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../config/prefs.dart';

class StorageService extends GetxService {
  late GetStorage _box;
  Future<StorageService> init() async {
    _box = GetStorage();

    await _box.writeIfNull(newUser, 1);
    return this;
  }

  Future<StorageService> setFirstLogin() async {
    _box = GetStorage();
    await _box.writeIfNull(firstLogin, 1);
    return this;
  }

  void clickedGetStarted() {
    _box.write(newUser, 2);
  }

  bool isNewUser() {
    if (_box.read(newUser) == 1) {
      return true;
    }
    return false;
  }

  bool isFirstLogin() {
    if (_box.read(firstLogin) == 1) {
      // write firstLogin to 2
      _box.write(firstLogin, 2);
      return true;
    }
    return false;
  }
}
