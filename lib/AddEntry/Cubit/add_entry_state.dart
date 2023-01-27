import 'package:equatable/equatable.dart';
import 'package:sangathan/AddEntry/network/model/category_model.dart';

import '../network/model/cast_model.dart';

abstract class AddEntryState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddEntryInitialState extends AddEntryState {}

class AddEntryLoadingState extends AddEntryState {}

class DropDownSelectedState extends AddEntryState {
  DropDownSelectedState();
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
  ImagePickedState();
}

class FilePickedState extends AddEntryState {
  FilePickedState();
}

class DropDownValueFetchedState extends AddEntryState {
  final DropdownValueModel category;
  DropDownValueFetchedState(this.category);
}

class CastFetchedState extends AddEntryState {
  final CastModel cast;
  CastFetchedState(this.cast);
}

class ImageConvertedState extends AddEntryState {}
