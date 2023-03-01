import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/reels/cubits/ReelsCubit.dart';
import 'package:url_launcher/url_launcher.dart';

enum SocialMedia { whatsapp }

Future shareOnWhatsapp(
    BuildContext context, SocialMedia socialMedia, int index, String text1) async {

  var text2 = "https://mpsangathan.com/app";
  final text = "$text1\n\n$text2";
  final urls = {
    SocialMedia.whatsapp: 'whatsapp://send?text=$text',
  };
  final url1 = urls[socialMedia]!;
  launchUrl(Uri.parse(url1));
}
