// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sangathan/AddEntry/network/model/cast_model.dart';
import 'package:sangathan/AddEntry/network/model/category_model.dart';
import 'package:sangathan/AddEntry/network/model/designation_data_model.dart';
import 'package:sangathan/storage/user_storage_service.dart';

import '../network/api/add_entry_api.dart';
import '../network/model/add_entry_form_structure_model.dart';
import 'add_entry_state.dart';

class AddEntryCubit extends Cubit<AddEntryState> {
  AddEntryCubit() : super(AddEntryInitialState());

  DateTime dateTime = DateTime.now();
  String date = 'Select DOB of Birth';
  String? selectRadio;
  File? file;
  File? rationFilePicked;
  File? adharFilePicked;
  File? voterFilePicked;

  List multiSelectionList = [];
  List<DataEntryField>? entryField = [];

  List<DropdownData> categoryData = [];
  List<CastData> castData = [];
  List<DropdownData> qualificationData = [];
  List<DropdownData> professionData = [];
  List<DropdownData> nativeStateData = [];
  List<DropdownData> religionData = [];

  List<DesignationData> designationData = [];

  List<Widget> addEntryFormPrimary = [];
  List<Widget> addEntryFormSecondary = [];

  CastData? castSelected;
  DropdownData? categorySelected;
  DropdownData? qualificationSelected;
  DropdownData? professionSelected;
  DropdownData? nativeStateSelected;
  DropdownData? religionSelected;
  DesignationData? designationSelected;
  String? profileImageUrl;
  DesignationData? selectedDesignationData;

  ///  all field
  List<Map<String, dynamic>> allDropdownValueList = [];
  List<Map<String, dynamic>> allImagePickerList = [];
  List<Map<String, dynamic>> textFieldControllerData = [];
  List<Map<String, dynamic>> allMultiFieldData = [];
  List<Map<String, dynamic>> allDatePicker = [];

  Map<String, dynamic> finalAllDataList = {};
  final api = AddEntryApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  void onTapRadioButton(String value) {
    emit(AddEntryLoadingState());
    selectRadio = value;
    emit(RadioButtonSelectState());
  }

  static String ddMMMYYYYfromDateTime(DateTime date) {
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  /// here make final value map with key

  makeFinalList() {
    Map<String, dynamic> data = {};

    /// For dropdowns
    if (allDropdownValueList.isNotEmpty) {
      for (var item in allDropdownValueList) {
        data.addEntries({"${item["fieldName"]}": "${item["value"]}"}.entries);
      }
    }

    /// for text field
    if (textFieldControllerData.isNotEmpty) {
      for (var item in textFieldControllerData) {
        data.addEntries({"${item["fieldName"]}": "${item["value"]}"}.entries);
      }
    }

    /// for file picker
    if (allImagePickerList.isNotEmpty) {
      for (var item in allImagePickerList) {
        data.addEntries({"${item["fieldName"]}": "${item["value"]}"}.entries);
      }
    }

    /// for check box
    if (allMultiFieldData.isNotEmpty) {
      for (var item in allMultiFieldData) {
        data.addEntries({"${item["fieldName"]}": "${item["value"]}"}.entries);
      }
    }

    /// for user profile image
    if (file?.path != null) {
      data.addEntries({"photo": "${file?.path}"}.entries);
    }

    /// for user gender
    if (selectRadio != null) {
      data.addEntries({"gender": "$selectRadio"}.entries);
    }

    /// for DOB

    if (date != 'Select DOB of Birth' && date != null && date != '') {
      data.addEntries({"dob": date}.entries);
    }

    finalAllDataList = data;
    print(finalAllDataList);
  }

  /// getting all multi check value

  getAllMultiCheckData(String type, dynamic value) {
    emit(AddEntryLoadingState());
    int index =
        allMultiFieldData.indexWhere((element) => element["fieldName"] == type);
    if (index >= 0) {
      allMultiFieldData.removeAt(index);
    } else {
      Map<String, dynamic> json = {
        "fieldName": type,
        "value": value,
      };
      allMultiFieldData.add(json);
    }
    emit(MultiCheckSelectionState());
  }

  /// getting all dropdown value
  getAllDropDownData(dynamic value, String dropdownType) {
    int index = allDropdownValueList
        .indexWhere((element) => element["fieldName"] == dropdownType);
    if (index >= 0) {
      allDropdownValueList[index]["value"] = value.name;
    } else {
      Map<String, dynamic> json = {
        "fieldName": dropdownType,
        "value": value.name,
      };
      allDropdownValueList.add(json);
    }
  }

  /// here change dropdown value based on selection
  changeDropdownValue(dynamic value, String dropdownType) {
    emit(AddEntryLoadingState());
    if (dropdownType == "designation") {
      designationSelected = value;
      getAllDropDownData(value, dropdownType);
    } else if (dropdownType == "category") {
      categorySelected = value;
      getAllDropDownData(value, dropdownType);
      getCastData(id: categorySelected!.id.toString());
    } else if (dropdownType == "caste") {
      castSelected = value;
      getAllDropDownData(value, dropdownType);
    } else if (dropdownType == "qualification") {
      qualificationSelected = value;
      getAllDropDownData(value, dropdownType);
    } else if (dropdownType == "religion") {
      religionSelected = value;
      getAllDropDownData(value, dropdownType);
    } else if (dropdownType == "profession") {
      professionSelected = value;
      getAllDropDownData(value, dropdownType);
    } else {}
    emit(DropDownSelectedState());
  }

  Future<void> selectedDoaDate(BuildContext context) async {
    emit(AddEntryLoadingState());
    final DateTime? picked = await showDatePicker(
        locale: const Locale.fromSubtags(languageCode: 'en'),
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime) {
      dateTime = picked;
      date = ddMMMYYYYfromDateTime(dateTime);
      emit(DobSelectedState(date));
    }
  }

  Future<void> pickImage(ImageSource source) async {
    emit(AddEntryLoadingState());
    PickedFile? pickedFile =
        await ImagePicker.platform.pickImage(source: source);
    if (pickedFile != null) {
      file = File(pickedFile.path);

      /* if (file != null) {
        await storeImage(folderName: 'profileImages', path: file!.path);
      }*/
      //  if (file != null) {
      //     await storeImage(
      //         folderName: 'profileImages',
      //         path: file!.path,
      //         recievedUrl: profileImageUrl);
      //   }

      emit(ImagePickedState());
    }
  }

  Future<void> storeImage(
      {required String folderName,
      required String path,
      String? recievedUrl}) async {
    int time = DateTime.now().millisecondsSinceEpoch;
    Reference ref =
        FirebaseStorage.instance.ref(folderName).child(time.toString());
    await ref.putFile(File(path));
    recievedUrl = await ref.getDownloadURL();
    //print('ImageUrl==$profileImageUrl');
  }

  Future<void> pickFile(String fieldType) async {
    emit(AddEntryLoadingState());
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      /*if (isAdhar) {
        adharFilePicked = File(result.files.single.path!);
        await storeImage(
            folderName: 'adharFile',
            path: adharFilePicked!.path,
            recievedUrl: adharUrl);
      } else if (isVoter) {
        voterFilePicked = File(result.files.single.path!);
        await storeImage(
            folderName: 'voterFile',
            path: voterFilePicked!.path,
            recievedUrl: voterUrl);
      } else if (isRation) {
        rationFilePicked = File(result.files.single.path!);
        await storeImage(

            folderName: 'rationFile', path: rationFilePicked!.path);
      }*/

      int index = allImagePickerList
          .indexWhere((element) => element["fieldName"] == fieldType);
      if (index >= 0) {
        allImagePickerList[index]["value"] = result.files.single.path!;
      } else {
        Map<String, dynamic> json = {
          "fieldName": fieldType,
          "value": result.files.single.path!,
        };
        allImagePickerList.add(json);
      }
    }
    emit(FilePickedState());
  }

  Future<void> requestPermission(ImageSource source) async {
    await Permission.storage.request();
    if (await Permission.storage.request().isDenied) {
      await Permission.storage.request();
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      openAppSettings();
    } else if (await Permission.storage.request().isGranted) {
      await pickImage(source);
    }
  }

  Future getDropdownData() async {
    try {
      emit(AddEntryLoadingState());
      final res = await api.getDropdownValues(
        'Bearer ${StorageService.userAuthToken}',
      );
      print('dropdown res =${res.response}');
      if (res.response.statusCode == 200) {
        DropdownValueModel data = DropdownValueModel.fromJson(res.data);
        emit(DropDownValueFetchedState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(AddEntryErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      emit(AddEntryErrorState('Something Went Wrong'));
    }
  }

  Future getCastData({required String id}) async {
    try {
      emit(AddEntryLoadingState());
      final res =
          await api.getCast('Bearer ${StorageService.userAuthToken}', id);
      print('cast res =${res.response}');
      if (res.response.statusCode == 200) {
        CastModel data = CastModel.fromJson(res.data);
        emit(CastFetchedState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(AddEntryErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      emit(AddEntryErrorState('Something Went Wrong'));
    }
  }

  Future getAddEntryFormStructure({required String levelID}) async {
    emit(GetAddEntryFormStructureLoadingState());
    if (state is GetAddEntryFormStructureLoadingState) {
      try {
        final res = await api.getAddEntryFormStructure(
            'Bearer ${StorageService.userAuthToken}', levelID);
        if (res.response.statusCode == 200) {
          AddEntryFormStructure addEntryFormStructure =
              AddEntryFormStructure.fromJson(res.data);
          emit(GetAddEntryFormStructureSuccessState(addEntryFormStructure));
          print(
              "------------------------------------ Add entry form structure ----------------------------");
          print("level id :$levelID");
          print("Status code : ${res.response.statusCode}");
          print("Response :${res.data}");
          print(
              "------------------------------------ ------------------------ ----------------------------");
        } else {
          Map<String, dynamic>? msg = res.data;
          emit(GetAddEntryFormStructureFailedState(msg?['errors'] ?? ''));
        }
      } catch (e) {
        print(e.toString());
        emit(GetAddEntryFormStructureFailedState("Something went wrong!"));
      }
    }
  }

  Future getDesignationDropdown({required Map<String, dynamic> data}) async {
    try {
      emit(DesignationDropDownLoadingState());
      final res = await api.getDesignation(
          'Bearer ${StorageService.userAuthToken}', data);
      print(
          "------------------------------------ Designation ----------------------------");
      print("data  :$data");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        DesignationDataModel data = DesignationDataModel.fromJson(res.data);
        emit(DesignationDropDownSuccessState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(DesignationDropDownFailedState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      emit(DesignationDropDownFailedState('Something Went Wrong'));
    }
  }

  disposePage() {
    emit(DisposeState());
  }

  void onChangeDesignationDropDown(DesignationData designationData) {
    emit(AddEntryLoadingState());
    selectedDesignationData = designationData;
    emit(FilterDataSelectedState());
  }

  Timer? timer;
  int count = 30;

  Future<void> startTimer() async {
    emit(TimerLoadingState());
    if (count == 0) {
      emit(TimerStopState());
    } else {
      await Future.delayed(const Duration(seconds: 1));
      count--;
      emit(TimerRunningState(count));
      startTimer();
    }
  }

  getFieldName(String fieldName) {
    String name = '';

    for (int i = 0; i < entryField!.length; i++) {
      if (entryField![i].formControlName == fieldName) {
        name = entryField![i].displayNameForUI ?? fieldName;
      }
    }
    return name;
  }
}
