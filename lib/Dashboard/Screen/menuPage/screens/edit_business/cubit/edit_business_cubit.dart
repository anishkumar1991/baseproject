import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'edit_business_state.dart';

class EditBusinessCubit extends Cubit<EditBusinessState> {
  EditBusinessCubit() : super(EditBusinessInitial());

  TextEditingController businessNameCtr = TextEditingController();
  TextEditingController startYearCtr = TextEditingController();
  TextEditingController endYearCtr = TextEditingController();
  TextEditingController positionCtr = TextEditingController();

    final FocusNode sangathanFocuseNode = FocusNode();
    final FocusNode designationFocuseNode = FocusNode();

  clearData(){
    businessNameCtr.clear();
    startYearCtr.clear();
    endYearCtr.clear();
    positionCtr.clear();
  }
  bool checkIfEmpty() {
    bool isEmpty = false;
    if (businessNameCtr.text.isEmpty) {
      if(startYearCtr.text.isEmpty){
        if(endYearCtr.text.isEmpty){
          if(positionCtr.text.isEmpty){
            isEmpty = true;
          }
        }
      }
    }
    return isEmpty;
  }


  emitState(){
    emit(EditBusinessInitial());
  }
}
