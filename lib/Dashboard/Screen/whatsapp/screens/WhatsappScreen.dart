import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhatsappScreen extends StatelessWidget {
  const WhatsappScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {},
          color: Color(0xFF5A5A61),
        ),
        title: Text("WhatsApp",
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF2F2F2F))),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 92,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFFA5A8),
                      Color(0xFFFFE3F6),

                      //add more colors for gradient
                    ],
                    begin: Alignment.topLeft, //begin of the gradient color
                    end: Alignment.bottomRight, //end of the gradient color
                    //set the stops number equal to numbers of color
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/whatsappPlayIcon.png",
                    height: 32,
                    width: 32,
                  ),
                  title: Text(
                    "Watch the tutorial",
                    style: GoogleFonts.quicksand(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF262626)),
                  ),
                  subtitle: Text(
                    "Click to watch the video on how to paste WhatsApp links",
                    style: GoogleFonts.quicksand(
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        color: Color(0x99262626)),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF5A5A61)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 6.2,
                  decoration: const BoxDecoration(
                      color: Color(0xFF5384FC),
                      borderRadius: BorderRadius.all(Radius.circular(5.16))),
                ),
                const SizedBox(width: 7.8),
                Text(
                  "Links",
                  style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2F2F2F)),
                ),
              ],
            ),
            SizedBox(height: 18),
            TextFormField(
                decoration: InputDecoration(
                    labelText: "Insert your WhatsApp link here",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(width: 1, color: Color(0x80000000)))),
                onChanged: (value) {}),
          ],
        ),
      ),
    );
  }
}
