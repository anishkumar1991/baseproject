import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

part 'personal_info_state.dart';

enum Gender { male, female, transgender }


class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit() : super(PersonalInfoInitial());

  File? imageFile;
  String date = 'दिनांक';
  DateTime dateTime = DateTime.now();
  bool ischecked = false;
  Gender value = Gender.male;
  final TextEditingController nameCtr = TextEditingController();
  final TextEditingController userNameCtr = TextEditingController();
  final TextEditingController mobileNumberCtr = TextEditingController();
  final TextEditingController boiCtr = TextEditingController();
  final TextEditingController religionCtr = TextEditingController();
  final TextEditingController statusCtr = TextEditingController();
  final TextEditingController castCtr = TextEditingController();


  emitState(){
    emit(PersonalInfoInitial());
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
    return DateFormat('dd-MMM-yyyy').format(date);
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
