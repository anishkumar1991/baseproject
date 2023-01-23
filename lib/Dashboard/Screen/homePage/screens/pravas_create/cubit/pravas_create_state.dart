part of 'pravas_create_cubit.dart';

@immutable
abstract class PravasCreateState  {}

class PravasCreateInitial extends PravasCreateState {}
// class DobSelectedState extends PravasCreateState {
//   String date;
//   DobSelectedState(this.date);
// }
class StartDateOfTour extends PravasCreateState {
  String date;
  StartDateOfTour(this.date);
}
class EndOfTour extends PravasCreateState {
  String date;
  EndOfTour(this.date);
}
class AddEntryLoadingState extends PravasCreateState {}


