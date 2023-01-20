import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sangathan/AddEntry/Cubit/add_entry_state.dart';

class AddEntryCubit extends Cubit<AddEntryState> {
  AddEntryCubit() : super(AddEntryInitialState());

  String? selectedValue;
  DateTime dateTime = DateTime.now();
  String date = 'Seletc DOB of Birth';
  String? selectRadio;
  File? file;
  File? pickedFile;

  void onTapRadioButton(String value) {
    emit(AddEntryLoadingState());
    selectRadio = value;
    emit(RadioButtonSelectState());
  }

  static String ddMMMYYYYfromDateTime(DateTime date) {
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  void onTapDropDownButton(String? value) {
    emit(AddEntryLoadingState());
    selectedValue = value;
    emit(DropDownSelectedState(selectedValue));
  }

  Future<void> selectedDoaDate(BuildContext context) async {
    emit(AddEntryLoadingState());
    final DateTime? picked = await showDatePicker(
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
      emit(ImagePickedState(file));
    }
  }

  Future<void> pickFile() async {
    emit(AddEntryLoadingState());

    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      pickedFile = File(result.files.single.path!);
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
}
