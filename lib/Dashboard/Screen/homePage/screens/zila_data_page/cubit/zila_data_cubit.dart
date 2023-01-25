import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/cubit/zila_data_state.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/network/model/filter_data_model.dart';

import '../../../../../../storage/user_storage_service.dart';
import '../Network/Api/data_entry_api.dart';
import '../network/model/data_entry_model.dart';
import '../network/model/zila_model.dart';

class ZilaDataCubit extends Cubit<ZilaDataState> {
  ZilaDataCubit() : super(ZilaDataInitialStateState());

  List<UserData> dataList = [];
  List<PartyZilaData> partyzilaList = [];
  List<FilterData> filterDataList = [];
  PartyZilaData? zilaSelected;
  int filterDtaSelectedIndex = 0;
  final api = DataEntryApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  void onChnageZila(PartyZilaData? value) {
    emit(LoadingState());
    zilaSelected = value;
    emit(ZilaChangedState());
  }

  Future getEntryData({required Map<String, dynamic> data}) async {
    try {
      emit(DataFetchingLoadingState());
      final res = await api.getPersonList(
          'Bearer ${StorageService.userAuthToken}', data);
      print('Entry res =${res.response.statusCode}');
      if (res.response.statusCode == 200) {
        DataEntryModel data = DataEntryModel.fromJson(res.data);
        emit(EntryDataFetchedState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(ErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      emit(ErrorState('Something Went Wrong'));
    }
  }

  Future getPartyZila({required int id}) async {
    try {
      emit(DataFetchingLoadingState());
      final res =
          await api.partyzilas('Bearer ${StorageService.userAuthToken}', id);
      print('Part Zila res =${res.response.statusCode}');
      if (res.response.statusCode == 200) {
        ZilaModel data = ZilaModel.fromJson(res.data);
        emit(PartyZilaSelectedState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(ErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      emit(ErrorState('Something Went Wrong'));
    }
  }

  Future getFilterOptions() async {
    try {
      emit(DataFetchingLoadingState());
      final res =
          await api.getFilterOptions('Bearer ${StorageService.userAuthToken}', {
        "type": "Designation",
        "data_level": 7,
        "country_state_id": 3,
        "unit_id": 25,
        "sub_unit_id": 58
      });
      print('filter options res =${res.response.statusCode}');
      if (res.response.statusCode == 200) {
        FilterDataModel data = FilterDataModel.fromJson(res.data);
        emit(FilterDataFetchedState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(ErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      emit(ErrorState('Something Went Wrong'));
    }
  }

  void onTapFilterData(int index) {
    emit(LoadingState());
    filterDtaSelectedIndex = index;
    emit(FilterDataSelectedState());
  }
}
