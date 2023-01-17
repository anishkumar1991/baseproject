import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Values/icons.dart';
import '../../../../Values/spaceWidthWidget.dart';

class SocialShareButtons extends StatelessWidget {
  const SocialShareButtons({
    Key? key,
  }) : super(key: key);

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
              '1k',
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
              '223',
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
              '223',
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
    );
  }
}
