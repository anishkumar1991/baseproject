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
  String startDate = '';
  String endDate = '';
  PickerDateRange? temp;

  emitState(){
    emit(EditEducationInitial());
  }

  Future<void> startToEndDate(BuildContext context) async {
    emit(EditEducationInitial());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return  RangePickerDialog(view: DateRangePickerView.year,cubit: BlocProvider.of<EditEducationCubit>(context),);
        return Container();
      },
    ).then((value) =>  emit(YearDurationEducation(startDate)));
  }
}
