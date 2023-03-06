import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEventButton extends StatelessWidget {
  final String textButtonText;
  final Function() onPressAddEvent;

  const AddEventButton(
      {Key? key, required this.onPressAddEvent, required this.textButtonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressAddEvent,
        child: Text(
          textButtonText,
          style: GoogleFonts.publicSans(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.blue),
        ));
  }
}
