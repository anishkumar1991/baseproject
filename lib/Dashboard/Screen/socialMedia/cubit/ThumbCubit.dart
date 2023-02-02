import 'package:flutter_bloc/flutter_bloc.dart';

import 'ThumbState.dart';

class ThumbCubit extends Cubit<ThumbState> {
  ThumbCubit() : super(InitialState()) {}


  void thumbPressed(){
    emit(ThumbPressedState());
  }
  void thumbNotPressed(){
    emit(ThumbNotPressedState());
  }

}
