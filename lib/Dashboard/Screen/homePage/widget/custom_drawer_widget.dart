import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Login/Cubit/login_cubit.dart';
import '../../../../Login/Cubit/login_state.dart';
import '../../../../Values/app_colors.dart';
import '../../../../Values/icons.dart';
import '../../../../Values/space_height_widget.dart';
import '../../../../Values/space_width_widget.dart';
import '../../../../route/route_path.dart';
import '../home_screen.dart';

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({Key? key}) : super(key: key);

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(16)),
              child: Drawer(
                width: MediaQuery.of(context).size.width * 0.75,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            spaceHeightWidget(50),
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                AppIcons.userImage,
                              ),
                            ),
                            spaceHeightWidget(8),
                            Text(
                              'Sachin Kumar',
                              style: GoogleFonts.inder(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            spaceHeightWidget(5),
                            Text(
                              'Pradesh President',
                              style: GoogleFonts.inder(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  color: AppColor.borderColor),
                            ),
                          ],
                        ),
                      ),
                      spaceHeightWidget(14),
                      Divider(
                        color: AppColor.borderColor.withOpacity(0.4),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            spaceHeightWidget(21),
                            customListTile(
                              icon: AppIcons.profileImage,
                              title: 'Profile',
                            ),
                            spaceHeightWidget(27),
                            customListTile(
                              icon: AppIcons.language,
                              title: 'Language',
                            ),
                            spaceHeightWidget(27),
                            customListTile(
                              icon: AppIcons.help,
                              title: 'Help',
                            ),
                            spaceHeightWidget(27),
                            BlocListener<LoginCubit, LoginState>(
                              listener: (context, state) {
                                if (state is UserLogOutSuccessState) {
                                  EasyLoading.showSuccess(state.msg);
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      RoutePath.loginScreen, (route) => false);
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
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.74899,
          top: 5,
          bottom: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 10,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
              color: AppColor.orange300Color,
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.72,
          top: MediaQuery.of(context).size.height * 0.1,
          child: InkWell(
            onTap: (() {
              homePageScaffoldGlobalKey.currentState!.closeDrawer();
            }),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColor.orange300Color),
              child: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
        )
      ],
    );
  }
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
        height: 17,
      ),
      spaceWidthWidget(8),
      Text(
        title,
        style: GoogleFonts.inter(
            color: AppColor.textBlackColor,
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
      const Spacer(),
      const Icon(
        Icons.arrow_forward_ios,
        size: 20,
      ),
    ],
  );
}
