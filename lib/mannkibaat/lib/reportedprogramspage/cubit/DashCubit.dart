import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Storage/user_storage_service.dart';
import '../network/model/dash_model.dart';
import '../network/services/DashApi.dart';
import 'DashState.dart';

class DashCubit extends Cubit<DashStates> {
  DashCubit() : super(DashInitialState());

  final api = DashApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future getDashData(String authenticationToken) async {
    emit(DashLoadingState());
    try {
      print(" i am here $authenticationToken");
      final res = await api.getEvents('Bearer $authenticationToken');
      print(res.response.requestOptions.uri);

      print('RESPONSE OF NEW CALL=${res.response.statusCode}');

      print(res.data);
      if (res.response.statusCode == 200) {
        DashModal model = DashModal.fromJson(res.data);
        emit(DashGotEventsState(model));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(DashErrorState(msg?['error'] ?? ''));
      }
    } catch (e) {
      emit(DashErrorState(e.toString()));
    }
  }
}

//------------------------------------------------------------------------------------

// class DashCubit extends Cubit<DashStates> {
//   final DashRepo _dr;
//
//   DashCubit(this._dr) : super(DashInitialState());
//
//   Future<void> fetchEvents() async {
//     emit(DashLoadingState());
//     try {
//       final response = await _dr.getEvents();
//       emit(DashGotEventsState(response));
//     } catch (e) {
//       emit(DashErrorState(e.toString()));
//     }
//   }
// }
