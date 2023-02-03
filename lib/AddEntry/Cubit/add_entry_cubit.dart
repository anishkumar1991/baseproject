// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sangathan/AddEntry/network/model/cast_model.dart';
import 'package:sangathan/AddEntry/network/model/category_model.dart';
import 'package:sangathan/AddEntry/network/model/designation_data_model.dart';

import '../../Dashboard/Screen/menuPage/screens/personal_info/cubit/personal_info_cubit.dart';
import '../../Storage/user_storage_service.dart';
import '../dynamic_ui_handler/dynamic_ui_handler.dart';
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
  String? initialUserprofileURL;
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

  ///   API required parameter
  int? type;
  int? levelId;
  int? unitId;
  String? subUnitId;
  int? levelName;
  int? personID;
  String? from;
  Map<String, dynamic> finalAllDataList = {};
  final api = AddEntryApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  /// gender radio button on tap method
  void onTapRadioButton(String value) {
    emit(AddEntryLoadingState());
    selectRadio = value;
    emit(RadioButtonSelectState());
  }

  /// Date picker date formatter
  static String ddMMMYYYYfromDateTime(DateTime date) {
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  /// here make final value map with key

  previewAndSubmitList() {
    Map<String, dynamic> data = {};

    /// For dropdowns
    if (allDropdownValueList.isNotEmpty) {
      for (var item in allDropdownValueList) {
        /*  for (DataEntryField field in entryField ?? []) {
          if (field.fieldName == "${item["fieldName"]}") {*/
        data.addEntries({"${item["fieldName"]}": "${item["value"]}"}.entries);
        /* }
        }*/
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
    } else if (initialUserprofileURL != null) {
      data.addEntries({"photo": "$initialUserprofileURL"}.entries);
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
    log(finalAllDataList.toString());
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
        "value": value == true ? "Yes" : "No",
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
      allDropdownValueList[index]["value"] = value.id;
    } else {
      Map<String, dynamic> json = {
        "fieldName": dropdownType,
        "value": value.id,
      };
      allDropdownValueList.add(json);
    }
  }

  /// here change dropdown value based on selection
  changeDropdownValue(dynamic value, String dropdownType) {
    log(dropdownType);
    /* emit(AddEntryLoadingState());*/
    if (dropdownType == "designation") {
      designationSelected = value;

      getAllDropDownData(value, dropdownType);
    } else if (dropdownType == "categoryId") {
      categorySelected = value;
      getAllDropDownData(value, dropdownType);

      getCastData(id: categorySelected!.id.toString());
    } else if (dropdownType == "caste") {
      castSelected = value;
      getAllDropDownData(value, dropdownType);
    } else if (dropdownType == "educationId") {
      qualificationSelected = value;

      getAllDropDownData(value, dropdownType);
    } else if (dropdownType == "religionId") {
      religionSelected = value;

      getAllDropDownData(value, dropdownType);
    } else if (dropdownType == "professionId") {
      professionSelected = value;

      getAllDropDownData(value, dropdownType);
    } else {}
    /*  emit(DropDownSelectedState());*/
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

  /// This method for user photo picker
  Future<void> pickImage(ImageSource source) async {
    emit(AddEntryLoadingState());
    PickedFile? pickedFile =
        await ImagePicker.platform.pickImage(source: source);
    if (pickedFile != null) {
      initialUserprofileURL = null;
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

  /// File picker method(aadhaar,voter and ration)
  Future<void> pickFile(String fieldType) async {
    emit(AddEntryLoadingState());
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
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
    print(allImagePickerList);
    emit(FilePickedState());
  }

  /// permission handler for image picker
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

  /// Dropdown API call Method
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

  /// caste api call when select category
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

  /// Add entry form structure API method

  Future getAddEntryFormStructure(
      {required String levelID, int? countryId}) async {
    emit(GetAddEntryFormStructureLoadingState());
    if (state is GetAddEntryFormStructureLoadingState) {
      try {
        final res = await api.getAddEntryFormStructure(
            'Bearer ${StorageService.userAuthToken}', levelID, countryId);
        if (res.response.statusCode == 200) {
          AddEntryFormStructure addEntryFormStructure =
              AddEntryFormStructure.fromJson(res.data);
          emit(GetAddEntryFormStructureSuccessState(addEntryFormStructure));
          print(
              "------------------------------------ Add entry form structure ----------------------------");
          print("level id :$levelID");
          print("countryStateId = $countryId");
          print("countryStateId = ${res.response.realUri.queryParameters}");
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

  ///Designation dropdown API methods
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

  /// the method call when user leave all add entry page
  cleanAllVariableData() {
    multiSelectionList = [];
    entryField = [];
    date = 'Select DOB of Birth';
    categoryData = [];
    selectRadio = null;
    castData = [];
    qualificationData = [];
    professionData = [];
    nativeStateData = [];
    religionData = [];

    designationData = [];

    addEntryFormPrimary = [];
    addEntryFormSecondary = [];

    castSelected = null;
    categorySelected = null;
    qualificationSelected = null;
    professionSelected = null;
    nativeStateSelected = null;
    religionSelected = null;
    designationSelected = null;
    profileImageUrl = null;
    selectedDesignationData = null;
    initialUserprofileURL = null;
    file = null;

    ///  all field
    allDropdownValueList = [];
    allImagePickerList = [];
    textFieldControllerData = [];
    allMultiFieldData = [];
    allDatePicker = [];

    ///

    type = null;
    levelId = null;
    unitId = null;
    from = null;
    subUnitId = null;
    levelName = null;
    personID = null;
    emit(DisposeState());
  }

  /// Get initial dropdown Data

  getInitialDropdownData(Map<String, dynamic>? personData) async {
    if (personData != null) {
      for (var item in personData.entries) {
        if (item.key == "designation") {
          if (item.value != null || item.value != "") {
            int index = designationData
                .indexWhere((element) => element.id == item.value);
            if (index >= 0) {
              designationSelected = designationData[index];
              getAllDropDownData(designationData[index], item.key);
            }
          }
        } else if (item.key == "categoryId") {
          if (item.value != null || item.value != "") {
            int index =
                categoryData.indexWhere((element) => element.id == item.value);
            if (index >= 0) {
              categorySelected = categoryData[index];
              getAllDropDownData(categoryData[index], item.key);
              await getCastData(id: categorySelected!.id.toString());
            }
          }
        } else if (item.key == "caste") {
          if (item.value != null || item.value != "") {
            int index =
                castData.indexWhere((element) => element.id == item.value);
            if (index >= 0) {
              castSelected = castData[index];
              getAllDropDownData(castData[index], item.key);
            }
          }
        } else if (item.key == "educationId") {
          if (item.value != null || item.value != "") {
            int index = qualificationData
                .indexWhere((element) => element.id == item.value);
            if (index >= 0) {
              qualificationSelected = qualificationData[index];
              getAllDropDownData(qualificationData[index], item.key);
            }
          }
        } else if (item.key == "religionId") {
          if (item.value != null || item.value != "") {
            int index =
                religionData.indexWhere((element) => element.id == item.value);
            if (index >= 0) {
              religionSelected = religionData[index];
              getAllDropDownData(religionData[index], item.key);
            }
          }
        } else if (item.key == "professionId") {
          if (item.value != null || item.value != "") {
            int index = professionData
                .indexWhere((element) => element.id == item.value);
            if (index >= 0) {
              professionSelected = professionData[index];
              getAllDropDownData(professionData[index], item.key);
            }
          }
        }
      }
      //emit(DropDownSelectedState());
    }
  }

  /// Get initial caste Data
  getInitialCasteData(Map<String, dynamic>? personData) {
    print(castData);
    if (personData != null) {
      for (var item in personData.entries) {
        print(item.key);
        if (item.key == "caste") {
          if (castData.isNotEmpty && castData != null) {
            if (item.value != null || item.value != "") {
              int index =
                  castData.indexWhere((element) => element.id == item.value);
              if (index >= 0) {
                castSelected = castData[index];
                getAllDropDownData(castData[index], item.key);
                print(castSelected?.toJson());
              }
            }
          }
        }
      }
    }
    emit(DropDownSelectedState());
  }

  /// Get initial Textfield Data

  getInitialTextfieldData(Map<String, dynamic>? personData) {
    if (personData != null && entryField != null) {
      for (var item in personData.entries) {
        if (DynamicUIHandler.textfield.contains(item.key)) {
          int index = textFieldControllerData
              .indexWhere((element) => element["fieldName"] == item.key);
          if (index >= 0) {
            if (item.value != null && item.value != "") {
              textFieldControllerData[index]["value"] = item.value;
            }
          } else {
            if (item.value != null && item.value != "") {
              Map<String, dynamic> json = {
                "fieldName": item.key,
                "value": item.value,
              };
              textFieldControllerData.add(json);
            }
          }
        }
      }
    }
  }

  /// Get initial gender data
  getInitialGenderData(Map<String, dynamic>? personData) {
    if (personData != null && entryField != null) {
      for (var item in personData.entries) {
        if (DynamicUIHandler.radioButton.contains(item.key)) {
          if (item.value != null && item.value != "") {
            selectRadio = item.value;
          }
        }
      }
    }
  }

  /// Get initial gender data

  getInitialMultiSelectionFieldData(Map<String, dynamic>? personData) {
    if (personData != null && entryField != null) {
      for (var item in personData.entries) {
        if (DynamicUIHandler.multiSelectionField.contains(item.key)) {
          int index = allMultiFieldData
              .indexWhere((element) => element["fieldName"] == item.key);
          if (index >= 0) {
            if (item.value != null && item.value != "") {
              allMultiFieldData[index]["value"] = item.value;
            }
          } else {
            if (item.value != null && item.value != "") {
              Map<String, dynamic> json = {
                "fieldName": item.key,
                "value": item.value,
              };
              allMultiFieldData.add(json);
            }
          }
        }
      }
    }
  }

  /// Get initial photo
  getInitialUserprofileImageData(Map<String, dynamic>? personData) {
    if (personData != null && entryField != null) {
      for (var item in personData.entries) {
        if (DynamicUIHandler.imagePicker.contains(item.key)) {
          if (item.value != null && item.value != "") {
            initialUserprofileURL = item.value;
          }
        }
      }
    }
  }

  /// Get initial DOB Data
  getInitialDOBData(Map<String, dynamic>? personData) {
    if (personData != null && entryField != null) {
      for (var item in personData.entries) {
        if (DynamicUIHandler.calenderView.contains(item.key)) {
          if (item.value != null && item.value != "") {
            date = item.value;
          }
        }
      }
    }
  }

  /// Final submit button process

  pressAddEntrySubmitButton() async {
    EasyLoading.show();
    Map<String, dynamic> map = {};
    map.addEntries({"level_name": "$levelName"}.entries);
    map.addEntries({"unit": "$unitId"}.entries);
    map.addEntries({"sub_unit": "${subUnitId ?? ""} "}.entries);
    map.addEntries({"type": "$type"}.entries);
    map.addEntries({"level": "$levelId"}.entries);
    map.addEntries({"from": "$from"}.entries);
    if (personID != null && personID != "") {
      map.addEntries({"personId": "$personID"}.entries);
    }

    for (int i = 0; i < (entryField?.length ?? 0); i++) {
      for (var item in finalAllDataList.entries) {
        if (entryField?[i].fieldName == item.key) {
          if (item.key == "photo") {
            if (item.value.toString().contains("http") ||
                item.value.toString().contains("HTTP")) {
              map.addEntries({
                "${entryField?[i].formControlName}": "${item.value}"
              }.entries);
            } else {
              String url = await getNetworkUrl(item.value,
                  id: personID ?? DateTime.now().millisecondsSinceEpoch,
                  name: 'userprofile');
              map.addEntries(
                  {"${entryField?[i].formControlName}": url}.entries);
            }
          } else {
            map.addEntries(
                {"${entryField?[i].formControlName}": "${item.value}"}.entries);
          }
        }
      }
    }
    for (var item in finalAllDataList.entries) {
      if (DynamicUIHandler.filePickerUrl.contains(item.key)) {
        if (item.value.toString() != "" && item.value.toString() != null) {
          if (item.value.toString().contains("http") ||
              item.value.toString().contains("HTTP")) {
            map.addEntries({item.key: "${item.value}"}.entries);
          } else {
            String url = await getNetworkUrl(item.value,
                id: personID ?? DateTime.now().millisecondsSinceEpoch,
                name: item.key.toString().split("_")[0]);
            map.addEntries({item.key: url}.entries);
          }
        }
      }
    }

    submitEntryData(data: map);
    print(map);
  }

  /// call add and update entry api

  Future submitEntryData({required Map<String, dynamic> data}) async {
    try {
      emit(SubmitAddEntryLoadingState());

      final res = await api.submitAddEntry(
          'Bearer ${StorageService.userAuthToken}', data);
      print(
          "------------------------------------ ADD DATA ENTRY API  ----------------------------");
      print("data  :$data");
      print("Status code : ${res.response.statusCode}");
      log("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        if (res.data["success"] == true && res.data["duplication"] == false) {
          emit(SubmitAddEntrySuccessState(res.data["message"]));
        } else {
          Map<String, dynamic>? msg = res.data;
          emit(SubmitAddEntryErrorState(msg?['message'] ?? ''));
        }
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(SubmitAddEntryErrorState(msg?['message'] ?? ''));
      }
    } catch (e) {
      emit(SubmitAddEntryErrorState('Something Went Wrong'));
    } finally {
      EasyLoading.dismiss();
    }
  }

  getNetworkUrl(String path, {int? id, required String name}) async {
    final imageTemp = File(path);
    File? imageFile = imageTemp;
    final destination = '$id/${id}_$name';
    UploadTask? task = FirebaseApi.uploadFile(destination, imageFile);
    final snapshot = await task?.whenComplete(() {});
    String? urlDownload = await snapshot?.ref.getDownloadURL();
    print('Image Download-Link: $urlDownload');
    return urlDownload;
  }
}
