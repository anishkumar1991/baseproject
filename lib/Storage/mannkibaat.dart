import 'package:get_storage/get_storage.dart';
import 'package:sangathan/Login/Network/model/user_model.dart';

class MKBStorageService {
  static String MKBuserInfoKey = "MKBuserInfoKey";
  static String MKBuserAuthTokenKey = "MKBuserAuthTokenKey";
  static GetStorage MKBstorage = GetStorage();

  static setUserIdentificationToken(String token) async {
    await MKBstorage.write(MKBuserInfoKey, token);
  }

  static String? getUserIdentificationToken() {
    return MKBstorage.read(MKBuserInfoKey);
  }

  static setUserAuthToken(String token) async {
    await MKBstorage.write(MKBuserAuthTokenKey, token);
  }

  static String? getUserAuthToken() {
    return MKBstorage.read(MKBuserAuthTokenKey);


  }
}
