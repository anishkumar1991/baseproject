import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> imgList = [
  "assets/images/videos.png",
  "assets/images/videos.png",
  "assets/images/videos.png",
];

class Videos extends StatelessWidget {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(1.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Column(
                      children: <Widget>[
                        Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                        Container(
                          padding: EdgeInsets.only(top: 12),
                          child: const Text(
                            'प्रधानमंत्री उज्ज्वला योजना का सन 2021–22 के बजट के माध्यम से विस्तार ..',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              "वीडियो",
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(

              width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio:1,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                autoPlay: false,

              ),
              items: imageSliders,
            )),
          ),
        ]);
  }
}
