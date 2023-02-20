import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/AppColors.dart';

class ReviewDescription extends StatelessWidget {
  final String? description;
  const ReviewDescription({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ListTile(
            title: Text("विवरण",
                style: GoogleFonts.publicSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColor().reviewFormTextColor)),
            subtitle: Text(
                description ?? " ",
                style: GoogleFonts.publicSans(
                    color: const Color(0xFF444446),
                    fontWeight: FontWeight.w400,
                    fontSize: 14))));
  }
}
