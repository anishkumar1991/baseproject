import '../network/model/ReelsModel.dart';

abstract class ReelsState {}

class PostsInitial extends ReelsState {}
class PostsLoaded extends ReelsState {
  final List<Reel> posts;

  PostsLoaded(this.posts);
}

class PostsLoading extends ReelsState {
  final List<Reel> oldPosts;
  final bool isFirstFetch;

  PostsLoading(this.oldPosts, {this.isFirstFetch=false});
}

class ReelsErrorState extends ReelsState{}