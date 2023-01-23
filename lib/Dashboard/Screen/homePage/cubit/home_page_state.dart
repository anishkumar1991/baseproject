import 'package:equatable/equatable.dart';
import 'package:sangathan/Dashboard/Cubit/dashboard_state.dart';
import 'package:sangathan/Dashboard/Screen/homePage/Network/model/data_entry_model.dart';

abstract class HomePageState extends Equatable {
  List<Object> get props => [];
}

class LoadingState extends HomePageState {}

class HomeInitialState extends HomePageState {}

class OnChnageValueState extends HomePageState {
  bool isOpen = false;
  OnChnageValueState(this.isOpen);
}
