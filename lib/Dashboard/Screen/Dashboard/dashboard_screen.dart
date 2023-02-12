import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Cubit/dashboard_cubit.dart';
import 'package:sangathan/Dashboard/Cubit/dashboard_state.dart';
import 'package:sangathan/Dashboard/Screen/homePage/home_screen.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/menu_screen.dart';
import 'package:sangathan/Values/app_colors.dart';

import '../../../Values/icons.dart';
import '../socialMedia/posts/MainPage.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  TextEditingController searchTextController = TextEditingController();
  int selectIndex = 0;
  List<Widget> pages = [SocialMediaPage(), HomePage(), const MenuPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocBuilder<DashBoardCubit, NavigationBarState>(
          builder: (context, state) {
            if (state is NavigationBarIndexSelectedState) {
              selectIndex = state.index;
            }
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                pages.elementAt(selectIndex),
                Container(
                  margin:
                      const EdgeInsets.only(bottom: 25, left: 18, right: 18),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(3, 3),
                          blurRadius: 6,
                        ),
                        BoxShadow(
                          color: Colors.white12,
                          offset: Offset(-1, -1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(30),
                      color: AppColor.white),
                  child: BlocBuilder<DashBoardCubit, NavigationBarState>(
                    builder: (context, state) {
                      if (state is NavigationBarIndexSelectedState) {
                        selectIndex = state.index;
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          bottomIcon(
                              icon: selectIndex == 0
                                  ? AppIcons.announceIcon
                                  : AppIcons.announceOutlineImage,
                              onTap: () {
                                context.read<DashBoardCubit>().onTapIcons(0);
                              },
                              color: selectIndex == 0
                                  ? AppColor.cardOrangeColor
                                  : Colors.transparent),
                          bottomIcon(
                              icon: selectIndex == 1
                                  ? AppIcons.homeIcon
                                  : AppIcons.homeOutlineIcon,
                              onTap: (() {
                                context.read<DashBoardCubit>().onTapIcons(1);
                              }),
                              color: selectIndex == 1
                                  ? AppColor.cardOrangeColor
                                  : Colors.transparent),
                          bottomIcon(
                              width: selectIndex == 2 ? 16 : 19,
                              icon: selectIndex == 2
                                  ? AppIcons.menuIcon
                                  : AppIcons.menuOutline,
                              onTap: (() {
                                context.read<DashBoardCubit>().onTapIcons(2);
                              }),
                              color: selectIndex == 2
                                  ? AppColor.cardOrangeColor
                                  : Colors.transparent)
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget bottomIcon(
      {required String icon,
      required VoidCallback onTap,
      required Color color,
      double? width}) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 35,
          padding: const EdgeInsets.only(left: 28, right: 28),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(20)),
          child: Image.asset(
            icon,
            height: 16,
            width: width ?? 19,
          )),
    );
  }
}
