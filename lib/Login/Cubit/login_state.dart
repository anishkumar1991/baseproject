import 'package:equatable/equatable.dart';
import 'package:sangathan/Login/Network/model/login_model.dart';
import 'package:sangathan/Login/Network/model/user_model.dart';

abstract class LoginState extends Equatable {
  List<Object> get props => [];
}

class LoginInitialState extends LoadingState {}

class LoadingState extends LoginState {}

class SubmitOtpLoadingState extends LoginState {}

class TimerRunningState extends LoginState {
  final int count;
  TimerRunningState(this.count);
}

class TimerStopState extends LoginState {}

class UserLoggedState extends LoginState {
  final LoginModel model;
  UserLoggedState(this.model);
}

class LoginFaieldState extends LoginState {
  final String error;
  LoginFaieldState(this.error);
}

class OtpResendSuccessfullyState extends LoginState {
  final LoginModel model;
  OtpResendSuccessfullyState(this.model);
}

class UserLoginSuccessfullyState extends LoginState {
  final UserDetails userDetails;
  UserLoginSuccessfullyState(this.userDetails);
}
class LogOutLoadingState extends LoadingState{}
class UserLogOutSuccessState extends LoginState {
  final String msg;
  UserLogOutSuccessState(this.msg);
}

class UserLogOutFaieldState extends LoginState {
  final String error;
  UserLogOutFaieldState(this.error);
}
