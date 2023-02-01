part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ErrorState extends ProfileState {
  final String error;
  ErrorState(this.error);
}
class UserDetailFetchedState extends ProfileState {
  final UserDetailModel data;
  UserDetailFetchedState(this.data);
}
class DropDownErrorState extends ProfileInitial {
  final String error;

  DropDownErrorState(this.error);
}

class DropDownFetchedState extends ProfileInitial {
  final DropdownValueModel category;

  DropDownFetchedState(this.category);
}

