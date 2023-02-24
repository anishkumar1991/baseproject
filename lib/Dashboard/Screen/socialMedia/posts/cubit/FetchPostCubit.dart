import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Storage/user_storage_service.dart';
import '../network/model/FetchPosts.dart';
import '../network/services/fetchposts/FetchPostsApi.dart';
import 'FetchPostsState.dart';

//
// class FetchPostsCubit extends Cubit<FetchPostsState> {
//   String? twitterId;
//   FetchPosts? tempModel;
//   String? tweeturl;
//   String? tweettext;
//
//   FetchPostsCubit() : super(InitialFetchPostState());
//   final api = FetchPostsApi(Dio(BaseOptions(
//       contentType: 'application/json', validateStatus: ((status) => true))));
//
//   int? page =1;
//
//
//   Future<void> fetchPosts() async {
//     emit(FetchingPostsState());
//     try {
//       final res = await api.getPosts(
//           'Bearer ${StorageService.userAuthToken}', {"size" : "10", "page" : page.toString()});
//       if (res.response.statusCode == 200) {
//         print("fetching post api working");
//
//         FetchPosts model = FetchPosts.fromJson(res.data);
//         tempModel = model;
//         emit(PostsFetchedState(model));
//
//         tempModel = model;
//
// // toString of Response's body is assigned to jsonDataString
//       } else {
//         print("fethcing post api not working ");
//         // State? model = States.fromJson(res.data);
//         // emit(LoginFaieldState(model.message ?? ''));
//       }
//     } on Exception catch (e) {
//       print(e.toString());
//       // LoginFaieldState(e.toString());
//     }
//   }
// }

class FetchPostsCubit extends Cubit<FetchPostsState> {
  FetchPostsCubit() : super(PostsInitial());
  final api = FetchPostsApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));
  int page = 1;
  String? twitterId;
  FetchPosts? tempModel;
  String? tweeturl;
  String? tweettext;

  Future<void> loadPosts() async {
    if (state is PostsLoading) return;

    final currentState = state;

    var oldPosts = <Post>[];
    if (currentState is PostsLoaded) {
      oldPosts = currentState.posts;
    }

    emit(PostsLoading(oldPosts, isFirstFetch: page == 1));

    try {
      final res = await api.getPosts('Bearer ${StorageService.userAuthToken}',
          {"size": "10", "page": page.toString()});
      if (res.response.statusCode == 200) {
        print("fetching post api working");

        FetchPosts model = FetchPosts.fromJson(res.data);
        tempModel = model;
        List<Post> a = tempModel!.posts;

        page++;

        final posts = (state as PostsLoading).oldPosts;
        posts.addAll(a);

        emit(PostsLoaded(posts));

        tempModel = model;
      } else {
        print("fethcing post api not working ");
        // State? model = States.fromJson(res.data);
        // emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      print(e.toString());
      // LoginFaieldState(e.toString());
    }
  }
}
