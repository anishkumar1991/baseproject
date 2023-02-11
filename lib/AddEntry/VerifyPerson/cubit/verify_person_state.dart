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

class ResendOTPLoadingState extends VerifyPersonState {}

class ResendOTPSuccessState extends VerifyPersonState {
  final String message;
  ResendOTPSuccessState(this.message);
}

class ResendOTPErrorState extends VerifyPersonState {
  final String message;
  ResendOTPErrorState(this.message);
}
class VeifyOTPLoadingState extends VerifyPersonState {}

class VeifyOTPSuccessState extends VerifyPersonState {
  final String message;
  VeifyOTPSuccessState(this.message);
}

class VeifyOTPErrorState extends VerifyPersonState {
  final String message;
  VeifyOTPErrorState(this.message);
}
