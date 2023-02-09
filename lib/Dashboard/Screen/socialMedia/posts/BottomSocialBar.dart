import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/cubit/ReactionState.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/share/Share.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/share/ShareOnWhatsapp.dart';

import 'cubit/FetchPostCubit.dart';
import 'cubit/ReactionCubit.dart';
import 'cubit/ShareCubit.dart';
import 'cubit/ShareState.dart';

class BottomSocialBar extends StatelessWidget {
  final int index;

  const BottomSocialBar({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit1 = context.read<FetchPostsCubit>();
    final cubit2 = context.read<ShareCubit>();
    final cubit3 = context.read<ReactionCubit>();

    var id = cubit1.tempModel!.posts[index].id.toString();
    var shareToAllCount = cubit1.tempModel!.posts[index].shares.other;
    var shareToWhatsapp = cubit1.tempModel!.posts[index].shares.whatsapp;
    var reactCount = cubit1.tempModel!.posts[index].reactions[0].count;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              // LikeButton(
              //   size: 40,
              //   circleColor: const CircleColor(
              //       start: Color(0xff00ddff), end: Color(0xff0099cc)),
              //   bubblesColor: const BubblesColor(
              //     dotPrimaryColor: Color(0xff33b5e5),
              //     dotSecondaryColor: Color(0xff0099cc),
              //   ),
              //   likeCount: cubit1.tempModel!.posts[index].reactions[0].count,
              //   likeBuilder: (isTapped) {
              //     isTapped ? cubit1.sendLike(id) : null;
              //     return Icon(
              //       Icons.thumb_up_alt,
              //       color: isTapped ? Colors.blue : Colors.grey,
              //     );
              //   },
              // )
              ReactionButton(
                boxPadding: const EdgeInsets.all(12),
                boxReactionSpacing: 7,
                boxElevation: 10,
                itemScale: 0.2,
                onReactionChanged: (reaction) async {
                  if (reaction == 1) {
                    await cubit3.sendReaction(id, "like");
                  } else if (reaction == 2) {
                    await cubit3.sendReaction(id, "love");
                  } else if (reaction == 3) {
                    await cubit3.sendReaction(id, "wow");
                  } else if (reaction == 4) {
                    await cubit3.sendReaction(id, "sad");
                  } else if (reaction == 5) {
                    await cubit3.sendReaction(id, "angry");
                  }
                  print('reaction changed at $reaction');
                },
                reactions: [
                  Reaction(
                    title: Text(cubit1
                        .tempModel!.posts[index].reactions[1].reaction.name
                        .toString()),
                    icon: Image.asset("assets/images/likeicon.png", height: 35),
                    value: 1,
                  ),
                  Reaction(
                    title: Text(cubit1
                        .tempModel!.posts[index].reactions[2].reaction.name
                        .toString()),
                    icon:
                        Image.asset("assets/images/hearticon.png", height: 35),
                    value: 2,
                  ),
                  Reaction(
                    title: Text(cubit1
                        .tempModel!.posts[index].reactions[3].reaction.name
                        .toString()),
                    icon: Image.asset("assets/images/wowicon.png", height: 35),
                    value: 3,
                  ),
                  Reaction(
                    title: Text(cubit1
                        .tempModel!.posts[index].reactions[4].reaction.name
                        .toString()),
                    icon: Image.asset("assets/images/sadicon.png", height: 35),
                    value: 4,
                  ),
                  Reaction(
                    title: Text(cubit1
                        .tempModel!.posts[index].reactions[5].reaction.name
                        .toString()),
                    icon:
                        Image.asset("assets/images/angryicon.png", height: 35),
                    value: 5,
                  ),
                ],
              ),
              const SizedBox(width: 10),
              BlocBuilder<ReactionCubit, ReactionState>(
                builder: (context, state) {
                  if (state is ReactionSend) {
                    reactCount = reactCount + 1;
                    return Text(reactCount.toString());
                  }
                  return Text(reactCount.toString());
                },
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    cubit2.shareToAll(id);
                    share(context, index);
                  },
                  icon: const Icon(Icons.share_outlined)),
              BlocBuilder<ShareCubit, ShareState>(
                builder: (context, state) {
                  if (state is SharedToAll) {
                    shareToAllCount = shareToAllCount + 1;
                    return Text(shareToAllCount.toString());
                  }
                  return Text(shareToAllCount.toString());
                },
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                cubit2.shareToWhatsapp(id);
                shareOnWhatsapp(context, SocialMedia.whatsapp, index);
              },
              icon: const Icon(FontAwesomeIcons.whatsapp,
                  color: Color(0xFF1FAF38)),
            ),
            BlocBuilder<ShareCubit, ShareState>(
              builder: (context, state) {
                if (state is SharedToWhatsapp) {
                  shareToWhatsapp = shareToWhatsapp + 1;
                  return Text(shareToWhatsapp.toString());
                }
                return Text(shareToWhatsapp.toString());
              },
            ),
          ],
        ),
      ],
    );
  }
}
