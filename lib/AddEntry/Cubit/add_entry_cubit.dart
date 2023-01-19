import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sangathan/AddEntry/Cubit/add_entry_state.dart';

class AddEntryCubit extends Cubit<AddEntryState> {
  AddEntryCubit() : super(AddEntryInitialState());

  String? selectedValue;
  DateTime dateTime = DateTime.now();
  String date = 'Seletc DOB of Birth';
  static String ddMMMYYYYfromDateTime(DateTime date) {
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  void onTapDropDownButton(String? value) {
    emit(AddEntryLoadingState());
    selectedValue = value;
    emit(DropDownSelectedState(selectedValue));
  }

  Future<void> selectedDoaDate(BuildContext context) async {
    emit(AddEntryLoadingState());
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime) {
      dateTime = picked;
      date = ddMMMYYYYfromDateTime(dateTime);
      emit(DobSelectedState(date));
    }
    ;
  }
}
