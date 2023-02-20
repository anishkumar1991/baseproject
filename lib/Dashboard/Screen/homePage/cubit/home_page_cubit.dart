import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/cubit/home_page_state.dart';

import '../../../../Storage/user_storage_service.dart';
import '../network/api/home_page_api.dart';
import '../network/model/client_app_lists_model.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomeInitialState());
  bool isOpen = false;
  final api = HomePageApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  void onTapButton() {
    emit(LoadingState());
    isOpen = !isOpen;
    emit(OnChnageValueState(isOpen));
  }

  Future getClientAppLists() async {
    emit(ClientAppListsLoadingState());
    if (state is ClientAppListsLoadingState) {
      try {
        final res = await api
            .getClientAppLists('Bearer ${StorageService.userAuthToken}');
        if (res.response.statusCode == 200) {
          ClientAppListsModel clientAppListsModel =
              ClientAppListsModel.fromJson(res.data);
          emit(ClientAppListsSuccessState(clientAppListsModel));
          print(
              "------------------------------------ Client App Lists ----------------------------");
          print("Token : ${StorageService.userAuthToken}");
          print("Status code : ${res.response.statusCode}");
          print("Response :${res.data}");
          print("Response :${res.response.realUri}");
          print(
              "------------------------------------ ------------------------ ----------------------------");
        } else {
          Map<String, dynamic>? msg = res.data;
          emit(ClientAppListsFailedState(msg?['errors'] ?? ''));
        }
      } catch (e) {
        print(e.toString());
        emit(ClientAppListsFailedState("Something went wrong!"));
      }
    }
  }
}
