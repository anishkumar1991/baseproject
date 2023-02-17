import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../../../Storage/user_storage_service.dart';
import '../../../../../menuPage/screens/personal_info/cubit/personal_info_cubit.dart';
import '../../pravas_create/network/model/create_pravas_and_function_model.dart';
import '../network/api/create_function_api.dart';
import '../network/model/program_comman_dropdown_model.dart';
import '../network/model/program_type_model.dart';

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
  final TextEditingController pickedDateText = TextEditingController();
  final TextEditingController pickedTimeText = TextEditingController();
  String? date;
  String? time;
  DateTime dateTime = DateTime.now();
  TimeOfDay pickedTime = TimeOfDay.now();
  List<ProgramDropdownModel> programTypeList = [];
  List<ProgramDropdownModel> programLevelList = [];
  ProgramDropdownModel? selectedProgramType;
  ProgramDropdownModel? selectedProgramLevel;
  File? imageFile1;
  File? imageFile2;
  UploadTask? task;
  String? urlDownload1;
  String? urlDownload2;
  CreatePravasAndFunctionModel createPravasAndFunctionModel =
      CreatePravasAndFunctionModel();

  final api = CreateFunction(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  emitState() {
    emit(CreateFunctionInitial());
  }

  setFunctionType({required ProgramDropdownModel typeName}) {
    emit(CreateFunctionInitial());
    functionTypeText.text = typeName.name ?? "";
    selectedProgramType = typeName;
    emit(FunctionTypeChangeSuccess());
  }

  setFunctionLevel({required ProgramDropdownModel typeName}) {
    emit(CreateFunctionInitial());
    functionLevelText.text = typeName.name ?? "";
    selectedProgramType = typeName;
    emit(FunctionLevelChangeSuccess());
  }

  Future functionCreate(
      {required String name,
      required String date,
      required String time,
      required String location,
      required String place,
      required String subject,
      required String summary,
      required int pravasId,
      required int levelId}) async {
    emit(CreateFunctionLoadingState());
    try {
      String token = StorageService.getUserAuthToken() ?? "";
      final res = await api.functionCreate(token, name, date, time, location,
          place, subject, summary, pravasId.toString(), levelId.toString());
      print(
          "------------------------------------ Create Function data  ----------------------------");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print("Pass Data:${res.response.extra}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        CreatePravasAndFunctionModel data =
            CreatePravasAndFunctionModel.fromJson(res.data);
        emit(CreateFunctionFatchDataState(data: data));
      } else {
        print('error=${res.data['message']}');
        emit(CreateFunctionErrorState(error: res.data['message']));
      }
    } catch (e) {
      print(e);
      emit(CreateFunctionErrorState(error: 'Something Went Wrong'));
    }
  }

  /// Get program Type
  Future programType() async {
    emit(GetProgramTypeLoadingState());
    try {
      String token = StorageService.getUserAuthToken() ?? "";
      final res = await api.programType(token);
      print(
          "------------------------------------program type data  ----------------------------");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print("Pass Data:${res.response.extra}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        ProgramTypeModel data = ProgramTypeModel.fromJson(res.data);
        emit(GetProgramTypeSuccessState(data));
      } else {
        print('error=${res.data}');
        emit(GetProgramTypeErrorState('Something Went Wrong'));
      }
    } catch (e) {
      print(e);
      emit(GetProgramTypeErrorState('Something Went Wrong'));
    }
  }

  /// get Program Level
  Future getProgramLevel() async {
    emit(GetProgramLevelLoadingState());
    try {
      String token = StorageService.getUserAuthToken() ?? "";
      final res = await api.programLevel(token);
      print(
          "------------------------------------program Level data  ----------------------------");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print("Pass Data:${res.response.extra}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        ProgramTypeModel data = ProgramTypeModel.fromJson(res.data);
        emit(GetProgramLevelSuccessState(data));
      } else {
        print('error=${res.data}');
        emit(GetProgramLevelTypeErrorState('Something Went Wrong'));
      }
    } catch (e) {
      print(e);
      emit(GetProgramLevelTypeErrorState('Something Went Wrong'));
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
      EasyLoading.showSuccess("Photo Uploaded",
          duration: const Duration(milliseconds: 500));
    });
    urlDownload1 = await snapshot.ref.getDownloadURL();
    print('Image Download-Link 1: $urlDownload1');
  }

  static String ddMMMYYYYfromDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String hhMMFormate(DateTime date) {
    return DateFormat('hh:mm').format(date);
  }

  Future<void> editDate(BuildContext context) async {
    emit(CreateFunctionInitial());
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime) {
      dateTime = picked;
      date = ddMMMYYYYfromDateTime(dateTime);
      if (date != null) {
        pickedDateText.text = date ?? "";
      }
    }
    emit(FunctionPlaceSelectSuccess());
  }

  Future<void> editTime(BuildContext context) async {
    emit(CreateFunctionInitial());
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: pickedTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? Container(),
        );
      },
    );
    if (newTime != null) {
      pickedTime = newTime;
      Future.delayed(Duration.zero).then((value) {
        time = pickedTime.format(context);
        if (time != null) {
          pickedTimeText.text = time ?? "";
        }
      });
    }
    emit(FunctionPlaceSelectSuccess());
  }

  cleanAllVariableValue() {
    functionNameText.clear();

    functionDateTimeText.clear();
    functionTypeText.clear();
    functionLevelText.clear();
    lokSabhaText.clear();
    placeText.clear();
    subjectText.clear();
    commentText.clear();
    pickedDateText.clear();
    pickedTimeText.clear();
    date = null;
    time = null;

    programTypeList = [];
    programLevelList = [];
    selectedProgramType = null;
    selectedProgramLevel = null;
    imageFile1 = null;
    imageFile2 = null;
    task = null;
    urlDownload1 = null;
    urlDownload2 = null;
    createPravasAndFunctionModel = CreatePravasAndFunctionModel();
  }
}
