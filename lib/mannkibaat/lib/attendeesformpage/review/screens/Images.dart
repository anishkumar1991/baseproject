import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Values/app_colors.dart';

class ReviewImages extends StatelessWidget {
  final String img1;
  final String img2;

  const ReviewImages({Key? key, required this.img1, required this.img2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ListTile(
      title: Text("फोटो",
          style: GoogleFonts.publicSans(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: AppColor().reviewFormTextColor)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top : 10),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(20),
          dashPattern: [5, 5],
          color: Colors.grey,
          strokeWidth: 1,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    child: Image.network(img1,
                        width: 120,
                        height: 200,
                        //extensions like .jpg, .png etc
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                              "assets/images/mannkibaat/image.png",
                              color: Colors.black12,
                              width: 120,
                              height: 200,
                            ))),
                const SizedBox(width: 10),
                SizedBox(
                    child: Image.network(img2,
                        width: 120,
                        height: 200,
                        //extensions like .jpg, .png etc
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                              "assets/images/mannkibaat/image.png",
                              color: Colors.black12,
                              width: 100,
                              height: 200,
                            ))),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
