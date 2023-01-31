import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'edit_education__state.dart';

class EditEducationCubit extends Cubit<EditEducationState> {
  EditEducationCubit() : super(EditEducationInitial());

  TextEditingController levelCtr = TextEditingController();
  TextEditingController startYearCtr = TextEditingController();
  TextEditingController endYearCtr = TextEditingController();
  TextEditingController collageCtr = TextEditingController();

  emitState(){
    emit(EditEducationInitial());
  }
}
