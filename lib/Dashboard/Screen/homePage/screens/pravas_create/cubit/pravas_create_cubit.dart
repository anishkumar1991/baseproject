import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'pravas_create_state.dart';

class PravasCreateCubit extends Cubit<PravasCreateState> {
  PravasCreateCubit() : super(PravasCreateInitial());

  String date = '';
  String date1 = '';
  DateTime dateTime = DateTime.now();
  DateTime dateTime1 = DateTime.now();

  static String ddMMMYYYYfromDateTime(DateTime date) {
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  Future<void> startDateOfTour(BuildContext context) async {
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

  Future<void> endOfTour(BuildContext context) async {
    emit(AddEntryLoadingState());
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime1,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime1) {
      dateTime1 = picked;
      date1 = ddMMMYYYYfromDateTime(dateTime1);
      emit(EndOfTour(date1));
    }
  }

  Future<void> openDialog(BuildContext context) async {
    emit(AddEntryLoadingState());
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime1,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime1) {
      dateTime1 = picked;
      date1 = ddMMMYYYYfromDateTime(dateTime1);
      emit(EndOfTour(date1));
    }
  }
}
