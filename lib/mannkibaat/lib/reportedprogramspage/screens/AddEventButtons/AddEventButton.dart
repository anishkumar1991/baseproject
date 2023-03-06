import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEventButton extends StatelessWidget {
  final String textButtonText;
  final Function() onPress;

  const AddEventButton(
      {Key? key, required this.onPress, required this.textButtonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPress,
        child: Text(
          textButtonText,
          style: GoogleFonts.publicSans(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.blue),
        ));
  }
}
