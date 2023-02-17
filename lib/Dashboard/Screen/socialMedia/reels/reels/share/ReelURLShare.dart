import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../cubits/ReelsCubit.dart';

Future<void> ReelURLShare(
    BuildContext context, int index, String sourceLink) async {
  final cubit = context.read<ReelsCubit>();
  String urlimage = cubit.model!.reels[index].postData.reel.toString();
  await Share.share(urlimage);
  //await Share.shareXFiles(text: text, [file]);
}
