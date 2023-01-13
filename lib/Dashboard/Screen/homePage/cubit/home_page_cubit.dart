import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Cubit/dashboard_state.dart';
import 'package:sangathan/Dashboard/Screen/homePage/cubit/home_page_state.dart';

class HomePageCubit extends Cubit<NavigationBarState> {
  HomePageCubit() : super(NavigationBarInitialState());
  bool isOpen = false;
  void onTapButton() {
    emit(LoadingState());
    isOpen=!isOpen;
    emit(OnChnageValueState(isOpen));
  }
}
