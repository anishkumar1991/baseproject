import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton(
      {super.key,
      required this.title,
      required this.value,
      required this.groupValue,
      this.onChanged});
  final String title;
  final String value;
  final String groupValue;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
            value: value,
            groupValue: groupValue,
            onChanged: ((value) => onChanged != null ? (value!) : null)),
        Text(
          title,
          style: GoogleFonts.roboto(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColor.greyColor),
        ),
      ],
    );
  }
}
