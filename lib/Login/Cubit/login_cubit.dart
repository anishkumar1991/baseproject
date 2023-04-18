import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sangathan/Login/Cubit/login_state.dart';
import 'package:sangathan/Login/Network/api/auth_api.dart';
import 'package:sangathan/Login/Network/model/login_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  final api = AuthApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true)))..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90)));

  static GetStorage storage = GetStorage();
  final focusNode = FocusNode();

 /* final api = AuthApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));
*/
  Future loginUser({required String mobileNumber}) async {
    try {
      emit(LoginLoadingState());
      final res = await api.loginUser({'mobile': mobileNumber.toString().trim(), 'imei':"874387538"});

      if (res.response.statusCode == 200) {
        LoginModel model = LoginModel.fromJson(res.data);
        emit(UserLoggedState(model));
      } else {
        emit(LoginFaieldState(res.data["message"] ?? ''));
      }
    } on Exception catch (e) {
     // print("3erjf43 "+e.toString());

      LoginFaieldState(e.toString());
    }
  }
  static setSupportNumber({required String supportNumber}) async {
    await storage.write('supportNumber', supportNumber);
  }
}
