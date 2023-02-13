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
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: const Color(0xFFE6E6E6),
            ),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.circle_rounded,
                    size: 6,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SizedBox(
                    width: 263,
                    child: Text(
                      "इसी विशेष दर्ज़े के कारण जम्मू-कश्मीर राज्य पर संविधान की धारा 356 लागू नहीं होती।",
                      style: GoogleFonts.poppins(
                          fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.circle_rounded,
                    size: 6,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SizedBox(
                    width: 263,
                    child: Text(
                      "इसी विशेष दर्ज़े के कारण जम्मू-कश्मीर राज्य पर संविधान की धारा 356 लागू नहीं होती।",
                      style: GoogleFonts.poppins(
                          fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.copy),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: const Color(0xFFE6E6E6),
            ),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "पहले देश के लिए अधिकतर जो स्कीम बनती थी, जो कानून बनते थे, उनमें लिखा होता था- Except J and K. अब ये इतिहास की बात हो चुकी है।,"
                    "शांति और विकास के जिस मार्ग पर जम्मू और कश्मीर बढ़ रहा है, उसने राज्य में नए उद्योगों के आने का मार्ग भी बनाया है। आज जम्मू-कश्मीर आत्मनिर्भर भारत अभियान में अपना योगदान दे रहा है|"
                    "पहले देश के लिए अधिकतर जो स्कीम बनती थी, जो कानून बनते थे, उनमें लिखा होता था- Except J and K. अब ये इतिहास की बात हो चुकी है।,"
                    "शांति और विकास के जिस मार्ग पर जम्मू और कश्मीर बढ़ रहा है, उसने राज्य में नए उद्योगों के आने का मार्ग भी बनाया है। आज जम्मू-कश्मीर आत्मनिर्भर भारत अभियान में अपना योगदान दे रहा है|",
                    style: GoogleFonts.poppins(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Text(
                "- प्रधानमंत्री नरेन्द्र मोदी",
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w700),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.copy),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
