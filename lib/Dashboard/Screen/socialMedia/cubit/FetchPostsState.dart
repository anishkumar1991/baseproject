import 'package:equatable/equatable.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/network/model/FetchPosts.dart';

abstract class FetchPostsState extends Equatable{
  @override
  List<Object> get props => [];
}

class InitialFetchPostState extends FetchPostsState{}

class FetchingPostsState extends FetchPostsState{}

class PostsFetchedState extends FetchPostsState{
  final FetchPosts model;
  PostsFetchedState(this.model);
}



