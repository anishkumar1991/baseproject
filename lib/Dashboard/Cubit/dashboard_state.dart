import 'package:equatable/equatable.dart';

abstract class NavigationBarState extends Equatable {
  List<Object> get props => [];
}

class NavigationBarInitialState extends NavigationBarState {}

class LoadingState extends NavigationBarState {}

class NavigationBarIndexSelectedState extends NavigationBarState {
  final int index;
  NavigationBarIndexSelectedState(this.index);
}
