import 'package:get_storage/get_storage.dart';
import 'package:sangathan/Login/Network/model/user_model.dart';

class MKBStorageService {
  static String userInfoKey = "identification_token";
  static String userAuthTokenKey = "auth_token";
  static String? userAuthToken;
  static GetStorage storage = GetStorage();
  static UserDetails? userData;

  static setUserIdentificationToken(String token) async {
    await storage.write(userInfoKey, token);
  }

  static String? getUserIdentificationToken() {
    return storage.read(userInfoKey);
  }

  static setUserAuthToken(String token) async {
    await storage.write(userAuthTokenKey, token);
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
    storage.erase();
  }


}
