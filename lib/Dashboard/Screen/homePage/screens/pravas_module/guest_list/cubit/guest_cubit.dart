import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../Storage/user_storage_service.dart';
import '../../../../../../../Values/string.dart';
import '../../pravas_create/network/model/create_pravas_and_function_model.dart';
import '../network/api/create_guest_api.dart';
import '../network/model/guest_model.dart';

part 'guest_state.dart';

class GuestCubit extends Cubit<GuestState> {
  GuestCubit() : super(GuestInitial());

  TextEditingController nameCtr = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController position = TextEditingController();
  CreatePravasAndFunctionModel createPravasAndFunctionModel = CreatePravasAndFunctionModel();
  GuestList guestList = GuestList();
    final FocusNode nameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode positionFocusNode = FocusNode();

  bool isEdit = false;
  int? attendeesIdForEdit;

  final api = CreateGuest(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future GuestCreate({required Map<String, dynamic> data}) async {
    emit(CreateGuestLoadingState());
    try {
      StorageService.getUserAuthToken();
      final res = await api.GuestCreate(AppStrings.apiKey,AppStrings.pravasUserToken,data);
      print(
          "------------------------------------ Create Guest data  ----------------------------");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        CreatePravasAndFunctionModel data = CreatePravasAndFunctionModel.fromJson(res.data);
        emit(CreateGuestFatchDataState(data: data));
      } else {
        print('error=${res.data['message']}');
        emit(CreateGuestErrorState(error: res.data['message']));
      }
    }  catch (e) {
      print(e);
      emit(CreateGuestErrorState(error: 'Something Went Wrong'));
    }
  }

  Future GuestUpdate({required Map<String, dynamic> data}) async {
    emit(UpdateGuestLoadingState());
    attendeesIdForEdit = null;
    nameCtr.clear();
    phoneNumber.clear();
    position.clear();
    try {
      StorageService.getUserAuthToken();
      final res = await api.GuestUpdate(AppStrings.apiKey,AppStrings.pravasUserToken,data);
      print(
          "------------------------------------ Update Guest data  ----------------------------");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        CreatePravasAndFunctionModel data = CreatePravasAndFunctionModel.fromJson(res.data);
        emit(UpdateGuestFatchDataState(data: data));
      } else {
        print('error=${res.data['message']}');
        emit(UpdateGuestErrorState(error: res.data['message']));
      }
    }  catch (e) {
      print(e);
      emit(UpdateGuestErrorState(error: 'Something Went Wrong'));
    }
  }

  editGuest({int? attendeesId,String? designation,int? phone,String? name}){
    if(isEdit){
      attendeesIdForEdit = null;
      nameCtr.clear();
      phoneNumber.clear();
      position.clear();
    }else{
      attendeesIdForEdit = attendeesId;
      nameCtr.text = name ?? '';
      phoneNumber.text = phone.toString();
      position.text = designation ?? '';
    }
    emit(EditAttendeesLoadingState());
  }

  Future GetGuestList() async {
    emit(GetGuestLoadingState());
    try {
      StorageService.getUserAuthToken();
      final res = await api.getGuest(AppStrings.apiKey);
      print(
          "------------------------------------ Get Guest data  ----------------------------");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        GuestList data = GuestList.fromJson(res.data);
        emit(GetGuestFatchDataState(data: data));
      } else {
        print('error=${res.data['message']}');
        emit(GetGuestErrorState(error: res.data['message']));
      }
    }  catch (e) {
      print(e);
      emit(GetGuestErrorState(error: 'Something Went Wrong'));
    }
  }

}
