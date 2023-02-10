import 'package:sangathan/AddEntry/cubit/add_entry_state.dart';

abstract class VerifyPersonState {}

class VerifyPersonInitialState extends VerifyPersonState {}

class TimerLoadingState extends VerifyPersonState {}

class TimerRunningState extends VerifyPersonState {
  final int count;
  TimerRunningState(this.count);
}

class TimerStopState extends VerifyPersonState {}

class SendOTPLoadingState extends VerifyPersonState {}

class SendOTPSuccessful extends VerifyPersonState {
  final String message;
  SendOTPSuccessful(this.message);
}

class SendOTPErrorState extends VerifyPersonState {
  final String error;
  SendOTPErrorState(this.error);
}
