part of 'personal_info_cubit.dart';

@immutable
abstract class PersonalInfoState {}

class PersonalInfoInitial extends PersonalInfoState {}
class ImageSelectSuccess extends PersonalInfoState {}
class LoadingState extends PersonalInfoState {}
class UpdateDataState extends PersonalInfoInitial {
  final UserDetailModel data;
  UpdateDataState(this.data);
}

class PersonalInfoErrorState extends PersonalInfoInitial {
  final String error;
  PersonalInfoErrorState(this.error);
}

class DateOfBirth extends PersonalInfoState {
  final String date;
  DateOfBirth(this.date);
}

class FillCastValueState extends PersonalInfoInitial {
  final CastModel cast;

  FillCastValueState(this.cast);
}
