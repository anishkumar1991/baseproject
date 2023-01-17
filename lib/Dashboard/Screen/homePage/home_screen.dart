import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/customListview.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/meeting_widget.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/pravas_card_widget.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/sangathan_card_widget.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/size_config.dart';
import 'package:sangathan/route/route_path.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().getCurrentOrientation(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppIcons.notification,
                    height: 32,
                    width: 32,
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
                              hintText: 'प्रवास और  कार्याक्रम देखे',
                              hintStyle: GoogleFonts.poppins(
                                  color: AppColor.borderColor, fontSize: 14)),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      AppIcons.micicon,
                      height: 18,
                      width: 14,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: (() {
                    Navigator.pushNamed(
                        context, RoutePath.sangathanDetailsScreen);
                  }),
                  child: const SngathanCardWidget()),
              const SizedBox(
                height: 20,
              ),
              PravasCardWidget(),
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
              const SizedBox(height: 257, child: EventListView()),
              const SizedBox(
                height: 10,
              ),
              const MeetingCard(),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
