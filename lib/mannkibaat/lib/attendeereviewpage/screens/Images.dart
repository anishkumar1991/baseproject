import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/AppColors.dart';

class ReviewImages extends StatelessWidget {
  final String? img1;
  final String? img2;

  const ReviewImages({Key? key, required this.img1, required this.img2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ListTile(
      title: Text("तस्वीर",
          style: GoogleFonts.publicSans(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColor().reviewFormTextColor)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          children: [
            SizedBox(
                child: Image.network(img1!,
                    width: 120,
                    height: 200,
                    //extensions like .jpg, .png etc
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                          "packages/mannkibaatpackage/lib/assets/review1.png",
                          width: 120,
                          height: 200,
                        ))),
            const SizedBox(width: 10),
            SizedBox(
                child: Image.network(img2!,
                    width: 120,
                    height: 200,
                    //extensions like .jpg, .png etc
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                          "packages/mannkibaatpackage/lib/assets/review2.png",
                          width:  100,
                          height: 200,
                        ))),
          ],
        ),
      ),
    ));
  }
}
