import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'LikeIcon.dart';
import 'Options.dart';

class ContentScreen extends StatefulWidget {
  final String? src;
  final String title;
  final String views;
  final int index;

  const ContentScreen(
      {Key? k, required this.title, required this.views, this.src, required this.index});

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  ScrollController _controller = ScrollController();

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  void _onScrollEvent() {
    final extentAfter = _controller.position.extentAfter;
    print("Extent after: $extentAfter");
    if (extentAfter < 300) {
      // Load new items
      print("-----------SHOWING AFTER SWIPPING${_videoPlayerController.value.position}");
    }
  }

  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.src!);
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
    print("--------URL ------->${widget.src}");
    return Stack(
      fit: StackFit.expand,

      children: [
        _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
            ? GestureDetector(
          onTap: () {
                  print(
                      "--------------->${_videoPlayerController.value.position}");
                },
                child: AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: Chewie(
                    controller: _chewieController!,
                  ),
                ),
              )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Fetching Videos...')
                ],
              ),
        if (_liked)
          Center(
            child: LikeIcon(),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: OptionsScreen(
            title: widget.title,
            views: widget.views,
            index: widget.index,
          ),
        )
      ],
    );
  }
}
