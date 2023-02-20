import '../network/model/Booth.dart';
import '../network/model/VidhanSabhaModel.dart';

abstract class FetchStates {}

class InitialState extends FetchStates {}

class FetchingState extends FetchStates {}

class DropDownSelected extends FetchStates {}

class FetchedState extends FetchStates {
  final States model;
  FetchedState(this.model);
}
class BoothFetchedState extends FetchStates {
  final Booth model;
  BoothFetchedState(this.model);
}