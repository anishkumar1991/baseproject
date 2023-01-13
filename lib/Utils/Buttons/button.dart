import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/string.dart';

import '../../Values/app_colors.dart';

class BUTTON extends StatelessWidget {
  final String? snackBar;
  final Function() onPress;

  const BUTTON({Key? key, this.snackBar, required this.onPress})
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
              Strings.buttontext,
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
