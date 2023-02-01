import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../../Storage/user_storage_service.dart';
import '../../profile_screen/network/model/user_detail_model.dart';
import '../network/api/update_personal_details.dart';

part 'personal_info_state.dart';

enum Gender { male, female, transgender }


class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit() : super(PersonalInfoInitial());

  File? imageFile;
  String date = 'दिनांक';
  DateTime dateTime = DateTime.now();
  bool ischecked = false;
  bool isLoading = false;
  Gender value = Gender.male;
  UserDetailModel? updateData;
  final TextEditingController nameCtr = TextEditingController();
  final TextEditingController userNameCtr = TextEditingController();
  final TextEditingController mobileNumberCtr = TextEditingController();
  final TextEditingController boiCtr = TextEditingController();
  final TextEditingController religionCtr = TextEditingController();
  final TextEditingController statusCtr = TextEditingController();
  final TextEditingController castCtr = TextEditingController();

  final api = UpdatePersonalDetailsApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));



  emitState(){
    emit(PersonalInfoInitial());
  }

  updatePersonalDetails({required Map<String, dynamic> data}) async {
    emit(LoadingState());
    print("----------------------------");
    try {
      StorageService.getUserAuthToken();
      var res =
      await api.updatePersonalDetails('Bearer ${StorageService.userAuthToken}',data);
      print('sangathan Data =${res.response.statusCode}');
      print('sangathan Data =${StorageService.userAuthToken}');
      if (res.response.statusCode == 200) {
        print(res.response.data);
        UserDetailModel updateData = UserDetailModel.fromJson(res.response.data);
        emit(UpdateDataState(updateData));
      } else {
        print('error=${res.data['message']}');
        emit(PersonalInfoErrorState(res.data['message']));
      }
    } catch (e) {
      print(e);
      emit(PersonalInfoErrorState('Something Went Wrong'));
    }
  }


  Future<void> editBoi(BuildContext context) async {
    emit(PersonalInfoInitial());
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime) {
      dateTime = picked;
      date = ddMMMYYYYfromDateTime(dateTime);
      boiCtr.text = date;
      emit(DateOfBirth(date));
    }
  }

  changeValue(Gender v){
    value = v;
    emit(PersonalInfoInitial());
  }

  static String ddMMMYYYYfromDateTime(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<void> selectImage() async {
    emit(PersonalInfoInitial());
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      imageFile = imageTemp;
      print("Image Path : $imageFile");
    } catch (e) {
      print('Failed to pick image: $e');
    }
    emit(ImageSelectSuccess());
  }
}
