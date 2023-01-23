part of 'create_function_cubit.dart';

@immutable
abstract class CreateFunctionState {}

class CreateFunctionInitial extends CreateFunctionState {}
class FunctionTypeChangeSuccess extends CreateFunctionState {}
class FunctionLevelChangeSuccess extends CreateFunctionState {}
class Image1SelectSuccess extends CreateFunctionState {}
class Image2SelectSuccess extends CreateFunctionState {}
class FunctionPlaceSelectSuccess extends CreateFunctionState {}
