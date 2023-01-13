

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/string.dart';

import '../../Values/app_colors.dart';

class APPBar {
  static getAppBar() {
    return AppBar(
      backgroundColor: AppColor().appBarColor,
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 21.7),
            child: Image(image: Image.asset(AppIcons.appbarlogo).image, width: 21, height: 21,),
          ),
          const SizedBox(width: 4),
          Text(Strings.appbartext,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 10.91,
                  color: AppColor().textColor)),
          SizedBox(
            width: 20,
          ),
        ],
      ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: 0
    );
  }
}