import '../network/model/dash_model.dart';

abstract class DashStates {}

class DashInitialState extends DashStates {}

class DashLoadingState extends DashStates {}

class DashGotEventsState extends DashStates {
  final DashModal dashModal;
  DashGotEventsState(this.dashModal);
}

class DashErrorState extends DashStates {
  final String error;
  DashErrorState(this.error);
}
