import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/cubit/FetchPostCubit.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/socialcards/ImageCard.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/socialcards/YoutubeCard.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'BottomSocialBar.dart';

class CustomCard extends StatelessWidget {
  final int tempkey;
  final int? index;

  const CustomCard({Key? key, required this.tempkey, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit1 = context.read<FetchPostsCubit>();
    final String tempurl =
        "https://storage.googleapis.com/dev-saral-bucket/voiyh8yh3p4jq16572icjqswiwbe?GoogleAccessId=949025725562-compute%40developer.gserviceaccount.com&Expires=1706884893&Signature=f0YU%2Bc7%2FFKZY03TfbVhBEzaouDweD%2BKHinMa5TII9zVMb8j1oiTZv217AcsVp%2FLrapIF2IHFFUsq261rQzqckwRN5FWLHB%2FMJ9YZTG9%2B2nikfa5WkJdEBrJssEsT0lGBoptNDFnaBVe%2F4bgZFx6mHD%2Fqp9jcJ2Eaga9ZcntABhlJXILbfAjheLF63PwsavPc0DXtijlZ%2B8qnVfpEPRkrtfyWAklh5cHPlzwTHK3ebvzar%2B6vKKT9n13K5RD5B0q9RIUsl0r8%2BdJQ0mnvU%2FgDqIFLwykxRyQmveciDSzew0rd5NjeFWodM68R%2Ft9FaUpIx%2FLL4auw1bLiFaf%2FphQ9%2FQ%3D%3D&response-content-disposition=inline%3B+filename%3D%223+%25281%2529.jpg%22%3B+filename%2A%3DUTF-8%27%273%2520%25281%2529.jpg&response-content-type=image%2Fpng";
    final cubit = context.read<ThumbCubit>();
    late int temp = 0;
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: '6M3zfM-LO34',
      flags: const YoutubePlayerFlags(enableCaption: false, autoPlay: false),
    );
    return Container(
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(16),
        //     border: Border.all(color: const Color(0xFFE6E6E6), width: 1)),
        child: Column(
      children: [
        tempkey == 1 ? const YoutubeCard() : const Text(""),
        tempkey == 2 ? ImageCard(index: index) : const Text(""),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 20, top: 10),
          child: Text(
            cubit1.tempModel!.posts[index!].title.toString(),
            style: TextStyle(
                fontFamily: 'TwCenMT',
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 16, right: 20, top: 14),
            child: ReadMoreText(
              cubit1.tempModel!.posts[index!].caption.toString(),
              trimMode: TrimMode.Line,
              trimLines: 2,
              style: TextStyle(
                  fontFamily: 'TwCenMT',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey),
              trimCollapsedText: 'More',
              trimExpandedText: 'Less',
              lessStyle: TextStyle(
                  fontFamily: 'TwCenMT',
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
              moreStyle: TextStyle(
                  fontFamily: 'TwCenMT',
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            )),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 10, 20, 10),
          child: BottomSocialBar(url: tempurl, index: index!),
        )
      ],
    ));
          children: [
            tempkey == 2 ? ImageCard(index: index) : const Text(""),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 20, top: 10),
              child: Text(
                cubit1.tempModel!.posts[index!].title.toString(),
                style: const TextStyle(
                    fontFamily: 'TwCenMT',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 16, right: 20, top: 14),
                child: ReadMoreText(
                  cubit1.tempModel!.posts[index!].caption.toString(),
                  trimMode: TrimMode.Line,
                  trimLines: 2,
                  style: const TextStyle(
                      fontFamily: 'TwCenMT',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey),
                  trimCollapsedText: 'More',
                  trimExpandedText: 'Less',
                  lessStyle: const TextStyle(
                      fontFamily: 'TwCenMT',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                  moreStyle: const TextStyle(
                      fontFamily: 'TwCenMT',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 10, 20, 10),
              child: BottomSocialBar(index: index!),
            )
          ],
        ));
  }
}
