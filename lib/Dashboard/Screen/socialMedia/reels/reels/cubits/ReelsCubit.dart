import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../network/model/ReelsModel.dart';
import '../network/services/ReelsAPI.dart';
import 'ReelsState.dart';

class ReelsCubit extends Cubit<ReelsState> {
  ReelsCubit() : super(ReelsInitialState());

  final api = ReelsAPI(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future getReelsData() async {
    emit(ReelsLoadingState());

    try {
      String? token =
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiVG9NSDhudmI3MjloUHlpTXpLNDdoUU5jIn0.k75ssSFfj32l5q0MQSDn7dTeYdeUe1REW7ZzQfv4xR8";
      final res = await api.getReels('Auth $token');
      print(
          'URL Is Here------------------------->${res.response.requestOptions.uri}');
      print(
          'Status Code Is Here------------------------->${res.response.statusCode}');
      print('Data is Here------------------------->${res.data}');
      if (res.response.statusCode == 200) {
        ReelsModel model = ReelsModel.fromJson(res.data);
        print('here is the model data from api---->${res.response.data}');
        emit(ReelsFetchedState(model));
      } else {
        emit(ReelsErrorState());
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
