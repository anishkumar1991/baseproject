import 'dart:async';
import 'package:dio/dio.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Login/Cubit/login_state.dart';
import 'package:sangathan/Login/Network/api/auth_api.dart';
import 'package:sangathan/Login/Network/model/login_model.dart';
import 'package:sangathan/Login/Network/model/user_model.dart';
import 'package:sangathan/storage/user_storage_service.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  final api = AuthApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

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
      emit(LoginLoadingState());
      final res = await api.loginUser({'phone_number': mobileNumber});
      if (res.response.statusCode == 200) {
        print(res.data['identification_token']);
        LoginModel model = LoginModel.fromJson(res.data);
        await StorageService.setUserIdentificationToken(
            model.identificationToken ?? '');
        emit(UserLoggedState(model));
      } else {
        LoginModel? model = LoginModel.fromJson(res.data);
        emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      LoginFaieldState(e.toString());
    }
  }

  Future resendOTP() async {
    try {
      emit(LoadingState());
      String token = StorageService.getUserIdentificationToken() ?? '';
      final res = await api.resendOtp({'identification_token': token});
      if (res.response.statusCode == 200) {
        LoginModel model = LoginModel.fromJson(res.data);
        emit(OtpResendSuccessfullyState(model));
      } else {
        LoginModel? model = LoginModel.fromJson(res.data);
        emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      LoginFaieldState(e.toString());
    }
  }

  Future submitOTP({required String otp}) async {
    try {
      emit(SubmitOtpLoadingState());
      String token = StorageService.getUserIdentificationToken() ?? '';
      final res =
          await api.submitOtp({'identification_token': token, 'otp': otp});

      print('res==+${res.response.statusCode}');
      print('data=${res.data}');

      if (res.response.statusCode == 200) {
        UserDetails userData = UserDetails.fromJson(res.data);
        print('Auth token==${userData.authToken}');
        await StorageService.setUserData(userData);
        StorageService.getUserData();
        await StorageService.setUserAuthToken(userData.authToken ?? '');
        emit(UserLoginSuccessfullyState(userData));
      } else {
        //UserDetails? model = UserDetails.fromJson(res.data);
        Map<String, dynamic>? msg = res.data;
        print('msg-=$msg');
        emit(LoginFaieldState(msg?['message'] ?? ''));
      }
    } on Exception catch (e) {
      emit(LoginFaieldState(e.toString()));
      print('catch $e');
    }
  }

  Future logOut() async {
    try {
      emit(LogOutLoadingState());
      String token = StorageService.getUserAuthToken() ?? '';

      final respose = await api.logOut('Bearer $token');
      print('logOut=${respose.response.statusCode}');
      if (respose.response.statusCode == 200) {
        Map<String, dynamic> msg = respose.data;
        await StorageService.removeUserAuthToken();
        await StorageService.removeUserIdentificationToken();
        emit(UserLogOutSuccessState(msg['message']));
      } else {
        emit(UserLogOutFaieldState('Something Went Wrong'));
      }
    } catch (e) {
      UserLogOutFaieldState('Something Went Wrong');
    }
  }
}
