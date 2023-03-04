import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Values/app_colors.dart';
import '../../values/AppColors.dart';

class SubmitButton extends StatelessWidget {
  final String textButtonText;
  final Function() onPress;


  const SubmitButton({Key? key, required this.onPress, required this.textButtonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all(AppColor().buttonShadowColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          backgroundColor: MaterialStateProperty.all(AppColor.primaryColor),
        ),
        onPressed: onPress,
        child: Text(
          textButtonText,
          style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: AppColor().buttonTextColorMKB),
        ));
  }
}
