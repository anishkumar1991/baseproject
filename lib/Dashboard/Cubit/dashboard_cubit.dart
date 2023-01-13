import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Cubit/dashboard_state.dart';

class DashBoardCubit extends Cubit<NavigationBarState> {
  DashBoardCubit() : super(NavigationBarInitialState());
  void onTapIcons(int index) {
    emit(LoadingState());
    emit(NavigationBarIndexSelectedState(index));
  }
}
