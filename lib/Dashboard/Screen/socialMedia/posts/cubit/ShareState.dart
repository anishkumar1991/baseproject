
abstract class ShareState {}
class InitialShareState extends ShareState{}
class ShareToAllState extends ShareState {
  int index;
  ShareToAllState(this.index);
}
