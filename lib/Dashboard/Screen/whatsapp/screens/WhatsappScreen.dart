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
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
          color: const Color(0xFF5A5A61),
        ),
        title: Text("WhatsApp",
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: const Color(0xFF2F2F2F))),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 92,
              decoration: const BoxDecoration(
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
                        color: const Color(0xFF262626)),
                  ),
                  subtitle: Text(
                    "Click to watch the video on how to paste WhatsApp links",
                    style: GoogleFonts.quicksand(
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        color: const Color(0x99262626)),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded,
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
                      color: const Color(0xFF2F2F2F)),
                ),
              ],
            ),
            const SizedBox(height: 18),
            TextFormField(
                decoration: InputDecoration(
                    labelText: "Insert your WhatsApp link here",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            width: 1, color: Color(0x80000000)))),
                onChanged: (value) {}),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF79747E),
                        width: 1,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  child: IconButton(
                      onPressed: () {},
                      icon: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: Color(0xFF79747E),
                          ),
                          Text(
                            "Add Link",
                            style: GoogleFonts.quicksand(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          )
                        ],
                      ))),
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {},
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color(0xFF635AE2),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Center(
                  child: Text(
                    "Save",
                    style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
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
                  "List of Existing Groups",
                  style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2F2F2F)),
                ),
                const Spacer(),
                Text(
                  "Total : 80",
                  style: GoogleFonts.quicksand(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xB32F2F2F)),
                )
              ],
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Row(
                children: [
                  Image.asset("assets/images/whatsapp_icon.png",
                      width: 18, height: 18),
                  const SizedBox(width: 7),
                  Text(
                    "WhatsApp Links",
                    style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF828282)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Image.asset(
                  "assets/images/whatsappShareIcon.png",
                  width: 20,
                  height: 11.67,
                ),
                const SizedBox(width: 16),
                Text(
                  "https://m.whatsapp_bjp.com",
                  style: GoogleFonts.quicksand(
                      color: const Color(0xFF4471B0),
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  "assets/images/whatsappShareIcon.png",
                  width: 20,
                  height: 11.67,
                ),
                const SizedBox(width: 16),
                Text(
                  "https://m.whatsapp_bjp.com",
                  style: GoogleFonts.quicksand(
                      color: const Color(0xFF4471B0),
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  "assets/images/whatsappShareIcon.png",
                  width: 20,
                  height: 11.67,
                ),
                const SizedBox(width: 16),
                Text(
                  "https://m.whatsapp_bjp.com",
                  style: GoogleFonts.quicksand(
                      color: const Color(0xFF4471B0),
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
