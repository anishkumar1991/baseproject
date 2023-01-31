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
