import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/cubit/PollsState.dart';
import '../../../../../Storage/user_storage_service.dart';
import '../network/services/FetchPostsApi.dart';

class PollCubit extends Cubit<PollState> {
  PollCubit() : super(InitialPollState());

  final api = FetchPostsApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future<void> submitPoll(int pollId, int optionId) async {
    try {
      final res = await api.submitPoll('Bearer ${StorageService.userAuthToken}',
          {"poll_id": pollId, "option_id": optionId});
      if (res.response.statusCode == 200) {
        print("poll submitted");
        emit(PollChoosed());
      } else {
        print("not api");
      }
    } on Exception catch (e) {
      print(e.toString());
      // LoginFaieldState(e.toString());
    }
  }
}
