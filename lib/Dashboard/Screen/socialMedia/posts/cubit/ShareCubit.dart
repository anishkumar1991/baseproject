import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Storage/user_storage_service.dart';
import '../network/services/FetchPostsApi.dart';
import 'ShareState.dart';

class ShareCubit extends Cubit<ShareState> {
  ShareCubit() : super(InitialShareState());

  final api = FetchPostsApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future<void> shareToAll(String postId) async {
    try {
      final res = await api.share('Bearer ${StorageService.userAuthToken}',
          {"post_id": postId, "is_whatsapp": false});
      if (res.response.statusCode == 200) {
        emit(SharedToAll());
        print("share to all api working");
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

  Future<void> shareToWhatsapp(String postId) async {
    try {
      final res = await api.share('Bearer ${StorageService.userAuthToken}',
          {"post_id": postId, "is_whatsapp": true});
      if (res.response.statusCode == 200) {
        emit(SharedToWhatsapp());
        print("whatsapp sharing working");
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
