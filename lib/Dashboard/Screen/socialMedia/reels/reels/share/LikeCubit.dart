import 'package:flutter_bloc/flutter_bloc.dart';

import 'LikeState.dart';

class LikeCubit extends Cubit<LikeState> {
  LikeCubit() : super(InitialState()) {}

  void thumbPressed() {
    emit(LikePressedState());
  }

  void thumbNotPressed() {
    emit(LikeNotPressedState());
  }
}
