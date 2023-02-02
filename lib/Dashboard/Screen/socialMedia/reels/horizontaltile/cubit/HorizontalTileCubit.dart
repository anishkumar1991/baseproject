import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/model/HorizontalTileModel.dart';
import '../network/service/HorizontalTileAPI.dart';
import 'HorizontalTileState.dart';

class HorizontalTileCubit extends Cubit<HorizontalTileState> {
  HorizontalTileCubit() : super(HorizontalTileInitialState());

  final api = HorizontalTileAPI(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future getData() async {
    try {
      String? token =
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiVG9NSDhudmI3MjloUHlpTXpLNDdoUU5jIn0.k75ssSFfj32l5q0MQSDn7dTeYdeUe1REW7ZzQfv4xR8";
      final res = await api.getReels('Bearer $token');
      print(res.response.requestOptions.uri);
      print('RESPONSE OF NEW CALL=${res.response.statusCode}');
      print(res.data);
      if (res.response.statusCode == 200) {
        HorizontalTileModel model = HorizontalTileModel.fromJson(res.data);
        print(model.success);
        emit(HorizontalTileFetchedState(model));
      } else {
        emit(HorizontalTileError());
      }
    } catch (e) {
      emit(HorizontalTileError());
    }
  }
}
