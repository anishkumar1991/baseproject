import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'MainCard.dart';

class InsightsMainPage extends StatelessWidget {
  const InsightsMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = [
      const MainCard(img: "assets/images/themePM.png", text: "उज्ज्वला योजना"),
      const MainCard(
          img: "assets/images/themePM2.png", text: "धारा ३७० के सम्बन्ध में"),
      const MainCard(img: "assets/images/themePM1.png", text: "तीन तलाक पर मोदी सरकार"),
      const MainCard(img: "assets/images/themePM.png", text: "उज्ज्वला योजना"),
      const MainCard(img: "assets/images/themePM3.png", text: "जीएसटी क्या है"),
      const MainCard(
          img: "assets/images/themePM2.png", text: "धारा ३७० के सम्बन्ध म"),
      const MainCard(img: "assets/images/themePM1.png", text: "तीन तलाक पर मोदी सरकार"),
      const MainCard(img: "assets/images/themePM3.png", text: "जीएसटी क्या है"),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          "विषय एवं अंतर्दृष्टि ",
          style: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: Container(
        child: GridView.builder(
          itemCount: 8,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
          itemBuilder: (BuildContext context, int index) {
            return list[index];
          },
        ),
      ),
    );
  }
}
