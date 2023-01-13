import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Cubit/dashboard_cubit.dart';
import 'package:sangathan/Dashboard/Cubit/dashboard_state.dart';
import 'package:sangathan/Dashboard/Screen/announcementPage/announcment_screen.dart';
import 'package:sangathan/Dashboard/Screen/homePage/home_screen.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/menu_screen.dart';
import 'package:sangathan/Values/app_colors.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  TextEditingController searchTextController = TextEditingController();
  int selectIndex = 0;
  List<Widget> pages = [const AnnouncePage(), HomePage(), const MenuPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashBoardCubit, NavigationBarState>(
        builder: (context, state) {
          if (state is NavigationBarIndexSelectedState) {
            selectIndex = state.index;
          }
          return pages.elementAt(selectIndex);
        },
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ], borderRadius: BorderRadius.circular(28), color: Colors.white),
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
                        ? Icons.campaign
                        : Icons.campaign_outlined,
                    onTap: () {
                      context.read<DashBoardCubit>().onTapIcons(0);
                    },
                    color: selectIndex == 0
                        ? AppColor.cardOrangeColor
                        : Colors.transparent),
                bottomIcon(
                    icon: selectIndex == 1
                        ? Icons.home_filled
                        : Icons.home_outlined,
                    onTap: (() {
                      context.read<DashBoardCubit>().onTapIcons(1);
                    }),
                    color: selectIndex == 1
                        ? AppColor.cardOrangeColor
                        : Colors.transparent),
                bottomIcon(
                    icon: selectIndex == 2 ? Icons.apps : Icons.apps_outlined,
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
    );
  }

  Widget bottomIcon(
      {required IconData icon,
      required GestureTapCallback onTap,
      required Color color}) {
    return Container(
      height: 35,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: IconButton(
        splashRadius: 2,
        onPressed: onTap,
        icon: Icon(icon),
      ),
    );
  }
}
