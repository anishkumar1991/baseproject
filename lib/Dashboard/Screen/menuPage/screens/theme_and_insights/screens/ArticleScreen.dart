import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ArticleSubpages/Links.dart';
import 'ArticleSubpages/Pdf.dart';
import 'ArticleSubpages/PhotoCreative.dart';
import 'ArticleSubpages/ShortIntro.dart';
import 'ArticleSubpages/Videos.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 380,
                  height: 56, //46
                  decoration: const BoxDecoration(
                    color: Color(0xFF8FC6E5),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Article 370 : जानें क्या था अनुच्छेद 370",
                        style: GoogleFonts.poppins(
                            fontSize: 18, //14
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF5C3834)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 22),
              ShortIntro(),
              SizedBox(height: 40),
              PhotoCreative(),
              SizedBox(height: 40),
              Pdf(),
              SizedBox(height: 40),
              Links(),
              SizedBox(height: 40),
              Videos(),
            ],
          ),
        ),
      ),
    );
  }
}
