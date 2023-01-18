import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';

class SelectPropertyBox extends StatelessWidget {
  const SelectPropertyBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: true,
              onChanged: ((value) {}),
              activeColor: AppColor.progressGreenColor,
            ),
            Text(
              'Bike',
              style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.greyColor),
            )
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: true,
              onChanged: ((value) {}),
              activeColor: AppColor.progressGreenColor,
            ),
            Text(
              'Car',
              style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.greyColor),
            )
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: true,
              onChanged: ((value) {}),
              activeColor: AppColor.progressGreenColor,
            ),
            Text(
              'Bike',
              style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.greyColor),
            )
          ],
        ),
      ],
    );
  }
}
