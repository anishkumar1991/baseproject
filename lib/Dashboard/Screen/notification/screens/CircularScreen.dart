import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CircularScreen extends StatelessWidget {
  const CircularScreen({Key? key}) : super(key: key);

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
        ListTile(
            leading: Container(
              width: 34,
              height: 34,
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Image.asset("assets/images/notificationPdfIcon.png"),
              ),
              decoration: BoxDecoration(
                  color: Color(0xFFFFD2B3),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
            title: Text(
              "10:30 AM",
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color(0xFF262626)),
            ),
            subtitle: Text(
              "राष्ट्रीय कार्यकारिणी बैठक",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xFF262626)),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon:
                  Icon(Icons.file_download_outlined, color: Color(0xFF000000)),
            )),
        Divider(
          endIndent: 20,
          indent: 20,
          color: Color(0xFF979797),
        ),
        ListTile(
          leading: Container(
            width: 34,
            height: 34,
            child: Padding(
              padding: const EdgeInsets.all(6.5),
              child: Image.asset("assets/images/notificationImageIcon.png"),
            ),
            decoration: BoxDecoration(
                color: Color(0xFF99DAFF),
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
          title: Text(
            "10:30 AM",
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Color(0xFF262626)),
          ),
          subtitle: Text(
            "राष्ट्रीय कार्यकारिणी बैठक",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Color(0xFF262626)),
          ),
        ),
        Divider(
          color: Color(0xFF979797),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: Row(
            children: [
              Text(
                "Yesterday",
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF2F2F2F)),
              ),
              Text(
                " - Sunday, Jan 23",
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF666666)),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Container(
            width: 34,
            height: 34,
            child: Padding(
              padding: const EdgeInsets.all(6.5),
              child: Image.asset("assets/images/notificationLinkIcon.png"),
            ),
            decoration: BoxDecoration(
                color: Color(0xFFFFAECB),
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
          title: Text(
            "10:30 AM",
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Color(0xFF262626)),
          ),
          subtitle: Text(
            "राष्ट्रीय कार्यकारिणी बैठक",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Color(0xFF262626)),
          ),
        ),
        Divider(
          endIndent: 20,
          indent: 20,
          color: Color(0xFF979797),
        ),
        ListTile(
            leading: Container(
              width: 34,
              height: 34,
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Image.asset("assets/images/notificationPdfIcon.png"),
              ),
              decoration: BoxDecoration(
                  color: Color(0xFFFFD2B3),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
            title: Text(
              "10:30 AM",
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color(0xFF262626)),
            ),
            subtitle: Text(
              "राष्ट्रीय कार्यकारिणी बैठक",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xFF262626)),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon:
                  Icon(Icons.file_download_outlined, color: Color(0xFF000000)),
            )),
      ],
    );
  }
}
