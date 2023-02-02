import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class YoutubeCard extends StatelessWidget {
  const YoutubeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: '6M3zfM-LO34',
      flags: const YoutubePlayerFlags(enableCaption: false, autoPlay: false),
    );
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: YoutubePlayer(
        width: MediaQuery.of(context).size.width,
        controller: _controller,
        showVideoProgressIndicator: true,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        thumbnail: Image.asset(
          "assets/images/modiji.png",
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
