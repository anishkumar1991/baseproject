import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionsScreen extends StatefulWidget {
  final String title;
  final String views;

  const OptionsScreen({Key? key, required this.title, required this.views})
      : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    widget.title,
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.views,
                    style: GoogleFonts.montserrat(
                        fontSize: 12, fontWeight: FontWeight.w700),
                  )
                  // SizedBox(height: 10),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    children: [
                      IconButton(
                          onPressed: () {

                          }, icon: Icon(Icons.thumb_up_alt)),
                      SizedBox(height: 20),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.whatsapp)),
                      SizedBox(height: 20),
                      IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                      SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
