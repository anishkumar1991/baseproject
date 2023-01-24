part of 'edit_date_cubit.dart';

@immutable
abstract class EditDateState {}

class EditDateInitial extends EditDateState {}

class StartDateOfTour extends EditDateState {
 final String date;
  StartDateOfTour(this.date);
}

class EditTime extends EditDateState {
 final String time;
  EditTime(this.time);
}
class AddEntryLoadingState extends EditDateState {}
