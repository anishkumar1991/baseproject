import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/cubit/sangathan_detail.state.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/network/api/sangathan_details_api.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/network/model/sangathan_data_model.dart';

import '../../../../../../Storage/user_storage_service.dart';
import '../../zila_data_page/network/model/independent_drodown_model.dart';
import '../network/model/ClientAppPermissionModel.dart';
import '../network/model/alloted_location_model.dart';

class SangathanDetailsCubit extends Cubit<SangathanDetailsState> {
  SangathanDetailsCubit() : super(InitialStateState());
  final api = DataLevelApi(Dio(BaseOptions(contentType: 'application/json', validateStatus: ((status) => true))));

  List<SangathanData?> sangathanDataList = [];
  AllotedLocationModel? allotedLocationModel;
  List<AppPermissions>? appPermissions;
  bool isShowShaktiKendra = false;
  String? typeLevelName;
  Locations? selectedAllottedLocation;
  String? clientId;
  int? permissionId;

  /// TODO: Here change country id
  int countryStateId = 14;
  int? dataLevelId;

  Future getClientAppPermission(String clientId) async {
    try {
      emit(LoadingState());
      var res = await api.getClientAppPermission('Bearer ${StorageService.userAuthToken}', clientId);
      print("------------------------------------ Get CLient App Permission-------------------------");
      print("url :${res.response.realUri}");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print("------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        ClientAppPermissionModel data = ClientAppPermissionModel.fromJson(res.data);

        emit(ClientAppPermissionsFetchState(data));
      } else {
        print('error=${res.data['message']}');
        emit(ErrorState(res.data['message']));
      }
    } catch (e) {
      print(e.toString());
      emit(ErrorState('Something Went Wrong'));
    }
  }

  Future getSangathanDataLevel() async {
    try {
      emit(LoadingState());
      var res = await api.getDataLevel('Bearer ${StorageService.userAuthToken}',
          'Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 5 Build/JOP40D)', true, 1);
      print("------------------------------------ Get Data Level ----------------------------");
      print("url :${res.response.realUri}");
      print("Status code : ${res.response.statusCode}");
      print(StorageService.userAuthToken);
      print("Response :${res.data}");
      print("------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        SangthanDataModel data = SangthanDataModel.fromJson(res.data);
        emit(DataLevelFetchedState(data));
      } else {
        print('error=${res.data['message']}');
        emit(ErrorState(res.data['message']));
      }
    } catch (e) {
      emit(ErrorState('Something Went Wrong'));
    }
  }

  Future getAllotedLocations({required String clientId, required String permissionId}) async {
    try {
      emit(LoadingState());
      final respose = await api.allottedlocations('Bearer ${StorageService.userAuthToken}', clientId, permissionId);
      print("------------------------------------ Get Allotted location ----------------------------");

      print("Status code : ${respose.response.statusCode}");
      print("Response :${respose.data}");
      print("url :${respose.response.realUri}");
      print("------------------------------------ ------------------------ ----------------------------");
      if (respose.response.statusCode == 200) {
        AllotedLocationModel data = AllotedLocationModel.fromJson(respose.data);
        emit(LocationFetchedState(data));
      } else {
        emit(ErrorState(respose.data['message']));
      }
    } catch (e) {
      ErrorState('Something Went Wrong');
    }
  }

  void onSelectAllottedLocation(Locations selectedLocation) {
    emit(LoadingState());
    selectedAllottedLocation = selectedLocation;
    emit(LocationChoosedState());
  }

  void getDataLevelId(int? id) {
    emit(LoadingState());
    dataLevelId = id;
    emit(LocationChoosedState());
  }
}
