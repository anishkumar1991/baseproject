import 'package:equatable/equatable.dart';

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
