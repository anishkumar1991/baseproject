import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Storage/user_storage_service.dart';

import '../network/model/ViewCountModel.dart';
import '../network/services/ViewCountAPI.dart';
import 'ViewCountState.dart';

class ViewCountCubit extends Cubit<ViewCountState> {
  String? viewCount;
  ViewCountModel? tempModel;

  ViewCountCubit() : super(ViewCountInitialState());
  final api = ViewCountAPI(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future<void> sendViewData(String postId, String duration) async {
    try {
      final res = await api.sendViews('Bearer ${StorageService.userAuthToken}',
          {"post_id": postId, "duration_in_sec": "2"});
      if (res.response.statusCode == 200) {
        print("VIEWS COUNT button api working");
      } else {
        print("not api");
        // State? model = States.fromJson(res.data);
        // emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      print(e.toString());
      // LoginFaieldState(e.toString());
    }
  }
}
