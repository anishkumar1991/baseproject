import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/mannKiBaat/Utils/AppColor.dart';
import 'package:video_player/video_player.dart';

import '../cubit/FetchPostCubit.dart';

class ShowVideoCard extends StatefulWidget {
  final int? index;

  const ShowVideoCard({super.key, required this.index});

  @override
  _ShowVideoCardState createState() => _ShowVideoCardState();
}

class _ShowVideoCardState extends State<ShowVideoCard> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future initializePlayer() async {
    final cubit = context.read<FetchPostsCubit>();

    _videoPlayerController = VideoPlayerController.network(
        cubit.tempModel!.posts[widget.index!].postData.video.toString());
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(

      videoPlayerController: _videoPlayerController,
      showControls: true,
      hideControlsTimer: const Duration(seconds: 3),
      allowPlaybackSpeedChanging: false,
      materialProgressColors: ChewieProgressColors(backgroundColor: Colors.orangeAccent,playedColor: Colors.white),
      autoInitialize: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized) {
      return Container(
        decoration: const BoxDecoration(color: Colors.black),
        height: 300,
        child: Chewie(
          controller: _chewieController!,
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(child: CircularProgressIndicator()),
        ],
      );
    }
  }
}
