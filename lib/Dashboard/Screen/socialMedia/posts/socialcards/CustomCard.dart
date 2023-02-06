import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../BottomSocialBar.dart';
import '../cubit/FetchPostCubit.dart';
import 'ImageCard.dart';

class CustomCard extends StatelessWidget {
  final int tempkey;
  final int? index;

  const CustomCard({Key? key, required this.tempkey, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit1 = context.read<FetchPostsCubit>();

    // final YoutubePlayerController _controller = YoutubePlayerController(
    //   initialVideoId: '6M3zfM-LO34',
    //   flags: const YoutubePlayerFlags(enableCaption: false, autoPlay: false),
    // );
    return Card(
        elevation: 2,
        child: Column(
          children: [
            tempkey == 2 ? ImageCard(index: index) : const Text(""),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 20, top: 10),
              child: Text(
                cubit1.tempModel!.posts[index!].title.toString(),
                style: const TextStyle(
                    fontFamily: 'TwCenMT',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 16, right: 20, top: 14),
                child: ReadMoreText(
                  cubit1.tempModel!.posts[index!].caption.toString(),
                  trimMode: TrimMode.Line,
                  trimLines: 2,
                  style: const TextStyle(
                      fontFamily: 'Tw Cen MT',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey),
                  trimCollapsedText: 'More',
                  trimExpandedText: 'Less',
                  lessStyle: const TextStyle(
                      fontFamily: 'Tw Cen MT',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                  moreStyle: const TextStyle(
                      fontFamily: 'Tw Cen MT',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 20, 10),
              child: BottomSocialBar(index: index!),
            )
          ],
        ));
  }
}
