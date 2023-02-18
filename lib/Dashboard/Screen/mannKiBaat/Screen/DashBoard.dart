import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/AppColor.dart';
import 'DashBoard1.dart';
import 'MainCard.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text('मन की बात',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 18,
                          color: AppColor().text2,
                          fontWeight: FontWeight.w500),
                    )),
              ],
            ),
            const SizedBox(
              height: 26,
            ),
            Text(
              'वर्तमान / आगामी ',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColor().textcolor9,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 19,
            ),
            SizedBox(
              height: 191,
              width: MediaQuery.of(context).size.width,
              child: const MannKiBaatCard(),
            ),
            const SizedBox(
              height: 59,
            ),
            Text(
              'पूर्व कार्यक्रम ',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColor().textcolor9,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 4,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 120,
                  child: DasshBoard1(),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
