import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'edit_education__state.dart';

class EditEducationCubit extends Cubit<EditEducationState> {
  EditEducationCubit() : super(EditEducationInitial());

  TextEditingController levelCtr = TextEditingController();
  TextEditingController startYearCtr = TextEditingController();
  TextEditingController endYearCtr = TextEditingController();
  TextEditingController collageCtr = TextEditingController();
  final FocusNode clgFocusNode = FocusNode();

  clearData() {
    levelCtr.clear();
    startYearCtr.clear();
    endYearCtr.clear();
    collageCtr.clear();
  }

  bool checkIfEmpty() {
    bool isEmpty = false;
    if (levelCtr.text.isEmpty) {
      if (startYearCtr.text.isEmpty) {
        if (endYearCtr.text.isEmpty) {
          if (collageCtr.text.isEmpty) {
            isEmpty = true;
          }
        }
      }
    }
    return isEmpty;
  }

  emitState() {
    emit(EditEducationInitial());
  }
}
