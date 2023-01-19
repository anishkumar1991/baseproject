import 'package:equatable/equatable.dart';
import 'package:sangathan/SplashScreen/Network/model/user_profile_model.dart';

abstract class UserProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserProfileInitialState extends UserProfileState {}

class UserProfileLoadigState extends UserProfileState {}

class UserProfileDataFetchedState extends UserProfileState {
  final UserProfileModel userProfileModel;
  UserProfileDataFetchedState(this.userProfileModel);
}

class UserProfileErrorState extends UserProfileState {
  final String error;
  UserProfileErrorState(this.error);
}
