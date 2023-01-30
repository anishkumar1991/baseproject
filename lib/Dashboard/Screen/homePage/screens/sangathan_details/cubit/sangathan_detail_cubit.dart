import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/cubit/sangathan_detail.state.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/network/api/sangathan_details_api.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/network/model/sangathan_data_model.dart';
import 'package:sangathan/storage/global_user_data.dart';

import '../network/model/alloted_location_model.dart';
import '../../../../../../storage/user_storage_service.dart';

class SangathanDetailsCubit extends Cubit<SangathanDetailsState> {
  SangathanDetailsCubit() : super(InitialStateState());
  final api = DataLevelApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  List<SangathanData> sangathanDataList = [];
  List<Locations> locationList = [];
  int? selectedId;
  int? dataLevelId;
  Future getSangathanDataLevel() async {
    try {
      emit(LoadingState());
      var res = await api.getDataLevel(
          'Bearer ${StorageService.userAuthToken}',
          'Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 5 Build/JOP40D)',
          true,
          1);
      print('sangathan Data =${res.response.statusCode}');
      if (res.response.statusCode == 200) {
        print(res.response.data);
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

  Future getAllotedLocations() async {
    try {
      emit(LoadingState());
      final respose =
          await api.allottedlocations('Bearer ${StorageService.userAuthToken}');
      print('Alloted locations res=${respose.response.statusCode}');
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

  void onSelectLocation(int id) {
    emit(LoadingState());
    selectedId = id;
    emit(LocationChoosedState());
  }

  void getDataLevelId(int? id) {
    emit(LoadingState());
    dataLevelId = id;
    emit(LocationChoosedState());
  }
}
