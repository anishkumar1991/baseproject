import 'package:equatable/equatable.dart';

abstract class AddEntryState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddEntryInitialState extends AddEntryState {}

class AddEntryLoadingState extends AddEntryState {}

class DropDownSelectedState extends AddEntryState {
  final String? selectedValue;
  DropDownSelectedState(this.selectedValue);
}

class AddEntryErrorState extends AddEntryState {
  final String error;
  AddEntryErrorState(this.error);
}

class DobSelectedState extends AddEntryState {
  String date;
  DobSelectedState(this.date);
}
