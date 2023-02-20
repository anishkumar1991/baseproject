import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/AppColors.dart';

class ReviewBoothAddress extends StatelessWidget {
  final String? boothAddress;
  const ReviewBoothAddress({Key? key, required this.boothAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        child: ListTile(
            title: Text("पता",
                style: GoogleFonts.publicSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColor().reviewFormTextColor)),
            subtitle: Text(
                boothAddress ?? " ",

                style: GoogleFonts.publicSans(
                    color: AppColor().buttonColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16))));
  }
}
