import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

import 'cubit/FetchPostCubit.dart';
import 'cubit/ReactionCubit.dart';

class CustomReactionButton extends StatelessWidget {
  final int index;
  final String id;

  const CustomReactionButton({Key? key, required this.index, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReactionCubit>();
    final cubit1 = context.read<FetchPostsCubit>();

    return ReactionButton(
      boxPadding: const EdgeInsets.all(8),
      boxReactionSpacing: 5,
      boxElevation: 10,
      itemScale: 0.2,
      onReactionChanged: (reaction) async {
        if (reaction == 1) {
          await cubit.sendReaction(id, "like");
        } else if (reaction == 2) {
          await cubit.sendReaction(id, "love");
        } else if (reaction == 3) {
          await cubit.sendReaction(id, "wow");
        } else if (reaction == 4) {
          await cubit.sendReaction(id, "sad");
        } else if (reaction == 5) {
          await cubit.sendReaction(id, "angry");
        }
      },
      initialReaction: Reaction(
        icon: const Icon(Icons.thumb_up_alt_sharp, size: 27),
        value: 0,
      ),
      reactions: [
        Reaction(
          title: Text(cubit1.tempModel!.posts[index].reactions[1].reaction.name
              .toString()),
          icon: const Icon(Icons.thumb_up_alt_sharp,
              color: Colors.blue, size: 27),
          value: 1,
        ),
        Reaction(
          title: Text(cubit1.tempModel!.posts[index].reactions[2].reaction.name
              .toString()),
          icon: Image.asset("assets/images/hearticon.png", height: 32),
          value: 2,
        ),
        Reaction(
          title: Text(cubit1.tempModel!.posts[index].reactions[3].reaction.name
              .toString()),
          icon: Image.asset("assets/images/wowicon.png", height: 32),
          value: 3,
        ),
        Reaction(
          title: Text(cubit1.tempModel!.posts[index].reactions[4].reaction.name
              .toString()),
          icon: Image.asset("assets/images/sadicon.png", height: 32),
          value: 4,
        ),
        Reaction(
          title: Text(cubit1.tempModel!.posts[index].reactions[5].reaction.name
              .toString()),
          icon: Image.asset("assets/images/angryicon.png", height: 31),
          value: 5,
        ),
      ],
    );
  }
}
