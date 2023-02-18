import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/mannKiBaat/Utils/AppColor.dart';

class LastScreen extends StatefulWidget {
  const LastScreen({Key? key}) : super(key: key);

  @override
  State<LastScreen> createState() => _LastScreenState();
}

class _LastScreenState extends State<LastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 32,),
            Container(
              height: 205,
              width: 400,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors:[
                    Color(0xFFF3F7FF),
                    Color(0xFFEBF2FF)
                  ]
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(children: [
                const SizedBox(height: 16,),
                Center(
                  child: Text(
              'कृपया रुके ',
              style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: AppColor().text1),
                  ),
                ),
                const SizedBox(height: 14,),
                Center(
                  child: SizedBox(
                    height: 40,
                    width: 281,
                    child: Column(
                      children: [
                        Text('कार्यक्रम की रिपोर्टिंग आप ११:०० बजे पश्चात ही कर', style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black),),
                        Text('सकते है।', style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black),),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24,),
                Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            )),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "      बंद करें      ",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white),
                      )),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
