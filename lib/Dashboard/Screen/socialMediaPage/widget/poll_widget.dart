import 'package:flutter/material.dart';
import 'package:sangathan/Dashboard/Screen/socialMediaPage/widget/social_share_button.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/space_height_widget.dart';

class PollWidget extends StatelessWidget {
  PollWidget({super.key, this.question});
   String? question;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.greyColor.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'People’s Poll',
              style: TextStyle(
                  fontFamily: 'Tw Cen MT',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColor.textBlackColor),
            ),
            spaceHeightWidget(12),
            Text(question ?? '',
                style: const TextStyle(
                    fontFamily: 'Tw Cen MT',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColor.greyColor)),
            spaceHeightWidget(20),
            ListView.separated(
                shrinkWrap: true,
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: ((context, index) => spaceHeightWidget(8)),
                itemBuilder: ((context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColor.greyColor.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      children: [
                        Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            value: index == 2 ? true : false,
                            onChanged: ((value) {})),
                        const Text('BJP',
                            style: TextStyle(
                                fontFamily: 'Tw Cen MT',
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: AppColor.greyColor))
                      ],
                    ),
                  );
                })),
            spaceHeightWidget(20),
            const SocialShareButtons()
          ],
        ),
      ),
    );
  }
}
