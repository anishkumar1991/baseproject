import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/socialMediaPage/widget/poll_widget.dart';
import 'package:sangathan/Dashboard/Screen/socialMediaPage/widget/social_media_video_widget.dart';
import 'package:sangathan/Dashboard/Screen/socialMediaPage/widget/social_media_widget.dart';
import 'package:sangathan/Dashboard/Screen/socialMediaPage/widget/social_video.dart';
import 'package:sangathan/Values/app_colors.dart';

import '../../../Values/space_height_widget.dart';
import '../../../common/common_button.dart';
import '../../../generated/l10n.dart';

class SocialMediaPage extends StatelessWidget {
  const SocialMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceHeightWidget(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Social Media',
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Tw Cen MT',
                      color: AppColor.textBlackColor),
                ),
                CommonButton(
                  onTap: (() {}),
                  title: 'Login',
                  width: 80,
                  borderRadius: 30,
                  padding: const EdgeInsets.all(9),
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: AppColor.white),
                )
              ],
            ),
            spaceHeightWidget(12),
            const SocialMedia(),
            spaceHeightWidget(10),
            const Text(
              'You may like these Reels',
              style: TextStyle(
                  fontFamily: 'Tw Cen MT',
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            spaceHeightWidget(10),
            const SocialVideo(),
            spaceHeightWidget(10),
            PollWidget(question: 'Who will win the 2024 Elections?'),
            spaceHeightWidget(10),
            const SocialMediaNews(),
            spaceHeightWidget(20),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: AppColor.greyColor.withOpacity(0.3))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S
                          .of(context)
                          .loginToGetTheProgramsAndInformationRelatedToTheOrganization,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    spaceHeightWidget(16),
                    CommonButton(
                      onTap: (() {}),
                      padding: const EdgeInsets.all(10),
                      title: S.of(context).loginButtonText,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColor.white),
                    )
                  ],
                ),
              ),
            ),
            spaceHeightWidget(100)
          ],
        ),
      ),
    );
  }
}
