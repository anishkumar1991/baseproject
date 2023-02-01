import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/pravas_create/widgets/range_picker_dialog.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

part 'pravas_create_state.dart';

class PravasCreateCubit extends Cubit<PravasCreateState> {
  PravasCreateCubit() : super(PravasCreateInitial());

  String startDate = '';
  String endDate = '';
  PickerDateRange? temp;

  Future<void> startToEndDate(BuildContext context) async {
    emit(AddEntryLoadingState());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  const RangePickerDialog();
      },
    ).then((value) =>  emit(StartDateOfTour(startDate)));
  }
}
