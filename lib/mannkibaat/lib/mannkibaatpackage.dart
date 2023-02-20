library mannkibaatpackage;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/mannkibaat/lib/attendeesformpage/cubit/FetchCubit.dart';
import 'package:sangathan/mannkibaat/lib/reportedprogramspage/cubit/DashCubit.dart';
import 'package:sangathan/mannkibaat/lib/reportedprogramspage/screens/newscreens/MainDashboard.dart';
import 'package:sangathan/mannkibaat/lib/values/AppColors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final String authenticationToken;

  const MainButton(
      {Key? key, required this.authenticationToken, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchCubit(),
      child: ElevatedButton(
          style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(
                AppColor().buttonShadowColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            backgroundColor: MaterialStateProperty.all(AppColor().buttonColor),
          ),
          onPressed: () {
            DashCubit(authenticationToken);
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (counter) => const DashboardMainScreen()));
          },
          child: Text(
            text,
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColor().textFieldColor),
          )),
    );
  }
}
