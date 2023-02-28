import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../Storage/user_storage_service.dart';
import '../network/model/ReelsModel.dart';
import '../network/services/ReelsAPI.dart';
import 'ReelsState.dart';
import 'package:bloc/bloc.dart';

class ReelsCubit extends Cubit<ReelsState> {
  ReelsCubit() : super(PostsInitial());

  final api = ReelsAPI(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));
  int page = 1;

  Future<void> loadReel() async {
    if (state is PostsLoading) return;

    final currentState = state;

    var oldPosts = <Reel>[];
    if (currentState is PostsLoaded) {
      oldPosts = currentState.posts;
    }

    emit(PostsLoading(oldPosts, isFirstFetch: page == 1 ? true : false));

    try {
      final res =
          await api.getReels('Bearer ${StorageService.userAuthToken}', "30");
      if (res.response.statusCode == 200) {
        page++;
        print("api working");

        ReelsModel model = ReelsModel.fromJson(res.data);

        final posts = (state as PostsLoading).oldPosts;
        posts.addAll(model.reels);

        emit(PostsLoaded(posts));
      }
    } catch (e) {
      emit(ReelsErrorState());
    }
  }
}
