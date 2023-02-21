import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../generated/l10n.dart';
import '../../../../mannkibaat/lib/mannkibaatpackage.dart';
// import '../../../../mannkibaat/lib/mannkibaatpackage.dart';

class MannKiBaatCard extends StatefulWidget {
  final String? mannkibaatAuthToken;

  const MannKiBaatCard({Key? key, required this.mannkibaatAuthToken})
      : super(key: key);

  @override
  State<MannKiBaatCard> createState() => _MannKiBaatCardState();
}

class _MannKiBaatCardState extends State<MannKiBaatCard> {
  @override
  Widget build(BuildContext context) {
    var temptoken = widget.mannkibaatAuthToken!.split("=");

    return Container(
      height: 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        gradient: LinearGradient(
          colors: [
            Color(0xFF588FC3),
            Color(0x33F9DEB7),

            //add more colors for gradient
          ],
          begin: Alignment.topCenter,
          //begin of the gradient color
          end: Alignment.bottomCenter, //end of the gradient color
          //set the stops number equal to numbers of color
        ),
      ),
      child: Stack(
        children: [
          Positioned(
              top: 30,
              left: 20,
              child: Image.asset(
                'assets/images/mannkibaaatmodilogo.png',
                height: 120,
                width: 116,
              )),
          Positioned(
              right: 24,
              top: 15,
              child: Image.asset(
                "assets/images/mannkibaaatmiclogo.png",
                height: 63,
                width: 100,
              )),
          Positioned(
            right: 42,
            bottom: 10,
            child: SizedBox(
              height: 30,
              width: 143,
              child: MainButton(
                  text: S.of(context).click,
                  authenticationToken: temptoken[1].toString()),

            ),
          )
        ],
      ),
    );
  }
}
