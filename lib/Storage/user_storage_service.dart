import 'package:get_storage/get_storage.dart';

class StorageService {
  static String userInfoKey = "identification_token";
  static GetStorage storage = GetStorage();

  static setUserData(String token) {
    storage.write(userInfoKey, token);
  }

  static String? getUserIdentificationToken() {
    return storage.read(userInfoKey);
  }
}
