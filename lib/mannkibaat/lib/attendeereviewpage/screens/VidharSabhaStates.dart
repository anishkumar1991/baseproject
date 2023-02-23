import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/AppColors.dart';

class ReviewVidhanAndStates extends StatelessWidget {
  final String? vidhanSabha;
  final String? state;
  const ReviewVidhanAndStates({Key? key, required this.vidhanSabha, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("विधान सभा",
                  style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColor().reviewFormTextColor)),
              Text(
                "${vidhanSabha}",
                style: GoogleFonts.publicSans(
                    color: AppColor().buttonColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              )
            ],
          ),
        ),
        const SizedBox(width: 78),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("राज्य",
                  style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColor().reviewFormTextColor)),
              Text(state ?? " ",
                  style: GoogleFonts.publicSans(
                      color: AppColor().buttonColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16))
            ],
          ),
        ),
      ],
    );
  }
}
