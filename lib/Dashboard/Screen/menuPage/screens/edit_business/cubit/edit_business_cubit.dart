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

  emitState(){
    emit(EditBusinessInitial());
  }
}
