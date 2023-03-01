
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Storage/user_storage_service.dart';
import 'package:sangathan/mannkibaat/lib/reportedprogramspage/cubit/DashCubit.dart';
import 'package:sangathan/mannkibaat/lib/reportedprogramspage/screens/newscreens/MainDashboard.dart';
import 'package:sangathan/mannkibaat/lib/values/AppColors.dart';


class MainButton extends StatefulWidget {
  final String text;

  const MainButton({Key? key, required this.text})
      : super(key: key);

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all(AppColor().buttonShadowColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
          backgroundColor: MaterialStateProperty.all(AppColor().buttonColor),
        ),
        onPressed: () {
          DashCubit();
          var user = StorageService.getUserData();
          print("hello i am here ${user?.user?.phone}");
          Navigator.push(context,
              MaterialPageRoute(builder: (counter) => const DashboardMainScreen()));
        },
        child: Text(
          widget.text,
          style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColor().textFieldColor),
        ));
  }
}
