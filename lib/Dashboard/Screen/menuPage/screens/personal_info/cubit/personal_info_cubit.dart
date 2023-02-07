import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/personal_info/widgets/photo_selction_bottom_sheet_personal_info.dart';

import '../../../../../../AddEntry/network/model/cast_model.dart';
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
  UploadTask? task;
  String? urlDownload;
  XFile? image;
  int? religionId;
  int? gradeId;
  int? castId;
  CastModel? castData;
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

  Future getCasteDropDownValue({required String id}) async {
    try {
      emit(PersonalInfoInitial());
      final res =
      await api.getCast('Bearer ${StorageService.userAuthToken}', id);
      print('cast res =${res.response}');
      if (res.response.statusCode == 200) {
        CastModel data = CastModel.fromJson(res.data);
        castData = data;
        emit(FillCastValueState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(PersonalInfoErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      emit(PersonalInfoErrorState('Something Went Wrong'));
    }
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

  getNetworkUrlAndUpdateProfile({int? id}) async {
    EasyLoading.show();
    final imageTemp = File(image!.path);
    imageFile = imageTemp;
    final destination = '$id/${id}_userProfile';
    task = FirebaseApi.uploadFile(destination, imageFile!);
    final snapshot = await task!.whenComplete(() {
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Photo Uploaded",duration: const Duration(milliseconds: 500));
    });
    urlDownload = await snapshot.ref.getDownloadURL();
    print('Image Download-Link: $urlDownload');
    updatePersonalDetails(data: {
      "name": nameCtr.text,
      "username": userNameCtr.text,
      "phone_number": mobileNumberCtr.text,
      "dob": boiCtr.text,
      "gender": value.name,
      "avatar": urlDownload,
      "religion_id": religionId,
      "cast_id": castId,
      "category_id": gradeId
    });
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

  Future<void> selectImage({BuildContext? context}) async {
    emit(PersonalInfoInitial());
    await selectOption(context: context!);
    emit(ImageSelectSuccess());
  }
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException {
      return null;
    }
  }
}
