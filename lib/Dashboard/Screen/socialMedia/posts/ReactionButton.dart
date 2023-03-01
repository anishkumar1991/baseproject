import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

import 'cubit/FetchPostCubit.dart';
import 'cubit/ReactionCubit.dart';
import 'network/model/FetchPosts.dart';

class CustomReactionButton extends StatelessWidget {
  final int index;
  final String id;
  final List<Post> item;

  const CustomReactionButton(
      {Key? key, required this.index, required this.id, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReactionCubit>();

    return ReactionButton(
      boxPadding: const EdgeInsets.all(8),
      boxReactionSpacing: 5,
      boxElevation: 10,
      itemScale: 0.2,
      onReactionChanged: (reaction) async {
        Timer(const Duration(seconds: 1), () {
          sendReaction(reaction!, cubit);
          print("Yeah, this line is printed after 3 seconds");
        });
      },
      initialReaction: Reaction(
        icon: ownReaction(),
        value: 0,
      ),
      reactions: [
        Reaction(
          title: Text(item[index].reactions[1].reaction.name.toString()),
          icon: const Icon(Icons.thumb_up_alt_sharp,
              color: Colors.blue, size: 27),
          value: 1,
        ),
        Reaction(
          title: Text(item[index].reactions[2].reaction.name.toString()),
          icon: Image.asset("assets/images/hearticon.png", height: 32),
          value: 2,
        ),
        Reaction(
          title: Text(item[index].reactions[3].reaction.name.toString()),
          icon: Image.asset("assets/images/wowicon.png", height: 32),
          value: 3,
        ),
        Reaction(
          title: Text(item[index].reactions[4].reaction.name.toString()),
          icon: Image.asset("assets/images/sadicon.png", height: 32),
          value: 4,
        ),
        Reaction(
          title: Text(item[index].reactions[5].reaction.name.toString()),
          icon: Image.asset("assets/images/angryicon.png", height: 31),
          value: 5,
        ),
      ],
    );
  }

  Future<void> sendReaction(int reaction, ReactionCubit cubit) async {
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
  }

  Widget ownReaction() {
    if (item[index].myReaction!.reaction.name == "LIKE") {
      return const Icon(Icons.thumb_up_alt_sharp, color: Colors.blue, size: 27);
    } else if (item[index].myReaction!.reaction.name == "LOVE") {
      return Image.asset("assets/images/hearticon.png", height: 32);
    } else if (item[index].myReaction!.reaction.name == "WOW") {
      return Image.asset("assets/images/wowicon.png", height: 32);
    } else if (item[index].myReaction!.reaction.name == "SAD") {
      return Image.asset("assets/images/sadicon.png", height: 32);
    } else if (item[index].myReaction!.reaction.name == "ANGRY") {
      return Image.asset("assets/images/angryicon.png", height: 31);
    } else {
      return SizedBox();
    }
  }
}
