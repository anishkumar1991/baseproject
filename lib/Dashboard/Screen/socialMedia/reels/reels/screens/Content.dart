import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'LikeIcon.dart';
import 'Options.dart';

class ContentScreen extends StatefulWidget {
  final String src;
  final String title;
  final String views;
  final int index;
  final String id;

  const ContentScreen(
      {super.key,
      Key? k,
      required this.title,
      required this.views,
      required this.src,
      required this.index,
      required this.id});

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  final bool _liked = false;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }


  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.src);
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: true,
      autoInitialize: true,
      aspectRatio: 10 / 20,
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
    return Stack(
      fit: StackFit.expand,
      children: [
        _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? GestureDetector(
                onTap: () {
                },
                child: Chewie(
                  controller: _chewieController!,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                ],
              ),
        if (_liked)
          const Center(
            child: LikeIcon(),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: OptionsScreen(
            id: widget.id,
            title: widget.title,
            views: widget.views,
            index: widget.index,
            src: widget.src,
          ),
        )
      ],
    );
  }
}
