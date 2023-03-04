import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/network/model/FetchPosts.dart';
import 'package:sangathan/Values/string.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/FetchPostCubit.dart';

enum SocialMedia { whatsapp }

Future shareOnWhatsapp(
    BuildContext context, SocialMedia socialMedia, int index,var text1,var text3) async {
  final cubit = context.read<PostsCubit>();

  var text2 = AppStrings.shareUrl;
  final text = "$text1\n\n$text3\n\n$text2";
  final urls = {
    SocialMedia.whatsapp: 'whatsapp://send?text=$text',
  };
  final url1 = urls[socialMedia]!;

  launchUrl(Uri.parse(url1));
}
