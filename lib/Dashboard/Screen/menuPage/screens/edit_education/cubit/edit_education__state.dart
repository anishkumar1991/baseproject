part of 'edit_education__cubit.dart';

@immutable
abstract class EditEducationState {}

class EditEducationInitial extends EditEducationState {}

class YearDurationEducation extends EditEducationInitial {
  final String date;
  YearDurationEducation(this.date);
}
