import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Links extends StatelessWidget {
  const Links({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "लिंक",
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        SizedBox(height: 10),
        Container(
          width: 320,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 24, top: 17),
            child: Container(
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "सम्पूर्ण जानकारी प्राप्त करें इस लिंक से ",
                    style: GoogleFonts.poppins(
                        fontSize: 10, //14
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF666666)),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 20,
                        child: Image(
                          image: Image.asset("assets/images/links.png").image,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "https://www.mha.gov.in/sites/default/files/\n"
                        "370Hindi_20092021.pdf",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF447EFF)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 320,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 24, top: 17),
            child: Container(
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "सम्पूर्ण जानकारी प्राप्त करें इस लिंक से ",
                    style: GoogleFonts.poppins(
                        fontSize: 10, //14
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF666666)),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 20,
                        child: Image(
                          image: Image.asset("assets/images/links.png").image,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "https://www.mha.gov.in/sites/default/files/\n"
                        "370Hindi_20092021.pdf",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF447EFF)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
