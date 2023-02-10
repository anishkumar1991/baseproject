import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShortIntro extends StatelessWidget {
  const ShortIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 320,
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
                          "इसी विशेष दर्ज़े के कारण जम्मू-कश्मीर राज्य पर संविधान की धारा 356 लागू नहीं होती।",
                          style: GoogleFonts.poppins(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(
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
                          "इसी विशेष दर्ज़े के कारण जम्मू-कश्मीर राज्य पर संविधान की धारा 356 लागू नहीं होती।",
                          style: GoogleFonts.poppins(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
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
              width: 320,
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Color(0xFFE6E6E6),
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Container(
                width: 263,
                height: 80,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "पहले देश के लिए अधिकतर जो स्कीम बनती थी, जो कानून बनते थे, उनमें लिखा होता था- Except J and K. अब ये इतिहास की बात हो चुकी है।,"
                      "शांति और विकास के जिस मार्ग पर जम्मू और कश्मीर बढ़ रहा है, उसने राज्य में नए उद्योगों के आने का मार्ग भी बनाया है। आज जम्मू-कश्मीर आत्मनिर्भर भारत अभियान में अपना योगदान दे रहा है|",
                      style: GoogleFonts.poppins(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 12,
                left: 82,
                right: 14,
                child: Text(
                  "- प्रधानमंत्री नरेन्द्र मोदी",
                  style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.w700),
                )),
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
