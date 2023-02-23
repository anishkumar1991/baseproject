import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/AppColors.dart';

class withoutSidebar {
  static getAppBar() {
    return AppBar(
        backgroundColor: AppColor().appBarColor,
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 21.7),
              child: Image(
                image: Image.asset("assets/BJP-logo.png").image,
                width: 21,
                height: 21,
              ),
            ),
            const SizedBox(width: 4),
            Text("भारतीय जनता पार्टी",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 10.91,
                    color: AppColor().textColor)),
            const SizedBox(
              width: 20,
            ),
            
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: 0);
  }
}
