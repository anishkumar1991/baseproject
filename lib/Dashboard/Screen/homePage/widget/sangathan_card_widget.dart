import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';

import '../../../../Values/size_config.dart';
import '../../../../generated/l10n.dart';
import '../../../../route/route_path.dart';

class SngathanCardWidget extends StatelessWidget {
  const SngathanCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().getCurrentOrientation(context);
    return Container(
      height: 150,
      width: SizeConfig.screenWidth! * 0.94,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.cardOrangeColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 16),
              child: Text(
                S.of(context).sangathan,
                style: GoogleFonts.poppins(
                    color: AppColor.textBlackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Positioned(
              bottom: SizeConfig.screenHeight! * 0.03,
              left: 5,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      backgroundColor: AppColor.buttonBackGroundColor),
                  onPressed: (() {
                    Navigator.pushNamed(
                        context, RoutePath.sangathanDetailsScreen);
                  }),
                  child: Text(
                    S.of(context).click,
                    style: GoogleFonts.poppins(
                        color: AppColor.buttonTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            Positioned(
              top: 10,
              right: 0,
              bottom: 0,
              child: Image.asset(
                AppIcons.sangathanCardImage,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
