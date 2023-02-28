import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../../Storage/user_storage_service.dart';
import '../network/model/FetchPosts.dart';
import '../network/services/fetchposts/FetchPostsApi.dart';
import 'FetchPostsState.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());

  final api = FetchPostsApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));
  int page = 1;

  Future<void> loadPosts() async {
    if (state is PostsLoading) return;

    final currentState = state;

    var oldPosts = <Post>[];
    if (currentState is PostsLoaded) {
      oldPosts = currentState.posts;
    }

    emit(PostsLoading(oldPosts, isFirstFetch: page == 1 ? true : false));

    try {
      final res =
          await api.getPosts('Bearer ${StorageService.userAuthToken}', 5, page);
      if (res.response.statusCode == 200) {
        page++;
        print("api working");

        FetchPosts model = FetchPosts.fromJson(res.data);

        final posts = (state as PostsLoading).oldPosts;
        posts.addAll(model.posts);

        emit(PostsLoaded(posts));
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
