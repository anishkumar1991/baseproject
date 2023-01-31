import 'package:get_storage/get_storage.dart';
import 'package:sangathan/Login/Network/model/user_model.dart';

class StorageService {
  static String userInfoKey = "identification_token";
  static String userAuthTokenKey = "auth_token";
  static String userDataKey = "user_data";

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
    storage.erase();
  }

  static setUserData(UserDetails userDetils) async {
    Map<String, dynamic> data = Map<String, dynamic>.from(userDetils.toJson());
    await storage.write(userDataKey, data);
    Map<String, dynamic> value = storage.read(userDataKey) ?? {};
    userData = UserDetails.fromJson(value);
    print('rEAD ${userData?.toJson()}');
  }

  static UserDetails? getUserData() {
    Map<String, dynamic> data = storage.read(userDataKey) ?? {};
    userData = UserDetails.fromJson(data);
    return userData;
  }

  static cleanAllLocalStorage() {
    storage.erase();
  }
}
