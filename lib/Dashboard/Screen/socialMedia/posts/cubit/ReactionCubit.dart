import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Storage/user_storage_service.dart';
import '../network/services/fetchposts/FetchPostsApi.dart';
import 'ReactionState.dart';

class ReactionCubit extends Cubit<ReactionState> {
  ReactionCubit() : super(ReactionInitialState());

  final api = FetchPostsApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future<void> sendReaction(String postId, String reaction) async {
    try {
      final res = await api.sendReaction(
          'Bearer ${StorageService.userAuthToken}',
          {"post_id": postId, "reaction": reaction});
      if (res.response.statusCode == 200) {
        emit(ReactionSend());
      } else {
        // State? model = States.fromJson(res.data);
        // emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      // LoginFaieldState(e.toString());
    }
  }


}
