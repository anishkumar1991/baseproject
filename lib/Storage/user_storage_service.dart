import 'package:get_storage/get_storage.dart';

class StorageService {
  static String userInfoKey = "identification_token";
    static String userAuthTokenKey = "auth_token";

  static GetStorage storage = GetStorage();

  static setUserIdentificationToken(String token)async {
  await  storage.write(userInfoKey, token);
  }

  static String? getUserIdentificationToken() {
    return storage.read(userInfoKey);
  }
  static setUserAuthToken(String token)async {
   await storage.write(userAuthTokenKey, token);
  }

  static String? getUserAuthToken() {
    return storage.read(userAuthTokenKey);
  }
  static removeUserAuthToken()async {
   await storage.remove(userAuthTokenKey);
  }
  static removeUserIdentificationToken()async {
   await storage.remove(userInfoKey);
  }
}
