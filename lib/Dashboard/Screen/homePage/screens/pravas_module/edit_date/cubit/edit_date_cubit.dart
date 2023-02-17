import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'edit_date_state.dart';

class EditDateCubit extends Cubit<EditDateState> {
  EditDateCubit() : super(EditDateInitial());
  String date = 'दिनांक';
  String time = 'समय';
  DateTime dateTime = DateTime.now();
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);

  static String ddMMMYYYYfromDateTime(DateTime date) {
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String hhMMFormate(DateTime date) {
    return DateFormat('hh:mm').format(date);
  }

  Future<void> editDate(BuildContext context) async {
    emit(AddEntryLoadingState());
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime) {
      dateTime = picked;
      date = ddMMMYYYYfromDateTime(dateTime);
      emit(StartDateOfTour(date));
    }
  }

  Future<void> editTime(BuildContext context) async {
    emit(AddEntryLoadingState());

    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? Container(),
        );
      },
    );
    if (newTime != null && newTime != _time) {
      _time = newTime;
      Future.delayed(Duration.zero).then((value) {
        time = _time.format(context);
      });
      emit(EditTime(time));
    }
  }
}