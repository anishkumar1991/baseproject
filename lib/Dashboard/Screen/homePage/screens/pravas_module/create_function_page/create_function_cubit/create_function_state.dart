part of 'create_function_cubit.dart';

@immutable
abstract class CreateFunctionState {}

class CreateFunctionInitial extends CreateFunctionState {}

class FunctionTypeChangeSuccess extends CreateFunctionState {}

class FunctionLevelChangeSuccess extends CreateFunctionState {}

class Image1SelectSuccess extends CreateFunctionState {}

class Image2SelectSuccess extends CreateFunctionState {}

class FunctionPlaceSelectSuccess extends CreateFunctionState {}

/// createFunction
class CreateFunctionLoadingState extends CreateFunctionInitial {}

class CreateFunctionFatchDataState extends CreateFunctionInitial {
  CreatePravasAndFunctionModel? data;

  CreateFunctionFatchDataState({this.data});
}

class CreateFunctionErrorState extends CreateFunctionInitial {
  String? error;

  CreateFunctionErrorState({this.error});
}

/// Get program type state
class GetProgramTypeLoadingState extends CreateFunctionState {}

class GetProgramTypeSuccessState extends CreateFunctionState {
  final ProgramTypeModel programTypeModel;

  GetProgramTypeSuccessState(this.programTypeModel);
}

class GetProgramTypeErrorState extends CreateFunctionState {
  final String error;

  GetProgramTypeErrorState(this.error);
}

/// Get program type state
class GetProgramLevelLoadingState extends CreateFunctionState {}

class GetProgramLevelSuccessState extends CreateFunctionState {
  final ProgramTypeModel programTypeModel;

  GetProgramLevelSuccessState(this.programTypeModel);
}

class GetProgramLevelTypeErrorState extends CreateFunctionState {
  final String error;

  GetProgramLevelTypeErrorState(this.error);
}
