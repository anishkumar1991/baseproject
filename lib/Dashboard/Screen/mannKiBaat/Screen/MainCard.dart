import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/AppColor.dart';
import 'FormPage.dart';

class MannKiBaatCard extends StatefulWidget {
  const MannKiBaatCard({Key? key}) : super(key: key);

  @override
  State<MannKiBaatCard> createState() => _MannKiBaatCardState();
}

class _MannKiBaatCardState extends State<MannKiBaatCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        gradient: LinearGradient(
          colors: [
            Color(0xFF588FC3),
            Color(0x33F9DEB7),
            //add more colors for gradient
          ],
          begin: Alignment.topCenter,
          //begin of the gradient color
          end: Alignment.bottomCenter, //end of the gradient color
          //set the stops number equal to numbers of color
        ),
      ),
      child: Stack(
        children: [
          Positioned(
              left: -71,
              top: 0,
              child: Image.asset(
                "assets/images/mannkibaat/image1.png",
                height: 131,
                width: 305,
              )),
          Positioned(
              right:97,
              bottom:43,
              child: Text('98 वां संस्करण ', style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 18,
                    color: AppColor().textcolor5,
                    fontWeight: FontWeight.w700),),),),
          Positioned(
            right:12,
            bottom:44,
            child: Text('on 26 Feb, 2023 ', style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  fontSize: 10,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600),),),),
          Positioned(
              top: 45,
              left: 11,
              child: Image.asset(
                'assets/images/mannkibaat/image3.png',
                height: 146,
                width: 116,
              )),
          Positioned(
              right: 76,
              top: 15,
              child: Image.asset(
                "assets/images/mannkibaat/image12.png",
                height: 93,
                width: 121,
              )),
          Positioned(
            right: 42,
            bottom: 10,
            child: SizedBox(
              height: 30,
              width: 143,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all(AppColor().buttoncolor),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FormPage()));
                  },
                  child: Text(
                    "क्लिक करे",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
