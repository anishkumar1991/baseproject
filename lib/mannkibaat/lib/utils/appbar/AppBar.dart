import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/AppColors.dart';
import '../languagelist/langlist.dart';

class AppBarWidget {
  static getAppBar(GlobalKey<ScaffoldState> globalKey, BuildContext context) {
    return AppBar(
        backgroundColor: AppColor().appBarColor,
        // title: Row(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(left: 21.67, right: 23.67),
        //       child: IconButton(
        //         onPressed: () {
        //           globalKey.currentState?.openDrawer();
        //         },
        //         icon: Image(
        //             image: Image.asset("packages/mannkibaatpackage/lib/assets/sidebox.png").image,
        //             width: 26,
        //             height: 18),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(right: 4),
        //       child: Image(
        //         image: Image.asset("packages/mannkibaatpackage/lib/assets/BJP-logo.png").image,
        //         width: 21,
        //         height: 21,
        //       ),
        //     ),
        //     SizedBox(width: 4),
        //     Text("Bharatiya Janata Party",
        //         style: GoogleFonts.poppins(
        //             fontWeight: FontWeight.w700,
        //             fontSize: 10.91,
        //             color: AppColor().textColor)),
        //     SizedBox(
        //       width: 20,
        //     ),
        //   ],
        // ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.fromLTRB(0, 10, 19, 10),
        //     child: TextButton(
        //       onPressed: () {
        //         LanguageSelector(context);
        //       },
        //       style: TextButton.styleFrom(
        //           side: const BorderSide(width: 0.5, color: Color(0xFF828282)),
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(4))),
        //       child: Row(
        //         children: [
        //           Text("EN",
        //               style: GoogleFonts.publicSans(
        //                   fontWeight: FontWeight.w700,
        //                   fontSize: 12,
        //                   color: AppColor().textColor)),
        //           Icon(
        //             Icons.arrow_drop_down,
        //             color: AppColor().reviewFormTextColor,
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ],

        title: Text("भारतीय जनता पार्टी",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 10.91,
                color: AppColor().textColor)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        titleSpacing: 0);
  }
}
