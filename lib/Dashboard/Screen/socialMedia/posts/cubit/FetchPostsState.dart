import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../network/model/FetchPosts.dart';

@immutable
abstract class FetchPostsState {}

class PostsInitial extends FetchPostsState {}

class PostsLoaded extends FetchPostsState {
  final List<Post> posts;

  PostsLoaded(this.posts);
}

class PostsLoading extends FetchPostsState {
  final List<Post> oldPosts;
  final bool isFirstFetch;

  PostsLoading(this.oldPosts, {this.isFirstFetch = false});
}

class ReactionSendState extends FetchPostsState {}
