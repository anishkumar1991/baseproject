import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

import '../network/model/ReelsModel.dart';
import 'LikeIcon.dart';
import 'Options.dart';

class ContentScreen extends StatefulWidget {
  final String src;
  final String title;
  final String views;
  final int index;
  final String id;
  final List<Reel> item;

  const ContentScreen(
      {super.key,
      Key? k,
      required this.title,
      required this.views,
      required this.src,
      required this.index,
      required this.id, required this.item});

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  final bool _liked = false;
  bool _isCached = false;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future initializePlayer() async {
    final cacheManager = DefaultCacheManager();
    final fileInfo =
        (!mounted) ? null : await cacheManager.getFileFromCache(widget.src);
    var isCached = fileInfo?.validTill.isAfter(DateTime.now()) ?? false;

    if (isCached) {
      isCached = true;
      _videoPlayerController = VideoPlayerController.file(fileInfo!.file);
    } else {
      _videoPlayerController = VideoPlayerController.network(widget.src);
      await cacheManager.downloadFile(widget.src);
    }
    // final cacheManager = DefaultCacheManager();
    // final file = await cacheManager.getSingleFile(widget.src);
    await Future.wait([_videoPlayerController.initialize()]);
    setState(() {});
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: true,
      autoInitialize: true,
      aspectRatio: 10 / 20,
    );
  }

  @override
  deactivate();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? GestureDetector(
                onTap: () {},
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
            item: widget.item,
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

  @override
  void dispose() {
    _videoPlayerController.dispose();
    // _videoPlayerController.pause();

    _videoPlayerController.setVolume(0);
    _chewieController = null;
    _chewieController?.dispose();

    // _chewieController?.allowMuting;
    // _chewieController?.pause();
    _chewieController?.setVolume(0);
    super.dispose();
  }
}
