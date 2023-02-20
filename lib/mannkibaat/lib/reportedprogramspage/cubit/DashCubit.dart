import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Storage/user_storage_service.dart';
import '../network/model/dash_model.dart';
import '../network/services/DashApi.dart';
import 'DashState.dart';

class DashCubit extends Cubit<DashStates> {
  final String authenticationToken;
  DashCubit(this.authenticationToken) : super(DashInitialState());

  final api = DashApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future getDashData() async {
    emit(DashLoadingState());
    try {

      String? token = authenticationToken;
      final res = await api.getEvents('Bearer $token');
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
