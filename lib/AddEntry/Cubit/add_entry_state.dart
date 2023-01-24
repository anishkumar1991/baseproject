import 'dart:io';

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
  final String date;
  DobSelectedState(this.date);
}

class RadioButtonSelectState extends AddEntryState {}

class ImagePickedState extends AddEntryState {
  final File? file;
  ImagePickedState(this.file);
}

class FilePickedState extends AddEntryState {
  FilePickedState();
}
