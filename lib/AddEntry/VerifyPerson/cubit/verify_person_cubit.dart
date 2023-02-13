import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sangathan/AddEntry/VerifyPerson/cubit/verify_person_state.dart';

import '../../../Storage/user_storage_service.dart';
import '../network/api/verify_person_api.dart';

class VerifyPersonCubit extends Cubit<VerifyPersonState> {
  VerifyPersonCubit() : super(VerifyPersonInitialState());

  TextEditingController otpFieldController = TextEditingController();

  Timer? timer;
  int count = 60;
  String otpText = '';
  final api = VerifyPersonApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future<void> startTimer() async {
    emit(TimerLoadingState());
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (count != 0) {
        emit(TimerLoadingState());
        emit(TimerRunningState(count--));
      } else {
        timer?.cancel();
        emit(TimerStopState());
      }
    });
  }

  Future sendOTP({required int personId}) async {
    emit(SendOTPLoadingState());
    try {
      EasyLoading.show();
      final res =
          await api.sendOTP('${StorageService.userAuthToken}', personId);
      if (res.response.statusCode == 200) {
        Map<String, dynamic>? msg = res.data;
        emit(SendOTPSuccessful(msg?['message'] ?? ''));
        print(
            "------------------------------------ Send OTP ----------------------------");
        print("personId:$personId");

        print("Status code : ${res.response.statusCode}");
        print("Response :${res.data}");
        print("token : ${StorageService.userAuthToken}");
        print(
            "------------------------------------ ------------------------ ----------------------------");
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(SendOTPErrorState(msg?['message'] ?? ''));
      }
    } catch (e) {
      print(e.toString());
      emit(SendOTPErrorState("Something went wrong!"));
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future reSendOTP({required int personId}) async {
    emit(ResendOTPLoadingState());
    try {
      EasyLoading.show();
      final res = await api.reSendOTP(
          '${StorageService.userAuthToken}', personId);
      if (res.response.statusCode == 200) {
        Map<String, dynamic>? msg = res.data;
        emit(ResendOTPSuccessState(msg?['message'] ?? ''));
        print(
            "------------------------------------ ReSend OTP ----------------------------");
        print("personId:$personId");

        print("Status code : ${res.response.statusCode}");
        print("Response :${res.data}");
        print("token : ${StorageService.userAuthToken}");
        print(
            "------------------------------------ ------------------------ ----------------------------");
      } else {
        print("personId:$personId");
        print("Status code : ${res.response.statusCode}");

        Map<String, dynamic>? msg = res.data;
        emit(ResendOTPErrorState(msg?['message'] ?? ''));
      }
    } catch (e) {
      print(e.toString());
      emit(ResendOTPErrorState("Something went wrong!"));
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future verifyOTP({required int personId, required String otp}) async {
    emit(VeifyOTPLoadingState());

    try {
      EasyLoading.show();
      final res = await api.verifyOTP('${StorageService.userAuthToken}',
          {'person_id': personId, 'otp': otp});
      if (res.response.statusCode == 200) {
        Map<String, dynamic>? msg = res.data;
        emit(VeifyOTPSuccessState(msg?['message'] ?? ''));
        print(
            "------------------------------------ Verify OTP ----------------------------");
        print("personId:$personId");

        print("Status code : ${res.response.statusCode}");
        print("Response :${res.data}");
        print("token : ${StorageService.userAuthToken}");
        print(
            "------------------------------------ ------------------------ ----------------------------");
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(VeifyOTPErrorState(msg?['message'] ?? ''));
      }
    } catch (e) {
      print(e.toString());
      emit(VeifyOTPErrorState("Something went wrong!"));
    } finally {
      EasyLoading.dismiss();
    }
  }
}
