import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> selectImage1() async {
    emit(CreateFunctionInitial());
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery);
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
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery);
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
}
