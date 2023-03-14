import 'package:equatable/equatable.dart';

import '../../Login/Network/model/user_detail_model.dart';

abstract class UserProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserProfileInitialState extends UserProfileState {}

class UserProfileLoadigState extends UserProfileState {}

class UserProfileDataFetchedState extends UserProfileState {
  final UserDetailModel userProfileModel;
  UserProfileDataFetchedState(this.userProfileModel);
}

class UserProfileErrorState extends UserProfileState {
  final String error;
  UserProfileErrorState(this.error);
}
