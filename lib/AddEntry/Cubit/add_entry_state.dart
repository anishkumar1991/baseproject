import 'package:equatable/equatable.dart';
import 'package:sangathan/AddEntry/network/model/category_model.dart';

import '../network/model/add_entry_data_model.dart';
import '../network/model/add_entry_form_structure_model.dart';
import '../network/model/cast_model.dart';
import '../network/model/designation_data_model.dart';

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

class GetAddEntryFormStructureLoadingState extends AddEntryState {}

class GetAddEntryFormStructureSuccessState extends AddEntryState {
  final AddEntryFormStructure addEntryFormStructure;

  GetAddEntryFormStructureSuccessState(this.addEntryFormStructure);
}

class GetAddEntryFormStructureFailedState extends AddEntryState {
  final String error;

  GetAddEntryFormStructureFailedState(this.error);
}

class DynamicFieldAddLoadingState extends AddEntryState {}

class DynamicFieldAddSuccessState extends AddEntryState {}

class DesignationDropDownLoadingState extends AddEntryState {}

class DesignationDropDownSuccessState extends AddEntryState {
  final DesignationDataModel designationList;

  DesignationDropDownSuccessState(this.designationList);
}

class DesignationDropDownFailedState extends AddEntryState {
  final String error;

  DesignationDropDownFailedState(this.error);
}

class DisposeState extends AddEntryState {}

class FilterDataFetchedState extends AddEntryState {
  final DesignationDataModel designationData;

  FilterDataFetchedState(this.designationData);
}

class FilterDataSelectedState extends AddEntryState {}

class TimerStopState extends AddEntryState {}

class TimerLoadingState extends AddEntryState {}

class TimerRunningState extends AddEntryState {
  final int count;

  TimerRunningState(this.count);
}

class MultiCheckSelectionState extends AddEntryState {}

class SubmitAddEntryLoadingState extends AddEntryState {}

class SubmitAddEntrySuccessState extends AddEntryState {
  final String message;
  final String mobileNo;

  SubmitAddEntrySuccessState(this.message, this.mobileNo);
}

class AddEntryDuplicateUser extends AddEntryState {
  final AddDataEntryModel addDataEntryModel;

  AddEntryDuplicateUser(this.addDataEntryModel);
}

class AddEntryForceSubmit extends AddEntryState {
  final AddDataEntryModel addDataEntryModel;

  AddEntryForceSubmit(this.addDataEntryModel);
}

class SubmitAddEntryErrorState extends AddEntryState {
  final String errorString;

  SubmitAddEntryErrorState(this.errorString);
}

class DistrictDropdownLoadingState extends AddEntryState {}

class DistrictDropdownSuccessState extends AddEntryState {
  final List<DropdownData> districtDropdownData;

  DistrictDropdownSuccessState(this.districtDropdownData);
}

class DistrictDropdownErrorState extends AddEntryState {
  final String errorMsg;

  DistrictDropdownErrorState(this.errorMsg);
}
