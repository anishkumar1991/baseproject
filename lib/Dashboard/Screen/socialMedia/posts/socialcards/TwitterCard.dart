import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

import '../cubit/FetchPostCubit.dart';

class CustomCardTwitter extends StatelessWidget {
  final int index;
  var temp;

  CustomCardTwitter({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FetchPostsCubit>();
    cubit.fetchTweets(index);
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE6E6E6), width: 1)),
        child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    child: Image.network(
                      cubit.tweeturl!,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 20, top: 10),
                    child: ReadMoreText(
                      cubit.tweettext!,
                      trimMode: TrimMode.Line,
                      trimLines: 2,
                      style: const TextStyle(
                        fontFamily: 'TwCenMT',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      trimCollapsedText: 'More',
                      trimExpandedText: 'Less',
                      lessStyle: const TextStyle(
                          fontFamily: 'TwCenMT',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                      moreStyle: const TextStyle(
                          fontFamily: 'TwCenMT',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 10, 20, 10),
                    // child: BottomSocialBar(),
                  )
                ],
              ));
  }
}
