import 'package:get_storage/get_storage.dart';

class StorageService {
  static String userInfoKey = "identification_token";
  static String userAuthTokenKey = "auth_token";
  static String? userAuthToken;
  static GetStorage storage = GetStorage();

  static setUserIdentificationToken(String token) async {
    await storage.write(userInfoKey, token);
  }

  static String? getUserIdentificationToken() {
    return storage.read(userInfoKey);
  }

  static setUserAuthToken(String token) async {
    await storage.write(userAuthTokenKey, token);
    userAuthToken = storage.read(userAuthTokenKey);
  }

  static String? getUserAuthToken() {
    userAuthToken = storage.read(userAuthTokenKey);
    return userAuthToken;
  }

  static removeUserAuthToken() async {
    userAuthToken = null;
    await storage.remove(userAuthTokenKey);
  }

  static removeUserIdentificationToken() async {
    await storage.remove(userInfoKey);
  }
}
