import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LastScreen.dart';
import '../Utils/AppColor.dart';

class DasshBoard1 extends StatefulWidget {
  const DasshBoard1({Key? key}) : super(key: key);

  @override
  State<DasshBoard1> createState() => _DasshBoard1State();
}

class _DasshBoard1State extends State<DasshBoard1> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 121,
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const LastScreen()));
        },
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 10),
          shadowColor: AppColor().card1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10, left: 9, right: 1, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '97th Mann ki Baat',
                  style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColor().buttonColor),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  'Aired on-',
                  style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 8,
                      color: AppColor().textcolor10),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  '29th Jan 2023 ',
                  style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 8,
                      color: AppColor().textcolor9),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  //' ${state.dashModal.data?.first.airedDetail?.time}',
                  ' 11:00 AM',
                  style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 8,
                      color: AppColor().textcolor10),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  'रिपोर्ट देखे  >',
                  style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 8,
                      color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
