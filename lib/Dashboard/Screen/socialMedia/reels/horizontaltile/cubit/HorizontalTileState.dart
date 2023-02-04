import '../network/model/HorizontalTileModel.dart';

abstract class HorizontalTileState {}

class HorizontalTileInitialState extends HorizontalTileState {}

class HorizontalTileLoading extends HorizontalTileState {}

class HorizontalTileFetchedState extends HorizontalTileState {
  final HorizontalTileModel htModel;

  HorizontalTileFetchedState(this.htModel);
}

class HorizontalTileError extends HorizontalTileState {}
