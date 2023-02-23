import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../values/AppColors.dart';
class ReviewBoothName extends StatelessWidget {
  final String? booth;
  const ReviewBoothName({Key? key, required this.booth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ListTile(
            title: Text("बूथ",
                style: GoogleFonts.publicSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColor().reviewFormTextColor)),
            subtitle: Text(
                booth?? " ",
                style: GoogleFonts.publicSans(
                    color: AppColor().buttonColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16))));
  }
}
