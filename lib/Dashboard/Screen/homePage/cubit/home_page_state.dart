import 'package:equatable/equatable.dart';

import '../network/model/client_app_lists_model.dart';

abstract class HomePageState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends HomePageState {}

class HomeInitialState extends HomePageState {}

class OnChnageValueState extends HomePageState {
  final bool isOpen;

  OnChnageValueState(this.isOpen);
}

class ClientAppListsLoadingState extends HomePageState {}

class ClientAppListsSuccessState extends HomePageState {
  final ClientAppListsModel clientAppListsModel;

  ClientAppListsSuccessState(this.clientAppListsModel);
}

class ClientAppListsFailedState extends HomePageState {
  final String errorMsg;

  ClientAppListsFailedState(this.errorMsg);
}
