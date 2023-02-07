import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/reels/cubits/ReelsCubit.dart';
import 'package:share_plus/share_plus.dart';



Future<void> share(BuildContext context, int index) async {
  final cubit = context.read<ReelsCubit>();

  final text = cubit.model!.reels[index].sharingContent;

  await Share.share(text);
}
