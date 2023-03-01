import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../reportedprogramspage/screens/newscreens/MainDashboard.dart';
import '../../utils/backgroundboxdecoration/BoxDecoration.dart';
import '../../utils/drawer/UserProfileDrawer.dart';
import '../../values/AppColors.dart';

class FormSuccess extends StatelessWidget {
  FormSuccess({super.key});

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final BuildContext s = context;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DashboardMainScreen()),
            (Route<dynamic> route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColor().appBarColor,
            title: Text("भारतीय जनता पार्टी",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 10.91,
                    color: AppColor().textColor)),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DashboardMainScreen()),
                    (Route<dynamic> route) => route.isFirst);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
            ),
            automaticallyImplyLeading: false,
            titleSpacing: 0),
        body: Scaffold(
          key: _key,
          drawer: const UserProfileDrawer(),
          body: Container(
            decoration: BoxDecorationWidget.getBoxDecoration(),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 60),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image(
                    image:
                        Image.asset("assets/images/mannkibaat/formsuccess.png")
                            .image,
                    //width: 300,
                    height: 200,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 70),
                ),
                Align(
                    child: Text(
                  'कार्यक्रम सफलतापूर्वक रिपोर्ट किया गया',
                  style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: AppColor().dashboardTextColorDark),
                )),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Align(
                  child: Text(
                    'वाह! अच्छा काम करते रहो!',
                    style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColor().dashboardTextColorDark),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 35),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DashboardMainScreen()),
                        (Route<dynamic> route) => route.isFirst);
                  },
                  child: Text(
                    'सभी कार्यक्रमों में जाएं',
                    style: GoogleFonts.publicSans(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColor().formSuccessText),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
