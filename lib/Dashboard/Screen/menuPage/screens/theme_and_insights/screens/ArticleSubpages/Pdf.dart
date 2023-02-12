import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pdf extends StatelessWidget {
  const Pdf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "PDF",
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 63,
          decoration: BoxDecoration(
            color: const Color(0xFFDBF2FF),
            border: Border.all(
              width: 1,
              color: const Color(0xFFDBF2FF),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 40,
                  child: Image(
                    image: Image.asset("assets/images/pdf.png").image,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "इसलिए जरूरी था अनुच्छेद \n" "370 को निरस्त करना",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 63,
          decoration: BoxDecoration(
            color: const Color(0xFFDBF2FF),
            border: Border.all(
              width: 1,
              color: const Color(0xFFDBF2FF),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 40,
                  child: Image(
                    image: Image.asset("assets/images/pdf.png").image,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "इसलिए जरूरी था अनुच्छेद \n" "370 को निरस्त करना",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
