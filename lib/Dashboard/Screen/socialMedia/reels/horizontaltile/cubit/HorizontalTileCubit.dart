import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../Storage/user_storage_service.dart';
import '../network/model/HorizontalTileModel.dart';
import '../network/service/HorizontalTileAPI.dart';
import 'HorizontalTileState.dart';

class HorizontalTileCubit extends Cubit<HorizontalTileState> {
  HorizontalTileCubit() : super(HorizontalTileInitialState());

  final api = HorizontalTileAPI(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future getData() async {
    emit(HorizontalTileLoading());
    try {
      final res =
          await api.getReels('Bearer ${StorageService.userAuthToken}', "100");
      print(res.response.requestOptions.uri);
      print('RESPONSE OF NEW CALL=${res.response.statusCode}');
      print(res.data);
      if (res.response.statusCode == 200) {
        HorizontalTileModel model = HorizontalTileModel.fromJson(res.data);
        print(model.success);
        emit(HorizontalTileFetchedState(model));
      } else {
        emit(HorizontalTileError("Something went wrong!"));
      }
    } catch (e) {
      emit(HorizontalTileError("Something went wrong!"));
    }
  }
}
