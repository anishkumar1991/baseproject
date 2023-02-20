import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/AppColors.dart';
import '../buttons/NextButton.dart';
import 'langContent.dart';

void LanguageSelector(BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      builder: (context) {
        return Column(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 19),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Select Language',
                      style: GoogleFonts.publicSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppColor().dashboardTextColorDark),
                    ),
                  ),
                )),
            Expanded(
                flex: 9,
                child: SizedBox(
                  height: 10,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 19),
                    child: ListView(
                      children: const [
                        LanguageContent(textcontent: "Hindi"),
                        LanguageContent(textcontent: "Tamil"),
                        LanguageContent(textcontent: "Sanskrit",),
                        LanguageContent(textcontent: "Bhojpuri",),
                        LanguageContent(textcontent: "Bengali",),
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 14,
            ),
            Expanded(
                child: SizedBox(
              width: 219,
              height: 45,
              child: BUTTON(
                onPress: () {},
              ),
            )),
            SizedBox(
              height: 14,
            )
          ],
        );
      });
}
