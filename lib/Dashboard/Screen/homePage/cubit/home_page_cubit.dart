import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/Network/Api/data_entry_api.dart';
import 'package:sangathan/Dashboard/Screen/homePage/Network/model/data_entry_model.dart';
import 'package:sangathan/Dashboard/Screen/homePage/cubit/home_page_state.dart';
import '../../../../Storage/user_storage_service.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomeInitialState());
  bool isOpen = false;
  List<UserData> dataList = [];
  
  void onTapButton() {
    emit(LoadingState());
    isOpen = !isOpen;
    emit(OnChnageValueState(isOpen));
  }

  
}
