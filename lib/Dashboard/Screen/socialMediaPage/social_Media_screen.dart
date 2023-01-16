import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/socialMediaPage/widget/social_media_widget.dart';
import 'package:sangathan/Login/Screens/LoginScreen/common_button.dart';
import 'package:sangathan/Values/app_colors.dart';

class SocialMediaPage extends StatelessWidget {
  const SocialMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Social Media',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Tw Cen MT',
                    color: AppColor.textBlackColor),
              ),
              CommonButton(
                title: 'Login',
                width: 80,
                borderRadius: 30,
                padding: const EdgeInsets.all(9),
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, color: AppColor.white),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          const SocialMedia()
        ],
      ),
    )));
  }
}
