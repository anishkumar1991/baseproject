import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/FetchPostCubit.dart';

enum SocialMedia { whatsapp }

Future shareOnWhatsapp(
    BuildContext context, SocialMedia socialMedia, int index) async {
  final cubit = context.read<FetchPostsCubit>();
  var text1 = cubit.tempModel!.posts[index].title;
  var text2 = "https://mpsangathan.com/app";
  final text = "$text1\n\n$text2";
  final urls = {
    SocialMedia.whatsapp: 'whatsapp://send?text=$text',
  };
  final url1 = urls[socialMedia]!;

  launchUrl(Uri.parse(url1));
}
