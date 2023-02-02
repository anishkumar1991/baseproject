import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/cubit/zila_data_state.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/network/model/data_unit_model.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/network/model/delete_reason_model.dart';

import '../../../../../../storage/user_storage_service.dart';
import '../Network/Api/data_entry_api.dart';
import '../network/model/data_entry_model.dart';
import '../network/model/zila_model.dart';

class ZilaDataCubit extends Cubit<ZilaDataState> {
  ZilaDataCubit() : super(ZilaDataInitialStateState());

  List<KaryakartaData> dataList = [];
  List<PartyZilaData> partyzilaList = [];

  PartyZilaData? zilaSelected;
  int filterDtaSelectedIndex = 0;
  List<UnitData> dataUnitList = [];
  int? unitId;
  int? subUnitId;
  List<SubUnits?> name = [];
  DeleteReasonModel? deleteReasonData;
  int? selectedDeleteResonIndex;
  String? selectedDeleteReson;
  int? deleteId;
  int? levelNameId;
  final api =
      DataEntryApi(Dio(BaseOptions(validateStatus: ((status) => true))));

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
      print(
          "------------------------------------ Get Entry Data ----------------------------");
      print("data  :$data");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        DataEntryModel data = DataEntryModel.fromJson(res.data);
        emit(EntryDataFetchedState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(ErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      print(e);
      emit(ErrorState('Something Went Wrong'));
    }
  }

  Future getPartyZila({required int id}) async {
    try {
      emit(DataFetchingLoadingState());
      final res =
          await api.partyzilas('Bearer ${StorageService.userAuthToken}', id);

      print(
          "------------------------------------ Get Party Zila ----------------------------");
      print("id  :$id");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        ZilaModel data = ZilaModel.fromJson(res.data);
        emit(PartyZilaSelectedState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(GetPartZilaErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      emit(GetPartZilaErrorState('Something Went Wrong'));
    }
  }

  Future getUnitData({required Map<String, dynamic> data}) async {
    try {
      emit(LoadingState());
      final res = await api.getDataUnits(
          'Bearer ${StorageService.userAuthToken}', data);
      print(
          "------------------------------------ Get Unit Data ----------------------------");
      print("Data  :$data");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        DataUnitModel data = DataUnitModel.fromJson(res.data);
        emit(UnitDataFetchedState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(GetDataUnitErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      print(e);
      emit(GetDataUnitErrorState('Something Went Wrong'));
    }
  }

  void onTapFilterData({required int index, required int id}) {
    emit(LoadingState());
    filterDtaSelectedIndex = index;
    unitId = id;
    print('unitId=$unitId');
    emit(ZilaChangedState());
  }

  void onChangeUnitData(SubUnits? value, int? id, int index) {
    emit(DataFetchingLoadingState());
    name[index] = value;
    subUnitId = id;
    print('subUnitId=$subUnitId');
    emit(ChangeUnitData());
  }

  Future getDeleteReason() async {
    try {
      emit(LoadingState());
      final res =
          await api.getDeleteReason('Bearer ${StorageService.userAuthToken}');
      print(
          "------------------------------------ Get Delete Reason ----------------------------");

      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        DeleteReasonModel data = DeleteReasonModel.fromJson(res.data);
        emit(DeleteReasonFetchedState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(DeleteReasonErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      emit(DeleteReasonErrorState('Something Went Wrong'));
    }
  }

  void onTapDeleteResonData(int? index, String? data) {
    emit(LoadingState());
    selectedDeleteResonIndex = index;
    selectedDeleteReson = data;
    print('reson$selectedDeleteReson');
    emit(DeleteReasonSeletcedState());
  }

  Future deletePerson(
      {required int deleteDataEntryId,
      required String reason,
      required int index}) async {
    try {
      emit(LoadingState());
      final res = await api.deletePerson(
        'Bearer ${StorageService.userAuthToken}',
        deleteDataEntryId,
        reason,
      );
      print(
          "------------------------------------ Delete Person----------------------------");
      print("deleteDataEntryId: $deleteDataEntryId");
      print("reason  :$reason");

      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        Map<String, dynamic>? msg = res.data;
        dataList.removeAt(index);
        emit(DeletePersonSuccessState(msg?['message']));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(DeletePersonErrorState(msg?['message'] ?? ''));
      }
    } catch (e) {
      emit(DeletePersonErrorState('Something Went Wrong'));
    }
  }

  void getDeleteId(int? id) {
    emit(LoadingState());
    selectedDeleteReson = null;
    selectedDeleteResonIndex = null;
    deleteId = id;
    print('deleteId $deleteId');
    emit(ZilaChangedState());
  }
}
