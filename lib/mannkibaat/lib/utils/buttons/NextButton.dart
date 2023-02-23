import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/AppColors.dart';

class BUTTON extends StatelessWidget {
  final Function() onPress;

  const BUTTON({Key? key, required this.onPress})
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
          backgroundColor: MaterialStateProperty.all(AppColor().buttonColor),
        ),
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Next ",
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColor().buttonTextColor),
            ),
            const Icon(Icons.arrow_forward),
          ],
        ));
  }
}
