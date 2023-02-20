import 'package:get_storage/get_storage.dart';
import 'package:sangathan/Login/Network/model/user_model.dart';

class StorageService {
  static String userInfoKey = "identification_token";
  static String userAuthTokenKey = "auth_token";
  static String userDataKey = "user_data";
  static String fcmToken = "fcmToken";

  static String? userAuthToken;
  static GetStorage storage = GetStorage();
  static UserDetails? userData;

  static setUserFcmToken(String token) async {
    await storage.write(fcmToken, token);
  }

  static String? getUserFcmToken() {
    return storage.read(fcmToken);
  }

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
    // userAuthToken = storage.read(userAuthTokenKey);
    userAuthToken =
        "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiOTFuYkVmSDlVVFV3NGZEaTNVOEFucVhTIn0.JJJvYGE02350Yey4v1W1GbnP9Y1KB64T5CruVCTKA5U";
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

    /// TODO static countryStateId
    userData?.user?.countryStateId = 14;
    print('rEAD ${userData?.user?.countryStateId}');
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
