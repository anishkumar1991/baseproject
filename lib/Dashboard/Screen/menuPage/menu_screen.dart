import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sangathan/Login/Cubit/login_cubit.dart';
import 'package:sangathan/Login/Cubit/login_state.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/Values/space_width_widget.dart';
import 'package:sangathan/route/route_path.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceHeightWidget(16),
                      Text(
                        'Tarun chowk',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      spaceHeightWidget(5),
                      Text(
                        '@Tarunchowk234',
                        style: GoogleFonts.poppins(
                            color: AppColor.textBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      spaceHeightWidget(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'See profile',
                            style: GoogleFonts.poppins(
                                color: AppColor.buttonOrangeBackGroundColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          spaceWidthWidget(4),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: AppColor.buttonOrangeBackGroundColor,
                          )
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CircularPercentIndicator(
                        radius: 50,
                        progressColor: AppColor.progressGreenColor,
                        percent: 0.84,
                        center: Image.asset(
                          AppIcons.userLogo,
                          height: 84,
                        ),
                        backgroundColor: AppColor.greyColor.withOpacity(0.3),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 2, right: 2, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.white),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 3, bottom: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.progressGreenColor),
                          child: Row(
                            children: [
                              Text(
                                '82%',
                                style: GoogleFonts.poppins(
                                    color: AppColor.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColor.white,
                                size: 10,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              spaceHeightWidget(30),
              customListTile(
                icon: AppIcons.questionMark,
                title: 'Frequently Asked Questions',
              ),
              spaceHeightWidget(27),
              customListTile(
                icon: AppIcons.helpIcon,
                title: 'Helpline',
              ),
              spaceHeightWidget(27),
              customListTile(
                icon: AppIcons.language,
                title: 'Language',
              ),
              spaceHeightWidget(27),
              BlocListener<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is UserLogOutSuccessState) {
                    EasyLoading.showSuccess(state.msg);
                    Navigator.pushNamed(context, RoutePath.loginScreen);
                  } else if (state is LogOutLoadingState) {
                    EasyLoading.show();
                  } else if (state is UserLogOutFaieldState) {
                    EasyLoading.showError(state.error);
                  }
                },
                child: GestureDetector(
                  onTap: () async {
                    await context.read<LoginCubit>().logOut();
                  },
                  child: customListTile(
                    icon: AppIcons.logOutIcon,
                    title: 'Log Out',
                    height: 20,
                  ),
                ),
              ),
            ])));
  }

  Widget customListTile({
    required String icon,
    required String title,
    double? height,
  }) {
    return Row(
      children: [
        Image.asset(
          icon,
          height: height ?? 24,
        ),
        spaceWidthWidget(8),
        Text(
          title,
          style: GoogleFonts.poppins(
              color: AppColor.textBlackColor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios,
          size: 20,
        ),
      ],
    );
  }
}
