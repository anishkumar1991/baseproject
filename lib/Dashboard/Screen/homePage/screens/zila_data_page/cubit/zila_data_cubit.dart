import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/cubit/zila_data_state.dart';

import '../../../../../../storage/user_storage_service.dart';
import '../Network/Api/data_entry_api.dart';
import '../network/model/data_entry_model.dart';

class ZilaDataCubit extends Cubit<ZilaDataState> {
  ZilaDataCubit() : super(ZilaDataInitialStateState());

  List<UserData> dataList = [];

    String? zilaSelected;
    final api = DataEntryApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  void onChnageZila(String? value) {
    emit(LoadingState());
    zilaSelected = value;
    emit(ZilaChangedState());
  }

  Future getEntryData({required Map<String, dynamic> data}) async {
    try {
      emit(DataFetchingLoadingState());
      String? token = StorageService.getUserAuthToken();
      final res = await api.getPersonList('Bearer $token', data);
      print('Entry res =${res.response.statusCode}');
      if (res.response.statusCode == 200) {
        DataEntryModel data = DataEntryModel.fromJson(res.data);
        emit(EntryDataFetchedState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(ErrorState(msg?['error'] ?? ''));
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
