import 'package:equatable/equatable.dart';
import '../network/model/FetchPosts.dart';

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

class ReactionSendState extends FetchPostsState{}



