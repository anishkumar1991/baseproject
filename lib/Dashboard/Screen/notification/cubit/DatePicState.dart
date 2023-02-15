
abstract class DatePicState {}

class InitialDatePicState extends DatePicState {}

class DatePickedStateState extends DatePicState{

  final DateTime datePicked;
  DatePickedStateState(this.datePicked);

}
