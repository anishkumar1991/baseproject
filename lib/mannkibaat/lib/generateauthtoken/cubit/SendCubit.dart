import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Values/string.dart';
import 'package:sangathan/mannkibaat/lib/generateauthtoken/network/model/LoginModel.dart';
import 'package:sangathan/mannkibaat/lib/generateauthtoken/network/model/UserDetailsModel.dart';

import '../../../../Storage/mannkibaat.dart';
import '../../Storage/user_storage_service.dart';

import '../network/model/UserNewAddModel.dart';
import '../network/services/LoginApi.dart';
import 'SendState.dart';

class GenerateMannKiBaatAuthCubit extends Cubit<GenerateMannKiBaatAuthState> {
  GenerateMannKiBaatAuthCubit() : super(LoginInitialState());

  final api =
      MannKibaatAuthApi(Dio(BaseOptions(validateStatus: ((status) => true))));
  UserDetails? userData;

  Future sendOtp({required String mobileNumber}) async {
    try {
      emit(LoadingState());
      final res = await api.sendOtp({'phone_number': mobileNumber});
      if (res.response.statusCode == 200) {
        LoginModel model = LoginModel.fromJson(res.data);
        MKBStorageService.setUserIdentificationToken(
            model.data!.identificationToken.toString());

        print(
            "mannkibaat id = ${MKBStorageService.getUserIdentificationToken()}");
        emit(UserLoggedState(model));
      } else {
        LoginModel? model = LoginModel.fromJson(res.data);
        emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      LoginFaieldState(e.toString());
    }
  }

  Future submitOTP() async {
    try {
      emit(SubmitOtpLoadingState());
      var token = MKBStorageService.getUserIdentificationToken().toString();
      final res =
          await api.submitOtp({'identification_token': token, 'otp': AppStrings.mannkibaatotp});
      print(res.response.requestOptions.uri);

      print('res==+${res.response.data}');
      print('res==+${res.response.statusCode}');

      if (res.response.statusCode == 200) {
        userData = UserDetails.fromJson(res.data);
        if (userData!.data!.countryState.isEmpty == true) {
          print("list is empty isko new screen pe bhejo");
          MKBStorageService.setUserAuthToken(
              userData!.data!.authToken.toString());
          print(
              "user auth token from mann ki baat is ${MKBStorageService.getUserAuthToken()}");
          emit(NewUserState());
        } else {
          MKBStorageService.setUserAuthToken(
              userData!.data!.authToken.toString());
          print(
              "user auth token from mann ki baat is ${MKBStorageService.getUserAuthToken()}");
          emit(UserLoginSuccessfullyState(userData!));
        }
      } else {
        UserDetails? model = UserDetails.fromJson(res.data);
        Map<String, dynamic>? msg = res.data;
        print('msg-=$msg');

        emit(LoginFaieldState(msg?['message'] ?? ''));
      }
    } on Exception catch (e) {
      emit(LoginFaieldState(e.toString()));
      print('catch $e');
    }
  }

  Future addUser(String username) async {
    try {
      var token = MKBStorageService.getUserAuthToken().toString();
      final res = await api.addUser(token, {
        'user_name': username,
        'country_state_id': AppStrings.countrystateid,
        "ac_id": AppStrings.acid
      });
      print(res.response.requestOptions.uri);

      print('res==+${res.response.data}');
      print('res==+${res.response.statusCode}');

      if (res.response.statusCode == 200) {
        UserNewAddModel adduserdata = UserNewAddModel.fromJson(res.data);
        if (adduserdata.status == true) {
          print(
              "user auth token from mann ki baat is ${MKBStorageService.getUserAuthToken()}");
          emit(UserLoginSuccessfullyState(userData!));
        }
      } else {
        UserDetails? model = UserDetails.fromJson(res.data);
        Map<String, dynamic>? msg = res.data;
        print('msg-=$msg');

        emit(LoginFaieldState(msg?['message'] ?? ''));
      }
    } on Exception catch (e) {
      emit(LoginFaieldState(e.toString()));
      print('catch $e');
    }
  }
}
