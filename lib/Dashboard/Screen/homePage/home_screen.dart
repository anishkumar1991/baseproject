import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/event_listview.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/meeting_widget.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/pravas_card_widget.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/sangathan_card_widget.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/size_config.dart';
import 'package:sangathan/route/route_path.dart';

import '../../../generated/l10n.dart';
import 'widget/custom_drawer_widget.dart';

final homePageScaffoldGlobalKey = GlobalKey<ScaffoldState>();

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().getCurrentOrientation(context);
    return Scaffold(
      key: homePageScaffoldGlobalKey,
      drawer: const CustomDrawerWidget(),
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
                      homePageScaffoldGlobalKey.currentState!.openDrawer();
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
                    /// Sangathan card widget
                    GestureDetector(
                        onTap: (() {
                          Navigator.pushNamed(
                              context, RoutePath.sangathanDetailsScreen);
                        }),
                        child: const SngathanCardWidget()),
                    const SizedBox(
                      height: 20,
                    ),

                    /// pravas card widget
                    const PravasCardWidget(),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).myEvent,
                          style: const TextStyle(
                              fontFamily: 'Tw Cen MT',
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          S.of(context).seeAll,
                          style: const TextStyle(
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
                        height: 270,
                        child: EventListView(
                          onTap: (() {}),
                          title: 'Mann ki Baat',
                          subtitle: '97th Edition',
                          date: 'On 29th Jan 2023',
                        )),
                    const SizedBox(
                      height: 10,
                    ),

                    /// Meeting card widget
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
}
