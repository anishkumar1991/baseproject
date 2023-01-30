part of 'personal_info_cubit.dart';

@immutable
abstract class PersonalInfoState {}

class PersonalInfoInitial extends PersonalInfoState {}
class ImageSelectSuccess extends PersonalInfoState {}
class DateOfBirth extends PersonalInfoState {
  final String date;
  DateOfBirth(this.date);
}
