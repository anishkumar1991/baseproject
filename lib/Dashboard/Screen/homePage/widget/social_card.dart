import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Values/app_colors.dart';
import '../../../../Values/icons.dart';
import '../../../../Values/size_config.dart';
import '../../../../generated/l10n.dart';
import '../../../Cubit/dashboard_cubit.dart';

class SocialCard extends StatelessWidget {
  final String img;

  SocialCard({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: SizeConfig.screenWidth! * 0.94,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Image.network(
                img,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 16),
              child: Text(
                "सामाजिक मीडिया",
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
                      backgroundColor: AppColor.redLight),
                  onPressed: (() {
                    context.read<DashBoardCubit>().onTapIcons(0);
                  }),
                  child: Text(
                    S.of(context).click,
                    style: GoogleFonts.poppins(
                        color: AppColor.buttonTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )),

            ),

          ],
        ),
      ),
    );
  }
}
