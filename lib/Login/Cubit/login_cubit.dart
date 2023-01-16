import 'dart:async';
import 'package:dio/dio.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Login/Cubit/login_state.dart';
import 'package:sangathan/Login/Network/api/auth_api.dart';
import 'package:sangathan/Login/Network/model/login_model.dart';
import 'package:sangathan/Storage/user_storage_service.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  final api = AuthApi(Dio(BaseOptions(
    contentType: "application/json",
  )));
  Timer? timer;
  int count = 30;
  Future<void> startTimer() async {
    emit(LoadingState());
    if (count == 0) {
      emit(TimerStopState());
    } else {
      await Future.delayed(const Duration(seconds: 1));
      count--;
      emit(TimerRunningState(count));
      startTimer();
    }
  }

  Future loginUser({required String mobileNumber}) async {
    try {
      emit(LoadingState());
      final res = await api.loginUser({'phone_number': mobileNumber});
      if (res.response.statusCode == 200) {
        LoginModel model = LoginModel.fromJson(res.data);
        StorageService.setUserData(model.identificationToken ?? '');
        emit(UserLoggedState(model));
      } else {
        LoginModel? model = LoginModel.fromJson(res.data);
        emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {}
  }

  Future resendOTP() async {
    try {
      emit(LoadingState());
      String token =  StorageService.getUserIdentificationToken()??'';
      final res = await api.loginUser({'identification_token': token});
      print('res==+${res.response.statusCode}');
      if (res.response.statusCode == 200) {
        LoginModel model = LoginModel.fromJson(res.data);
        StorageService.setUserData(model.identificationToken ?? '');
        emit(UserLoggedState(model));
      } else {
        LoginModel? model = LoginModel.fromJson(res.data);
        emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      print('catch $e');
    }
  }
}
