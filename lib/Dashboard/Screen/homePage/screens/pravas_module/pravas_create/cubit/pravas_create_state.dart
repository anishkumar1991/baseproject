part of 'pravas_create_cubit.dart';

@immutable
abstract class PravasCreateState  {}

class PravasCreateInitial extends PravasCreateState {}
// class DobSelectedState extends PravasCreateState {
//   String date;
//   DobSelectedState(this.date);
// }
class StartDateOfTour extends PravasCreateState {
 final String date;
  StartDateOfTour(this.date);
}
class EndOfTour extends PravasCreateState {
 final String date;
  EndOfTour(this.date);
}
class AddEntryLoadingState extends PravasCreateState {}

/// CreatePravas

class CreatePravasLoadingState extends PravasCreateState {}
class CreatePravasFatchDataState extends PravasCreateState {
 CreatePravasAndFunctionModel? data;
 CreatePravasFatchDataState({this.data});
}
class CreatePravasErrorState extends PravasCreateState {
 String? error;
 CreatePravasErrorState({this.error});
}
