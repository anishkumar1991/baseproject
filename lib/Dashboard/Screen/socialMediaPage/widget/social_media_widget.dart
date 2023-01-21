import 'package:flutter/material.dart';
import 'package:sangathan/Dashboard/Screen/socialMediaPage/widget/read_more_text.dart';
import 'package:sangathan/Dashboard/Screen/socialMediaPage/widget/social_share_button.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/spaceHeightWidget.dart';

class SocialMediaNews extends StatelessWidget {
  const SocialMediaNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColor.greyColor.withOpacity(0.3))),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Image.asset(
              AppIcons.socialPageImage,
            ),
          ),
          spaceHeightWidget(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const Text(
                  'People’s PollNobody can break Modi-Yogi Pair: UP governor',
                  style: TextStyle(
                      fontSize: 19,
                      fontFamily: 'Tw Cen MT',
                      fontWeight: FontWeight.w400),
                ),
                spaceHeightWidget(14),
                const ReadmoreWidget(
                  text:
                      'Uttar Pradesh Governor Anandiben Patel on Sunday said nobody available on branch on give by leader ',
                )
              ],
            ),
          ),
          spaceHeightWidget(18),
          const SocialShareButtons(),
          spaceHeightWidget(10),
        ],
      ),
    );
  }
}
