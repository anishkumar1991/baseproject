import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../whatsapp/screens/WhatsappScreen.dart';


class WhatsappCardWidget extends StatelessWidget {
  const WhatsappCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          gradient: LinearGradient(
            colors: [
              Color(0xFF86F6C7),
              Color(0xFFEEFEFA),

              //add more colors for gradient
            ],
            begin: Alignment.topLeft,
            //begin of the gradient color
            end: Alignment
                .bottomRight, //end of the gradient color
            //set the stops number equal to numbers of color
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 13),
          child: Column(children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/whatsapp_icon.png",
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 7),
                Text(
                  "WhatsApp",
                  style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF262626)),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Container(
                width: 222,
                height: 61,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(children: [
                    Text(
                      "Total Groups –",
                      style: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xCC282622)),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "100",
                      style: GoogleFonts.quicksand(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color(0xCC282622)),
                    )
                  ]),
                ),
              ),
            )
          ]),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return WhatsappScreen();
          },
        ));
      },
    );
  }
}
