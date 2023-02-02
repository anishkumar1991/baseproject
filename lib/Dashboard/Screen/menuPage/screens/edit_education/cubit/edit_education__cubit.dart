import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../homePage/screens/pravas_create/widgets/range_picker_dialog.dart';

part 'edit_education__state.dart';

class EditEducationCubit extends Cubit<EditEducationState> {
  EditEducationCubit() : super(EditEducationInitial());

  TextEditingController levelCtr = TextEditingController();
  TextEditingController startYearCtr = TextEditingController();
  TextEditingController endYearCtr = TextEditingController();
  TextEditingController collageCtr = TextEditingController();


  clearData(){
    levelCtr.clear();
    startYearCtr.clear();
    endYearCtr.clear();
    collageCtr.clear();
  }

  emitState(){
    emit(EditEducationInitial());
  }

}
