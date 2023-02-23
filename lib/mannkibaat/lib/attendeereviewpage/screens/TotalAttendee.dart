import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/AppColors.dart';

class ReviewTotalAttendee extends StatelessWidget {
  final String? totalAttendees;

  const ReviewTotalAttendee({Key? key, required this.totalAttendees})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ListTile(
            title: Text("कुल उपस्थित",
                style: GoogleFonts.publicSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColor().reviewFormTextColor)),
            subtitle: Text(totalAttendees ?? " ",
                style: GoogleFonts.publicSans(
                    color: AppColor().buttonColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16))));
  }
}
