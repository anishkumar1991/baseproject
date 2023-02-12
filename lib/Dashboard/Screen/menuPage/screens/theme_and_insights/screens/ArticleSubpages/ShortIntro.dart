import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShortIntro extends StatelessWidget {
  const ShortIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 126,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Color(0xFFE6E6E6),
            ),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Icon(
                          Icons.circle_rounded,
                          size: 6,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Container(
                        width: 263,
                        height: 30,
                        child: Text(
                          "इसी विशेष दर्ज़े के कारण जम्मू-कश्मीर ",
                          style: GoogleFonts.poppins(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Positioned(bottom: 14, right: 14, child: Icon(Icons.copy)),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Color(0xFFE6E6E6),
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "पहले देश के लिए अधिकतर जो स्कीम बनती थी, जो कानून बनते थे, उनमें लिखा होता था- Except J and K. अब ये इतिहास की बात हो चुकी है।,",
                        style: GoogleFonts.poppins(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 14,
                right: 14,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.copy),
                )),
          ],
        )
      ],
    );
  }
}
