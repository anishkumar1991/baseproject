import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Color(0xFF979797),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: Row(
            children: [
              Text(
                "Today",
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF2F2F2F)),
              ),
              Text(
                " - Monday, Jan 23",
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF666666)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 100),
        Center(
          child: Text(
            "Notification Unavailable",
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600, fontSize: 20),
          ),
        )
      ],
    );
  }
}
