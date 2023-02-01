import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Values/icons.dart';
import '../../../../Values/space_width_widget.dart';

class SocialShareButtons extends StatelessWidget {
   SocialShareButtons({
    Key? key,required this.like,required this.share,required this.whatsappShare
  }) : super(key: key,);
  String like;
  String share;
  String whatsappShare;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Image.asset(
              AppIcons.likeIcon,
              height: 30,
            ),
            spaceWidthWidget(8),
            Text(
              like,
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.share_outlined,
              size: 22,
            ),
            spaceWidthWidget(8),
            Text(
              share,
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              AppIcons.whatsappIcon,
              height: 24,
            ),
            spaceWidthWidget(8),
            Text(
              whatsappShare,
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
    );
  }
}
