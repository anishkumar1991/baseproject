import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sangathan/Values/string.dart';

import '../../../../../../../Storage/user_storage_service.dart';
import '../../../../../menuPage/screens/personal_info/cubit/personal_info_cubit.dart';
import '../../pravas_create/network/model/create_pravas_and_function_model.dart';
import '../network/api/create_function_api.dart';

part 'create_function_state.dart';

class CreateFunctionCubit extends Cubit<CreateFunctionState> {
  CreateFunctionCubit() : super(CreateFunctionInitial());

  final TextEditingController functionNameText = TextEditingController();
  final TextEditingController functionDateTimeText = TextEditingController();
  final TextEditingController functionTypeText = TextEditingController();
  final TextEditingController functionLevelText = TextEditingController();
  final TextEditingController lokSabhaText = TextEditingController();
  final TextEditingController placeText = TextEditingController();
  final TextEditingController subjectText = TextEditingController();
  final TextEditingController commentText = TextEditingController();

  File? imageFile1;
  File? imageFile2;
  UploadTask? task;
  String? urlDownload1;
  String? urlDownload2;
  CreatePravasAndFunctionModel createPravasAndFunctionModel = CreatePravasAndFunctionModel();

  final api = CreateFunction(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  emitState(){
    emit(CreateFunctionInitial());
  }

  setFunctionType({required String typeName}) {
    emit(CreateFunctionInitial());
    functionTypeText.text = typeName;
    emit(FunctionTypeChangeSuccess());
  }

  setFunctionLevel({required String typeName}) {
    emit(CreateFunctionInitial());
    functionLevelText.text = typeName;
    emit(FunctionLevelChangeSuccess());
  }
  Future FunctionCreate({required Map<String, dynamic> data}) async {
    emit(CreateFunctionLoadingState());
    try {
      StorageService.getUserAuthToken();
      final res = await api.FunctionCreate(AppStrings.apiKey,AppStrings.pravasUserToken,data);
      print(
          "------------------------------------ Create Function data  ----------------------------");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        CreatePravasAndFunctionModel data = CreatePravasAndFunctionModel.fromJson(res.data);
        emit(CreateFunctionFatchDataState(data: data));
      } else {
        print('error=${res.data['message']}');
        emit(CreateFunctionErrorState(error: res.data['message']));
      }
    }  catch (e) {
      print(e);
      emit(CreateFunctionErrorState(error: 'Something Went Wrong'));
    }
  }


  Future<void> selectImage1() async {
    emit(CreateFunctionInitial());
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      imageFile1 = imageTemp;
      print("Image Path : $imageFile1");
    } catch (e) {
      print('Failed to pick image: $e');
    }
    emit(Image1SelectSuccess());
  }

  Future<void> selectImage2() async {
    emit(CreateFunctionInitial());
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      imageFile2 = imageTemp;
      print("Image Path : $imageFile2");
    } catch (e) {
      print('Failed to pick image: $e');
    }
    emit(Image2SelectSuccess());
  }

  setFunctionPlace({required List selectedPlace}) {
    emit(CreateFunctionInitial());
    String selectedPlaceString = selectedPlace.join(',');
    placeText.text = selectedPlaceString;
    emit(FunctionPlaceSelectSuccess());
  }

  uploadImageFile() async {
    final imageTemp = File(imageFile1!.path);
    imageFile1 = imageTemp;
    const destination = '1/1_userProfile';
    task = FirebaseApi.uploadFile(destination, imageFile1!);
    final snapshot = await task!.whenComplete(() {
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Photo Uploaded",duration: const Duration(milliseconds: 500));
    });
    urlDownload1 = await snapshot.ref.getDownloadURL();
    print('Image Download-Link 1: $urlDownload1');
  }
}
