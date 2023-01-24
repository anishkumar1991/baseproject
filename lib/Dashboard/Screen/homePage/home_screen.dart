import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/event_listview.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/meeting_widget.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/pravas_card_widget.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/sangathan_card_widget.dart';
import 'package:sangathan/Login/Cubit/login_state.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/size_config.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/route/route_path.dart';

import '../../../Login/Cubit/login_cubit.dart';
import '../../../Values/space_width_widget.dart';
import '../../../generated/l10n.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController searchTextController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().getCurrentOrientation(context);
    return Scaffold(
      key: scaffoldKey,
      drawer: draweWidget(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (() {
                      scaffoldKey.currentState!.openDrawer();
                    }),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.greyColor.withOpacity(0.1)),
                      child: Image.asset(
                        AppIcons.drawerIcon,
                        height: 10,
                        color: AppColor.greyColor,
                      ),
                    ),
                  ),
                  Image.asset(
                    AppIcons.sangathanLogo,
                    height: 55,
                    width: 55,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      AppIcons.personImage,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColor.borderColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    Image.asset(
                      AppIcons.searchicon,
                      height: 17,
                      width: 17,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 25,
                        width: double.infinity,
                        child: TextField(
                          controller: searchTextController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              border: InputBorder.none,
                              hintText: S.of(context).viewToursEvents,
                              hintStyle: GoogleFonts.poppins(
                                  color: AppColor.borderColor, fontSize: 14)),
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: (() {}),
                      child: Image.asset(
                        AppIcons.micicon,
                        height: 18,
                        width: 14,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: (() {
                          Navigator.pushNamed(
                              context, RoutePath.sangathanDetailsScreen);
                        }),
                        child: const SngathanCardWidget()),
                    const SizedBox(
                      height: 20,
                    ),
                   const PravasCardWidget(),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'My events',
                          style: TextStyle(
                              fontFamily: 'Tw Cen MT',
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                            fontFamily: 'Tw Cen MT',
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: AppColor.blueTextColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 262,
                        child: EventListView(
                          onTap: (() {}),
                          title: 'Mann ki Baat',
                          subtitle: '97th Edition',
                          date: 'On 29th Jan 2023',
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const MeetingCard(),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget draweWidget(BuildContext context) {
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
                                  Navigator.pushNamed(
                                      context, RoutePath.loginScreen);
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
              scaffoldKey.currentState!.closeDrawer();
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
}
