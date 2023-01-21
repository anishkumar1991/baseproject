import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../Values/app_colors.dart';

class ReadmoreWidget extends StatelessWidget {
  const ReadmoreWidget({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimMode: TrimMode.Line,
      trimLines: 2,
      style: const TextStyle(
          fontFamily: 'Tw Cen MT', fontSize: 18, color: AppColor.greyColor),
      trimCollapsedText: 'More',
      trimExpandedText: 'Less',
      lessStyle: const TextStyle(
          fontFamily: 'Tw Cen MT',
          fontSize: 18,
          color: AppColor.textBlackColor,
          fontWeight: FontWeight.w700),
      moreStyle: const TextStyle(
          fontFamily: 'Tw Cen MT',
          fontSize: 18,
          color: AppColor.textBlackColor,
          fontWeight: FontWeight.w700),
    );
  }
}