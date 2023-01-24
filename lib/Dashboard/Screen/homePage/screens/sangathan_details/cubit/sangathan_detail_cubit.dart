import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/cubit/sangathan_detail.state.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/network/api/sangathan_details_api.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/network/model/sangathan_data_model.dart';

import '../network/model/alloted_location_model.dart';
import '../../../../../../storage/user_storage_service.dart';

class SangathanDetailsCubit extends Cubit<SangathanDetailsState> {
  SangathanDetailsCubit() : super(InitialStateState());
  final api = DataLevelApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  List<SangathanData> sangathanDataList = [];
  List<Locations> locationList = [];
  Future getSangathanDataLevel() async {
    try {
      emit(LoadingState());
      String? token = StorageService.getUserAuthToken();
      var res = await api.getDataLevel('Bearer $token',
          'Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 5 Build/JOP40D)');
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
      emit(ErrorState(e.toString()));
    }
  }

  Future getAllotedLocations() async {
    try {
      emit(LoadingState());
      String token = StorageService.getUserAuthToken() ?? '';
      final respose = await api.allottedlocations('Bearer $token');
      print('Alloted locations res=${respose.response.statusCode}');
      if (respose.response.statusCode == 200) {
        AllotedLocationModel data = AllotedLocationModel.fromJson(respose.data);
        emit(LocationFetchedState(data));
      } else {
        emit(ErrorState('Something Went Wrong'));
      }
    } catch (e) {
      ErrorState(e.toString());
    }
  }
}
