import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/cubit/zila_data_state.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/network/model/data_unit_model.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/network/model/delete_reason_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../Storage/user_storage_service.dart';
import '../../sangathan_details/network/model/ClientAppPermissionModel.dart';
import '../network/api/data_entry_api.dart';
import '../network/model/booth_pannas_status_model.dart';
import '../network/model/data_entry_model.dart';
import '../network/model/independent_drodown_model.dart';

class ZilaDataCubit extends Cubit<ZilaDataState> {
  ZilaDataCubit() : super(ZilaDataInitialStateState());

  List<KaryakartaData>? dataList;
  List<KaryakartaData>? dataListWithoutSort;
  List<Locations> partyzilaList = [];
  List<Locations> dependentDropdownList = [];
  List<Locations> pannaKramaankListData = [];

  Locations? zilaSelected;
  Locations? dependentDropdownSelected;
  BoothPannasStatus? boothPannasStatus;

  //int filterDtaSelectedIndex = 0;
  List<UnitData>? dataUnitList;
  int? unitId;
  String subUnitId = "";
  List<SubUnits>? coreSangathanList = [];
  List<UnitData> morchaList = [];
  UnitData morchaData = UnitData(name: 'Morcha');
  DeleteReasonModel? deleteReasonData;
  int? selectedDeleteResonIndex;
  String? selectedDeleteReson;
  int? deleteId;
  int? levelNameId;
  int? dependentLevelNameId;
  ScrollController controller = ScrollController();
  int? acId;
  int selectedFilterIndex = 1;
  Locations? selectedPannaNo;
  bool isEditPermission = false;
  bool isDeletePermission = false;
  bool isReadPermission = false;
  bool isCreatePermission = false;

  //bool isMorchaSelected = false;

  void onTapFilterOptions(int index) {
    emit(LoadingState());
    selectedFilterIndex = index;
    emit(ZilaChangedState());
  }

  final double _height = 50.0;

  void animateToIndex(int index) {
    controller.animateTo(
      index * _height,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
  }

  void filterData() {
    emit(LoadingState());

    if (selectedFilterIndex == 0) {
      dataList!.sort(
        (a, b) {
          DateTime aDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
              .parse(a.createdAt ?? "");
          DateTime bDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
              .parse(b.createdAt ?? "");

          return bDate.compareTo(aDate);
        },
      );
    } else if (selectedFilterIndex == 1) {
      dataList = [...dataListWithoutSort!];
    } else if (selectedFilterIndex == 2) {
      dataList!.sort((a, b) => a.name.toString().compareTo(b.name.toString()));
    }
    emit(FilterChangedState());
  }

  final api =
      DataEntryApi(Dio(BaseOptions(validateStatus: ((status) => true))));

  void onChnageZila(Locations? value) {
    emit(LoadingState());
    zilaSelected = value;
    levelNameId = value?.id;
    acId = value?.id;
    emit(ZilaChangedState());
  }

  void onDependentDropdown(Locations? value) {
    emit(LoadingState());
    dependentDropdownSelected = value;
    dependentLevelNameId = value?.id;
    levelNameId = dependentLevelNameId;
    emit(ZilaChangedState());
  }

  Future getEntryData({required Map<String, dynamic> data}) async {
    try {
      emit(DataFetchingLoadingState());
      Map<String, dynamic> offsetData = {"limit": 1000, "offset": 0};
      data.addEntries(offsetData.entries);
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

  Future getPartyZila(
      {required String remainingURL, required String type}) async {
    try {
      emit(DataFetchingLoadingState());
      final res = await api.dynamicDropdown(
          'Bearer ${StorageService.userAuthToken}', remainingURL);

      print(
          "------------------------------------ Get Party Zila ----------------------------");
      print("remainingURL:$remainingURL");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        IndependentDropdownModel data =
            IndependentDropdownModel.fromJson(res.data);
        emit(PartyZilaSelectedState(data.data?.locations ?? []));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(GetPartZilaErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      print(e);
      emit(GetPartZilaErrorState('Something Went Wrong'));
    }
  }

  Future getDependentDropdownData(
      {required String remainingURL, required String type}) async {
    try {
      emit(DependentDropdownLoadingState());
      final res = await api.dynamicDropdown(
          'Bearer ${StorageService.userAuthToken}', remainingURL);

      print(
          "------------------------------------ dependent Dropdown Data $type ----------------------------");
      print("remainingURL:$remainingURL");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        if (type == "Zila") {
          List data = res.data["data"];
          var dataLocation =
              data.map((data) => Locations.fromJson(data)).toList();
          emit(DependentDropdownSuccessState(dataLocation));
        } else {
          IndependentDropdownModel data =
              IndependentDropdownModel.fromJson(res.data);
          emit(DependentDropdownSuccessState(data.data?.locations ?? []));
        }
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(DependentDropdownErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      print(e);
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

  void onTapFilterData({required String id, required int? unitsId}) {
    emit(LoadingState());
    morchaData = UnitData(name: 'Morcha');
    unitId = unitsId;
    subUnitId = id;
    print('unitId=$unitId');

    print('subUnitId=$subUnitId');
    emit(ZilaChangedState());
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

  /// here, Get booth panna status based on booth id
  Future getBoothPannasStatus(int boothID) async {
    try {
      emit(BoothPannasStatusLoadingState());
      final res = await api.getBoothPannasStatus(
          'Bearer ${StorageService.userAuthToken}', boothID);
      print(
          "------------------------------------ get Booth Panna Status ----------------------------");

      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        BoothPannasStatus data = BoothPannasStatus.fromJson(res.data);
        emit(BoothPannasStatusSuccessState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(BoothPannasStatusErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      emit(BoothPannasStatusErrorState('Something Went Wrong'));
    }
  }

  /// here, Get Panna Kramaank
  Future getPannaKramaankList(int boothID, int acId) async {
    try {
      emit(PannaKramaankLoadingState());
      final res = await api.getPannaKramaank(
          'Bearer ${StorageService.userAuthToken}', acId, boothID);
      print(
          "------------------------------------ Panna Kramaank ----------------------------");
      print("Url :${res.response.realUri}");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        IndependentDropdownModel data =
            IndependentDropdownModel.fromJson(res.data);
        emit(PannaKramaankSuccessState(data));
      } else {
        emit(PannaKramaankErrorState());
      }
    } catch (e) {
      emit(PannaKramaankErrorState());
    }
  }

  void onTapDeleteResonData(int? index, String? data) {
    emit(ChangingDeleteReasonState());
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
      EasyLoading.show();
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
          "------------------------------------  ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        Map<String, dynamic>? msg = res.data;
        dataList?.removeAt(index);
        emit(DeletePersonSuccessState(msg?['message']));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(DeletePersonErrorState(msg?['message'] ?? ''));
      }
    } catch (e) {
      emit(DeletePersonErrorState('Something Went Wrong'));
    } finally {
      EasyLoading.dismiss();
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

  void onSelectMorcha(UnitData data) {
    emit(LoadingState());

    morchaData = data;
    unitId = data.id;
    subUnitId = "";
    print('unitId=$unitId');
    print('subUnitId=$subUnitId');
    emit(ZilaChangedState());
  }

  Future<void> makePhoneCall({required String phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  onDataFound() {
    emit(LoadingState());
    emit(NoDataFoundState());
  }

  getUserOperationPermission(List<AppPermissions> appPermissions) {
    isEditPermission = false;
    isDeletePermission = false;
    isReadPermission = false;
    isCreatePermission = false;
    for (int i = 0; i < appPermissions.length; i++) {
      if (appPermissions[i].action == "Edit") {
        isEditPermission = true;
      } else if (appPermissions[i].action == "Create") {
        isCreatePermission = true;
      } else if (appPermissions[i].action == "Read") {
        isReadPermission = true;
      } else if (appPermissions[i].action == "Delete") {
        isDeletePermission = true;
      }
    }
  }
}
