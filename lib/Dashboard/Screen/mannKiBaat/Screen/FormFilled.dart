import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/mannKiBaat/Utils/AppColor.dart';

import 'DashBoard.dart';


class FormFilled extends StatefulWidget {
  const FormFilled({Key? key}) : super(key: key);

  @override
  State<FormFilled> createState() => _FormFilledState();
}

class _FormFilledState extends State<FormFilled> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35),
        child: Column(
          children: [
            const SizedBox(
              height: 143,
            ),
            SizedBox(
                height: 267,
                width: 154,
                child: Image.asset(
                  'assets/images/mannkibaat/image11.png',
                  height: 267,
                  width: 154,
                )),
            const SizedBox(
              height: 32,
            ),
            Center(
                child: Text(
              'कार्यक्रम सफलतापूर्वक रिपोर्ट किया गया । ',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black),
            )),
        const SizedBox(height: 4,),
        Center(
          child: Text(
            'वाह ! अच्छा काम करते रहो',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColor().textcolor10),
          ),
        ),
            const SizedBox(height: 50,),
            Center(
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
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>const DashBoard()));
                  },
                  child: Text(
                    "आगे बढ़े।  ",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
