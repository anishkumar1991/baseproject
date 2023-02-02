import '../network/model/ReelsModel.dart';

abstract class ReelsState {}

class ReelsInitialState extends ReelsState {}

class ReelsLoadingState extends ReelsState {}

class ReelsFetchedState extends ReelsState {
  final ReelsModel reelsModel;

  ReelsFetchedState(this.reelsModel);
}

class ReelsErrorState extends ReelsState {}
