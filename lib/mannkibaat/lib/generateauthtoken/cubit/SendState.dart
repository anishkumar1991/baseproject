import 'package:equatable/equatable.dart';
import 'package:sangathan/mannkibaat/lib/generateauthtoken/network/model/LoginModel.dart';
import 'package:sangathan/mannkibaat/lib/generateauthtoken/network/model/UserDetailsModel.dart';

abstract class GenerateMannKiBaatAuthState extends Equatable {
  List<Object> get props => [];
}
class NewUserState extends GenerateMannKiBaatAuthState{}

class LoginInitialState extends GenerateMannKiBaatAuthState {}

class LoadingState extends GenerateMannKiBaatAuthState {}

class SubmitOtpLoadingState extends GenerateMannKiBaatAuthState {}

class TimerRunningState extends GenerateMannKiBaatAuthState {
  final int count;

  TimerRunningState(this.count);
}

class TimerStopState extends GenerateMannKiBaatAuthState {}

class UserLoggedState extends GenerateMannKiBaatAuthState {
  final LoginModel model;

  UserLoggedState(this.model);
}

class LoginFaieldState extends GenerateMannKiBaatAuthState {
  final String error;

  LoginFaieldState(this.error);
}

class OtpResendSuccessfullyState extends GenerateMannKiBaatAuthState {
  final LoginModel model;

  OtpResendSuccessfullyState(this.model);
}

class UserLoginSuccessfullyState extends GenerateMannKiBaatAuthState {
  final UserDetails userDetails;
  UserLoginSuccessfullyState(this.userDetails);
}
