import 'package:flutter/material.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/profile_screen/widgets/sliver_appbar.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/space_width_widget.dart';
import 'package:sangathan/route/route_path.dart';

import '../../../../../Values/app_colors.dart';
import '../../../../../Values/space_height_widget.dart';
import '../../../../../common/appstyle.dart';
import '../../../../../generated/l10n.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: const MyAppBar(),
            ),
            Text(
              "तरुण चुघ ( राष्ट्रीय महासचिव )",
              style: textStyleWithPoppin(
                  fontSize: 15,
                  color: AppColor.black,
                  fontWeight: FontWeight.w700),
            ),
            spaceHeightWidget(2),
            Text(
              "@तरुण चुघ 123",
              style: textStyleWithPoppin(
                  fontSize: 10,
                  color: AppColor.greyColor.withOpacity(0.7),
                  fontWeight: FontWeight.w500),
            ),
            spaceHeightWidget(30),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    buildMobileRow(),
                    spaceHeightWidget(15),
                    buildGenderRow(),
                    spaceHeightWidget(15),
                    customDivider(),
                    spaceHeightWidget(15),
                    buildContainer(
                      isTitleLeading: true,
                        title: S.of(context).address,
                        icon: AppIcons.marker,
                        des:
                            "बस स्टैंड रामपुरा, ग्वालियर, स्टेट हाईवे 22,  मध्य प्रदेश,पिन - 331020",
                        desTitle: S.of(context).home,
                        onEditButton: () {
                        Navigator.pushNamed(context, RoutePath.editAddressScreen);
                        }),
                    spaceHeightWidget(15),
                    customDivider(),
                    spaceHeightWidget(15),
                    buildContainer(
                        title: S.of(context).education,
                        icon: AppIcons.educationIcon,
                        des:
                            "Jan 2016 - 2017\nगवर्नमेंट सीनियर सेकेंडरी स्कूल, दिल्ली",
                        desTitle: "10th",
                        onEditButton: () {}),
                    spaceHeightWidget(15),
                    customDivider(),
                    spaceHeightWidget(15),
                    buildContainer(
                        title: S.of(context).business,
                        icon: AppIcons.businessIcon,
                        des:
                            "Jan 2016 - 2017\nनेशनल इंस्टिट्यूट ऑफ़ आर्ट, नई दिल्ली",
                        desTitle: "इंजीनियर",
                        onEditButton: () {}),
                    spaceHeightWidget(15),
                    customDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
                      child: Row(
                        children: [
                          Image.asset(AppIcons.logOutIcon,height: 18,width: 18,color: AppColor.naturalBlackColor.withOpacity(0.5)),
                          spaceWidthWidget(8),
                          Text(
                            "Logout",
                            style: textStyleWithPoppin(
                                fontSize: 14,
                                color: AppColor.naturalBlackColor.withOpacity(0.5),
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            "Version 2.11",
                            style: textStyleWithPoppin(
                                fontSize: 11,
                                color: AppColor.naturalBlackColor.withOpacity(0.5),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildMobileRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Image.asset(
            AppIcons.mobile,
            height: 20,
            width: 20,
          ),
          spaceWidthWidget(5),
          Text(
            "9872837289",
            style: textStyleWithPoppin(
                fontSize: 14,
                color: AppColor.naturalBlackColor,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Image.asset(
            AppIcons.balloons,
            height: 20,
            width: 20,
          ),
          spaceWidthWidget(5),
          Text(
            "12/02/1985",
            style: textStyleWithPoppin(
                fontSize: 14,
                color: AppColor.naturalBlackColor,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  buildGenderRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Image.asset(
            AppIcons.gender,
            height: 20,
            width: 20,
          ),
          spaceWidthWidget(5),
          Text(
            "Male",
            style: textStyleWithPoppin(
                fontSize: 14,
                color: AppColor.naturalBlackColor,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutePath.personalInformationScreen);
              },
              child: Text(
                S.of(context).edit,
                style: textStyleWithPoppin(
                    fontSize: 14,
                    color: AppColor.blue,
                    fontWeight: FontWeight.w500),
              )),
          spaceWidthWidget(8),
          const Icon(Icons.edit_outlined, size: 18, color: AppColor.blue)
        ],
      ),
    );
  }

  customDivider() {
    return const Divider(color: AppColor.dividerColor);
  }

  buildContainer(
      {required String icon,
      required String title,
      required String desTitle,
      bool? isTitleLeading,
      required String des,
      required VoidCallback onEditButton}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                height: 22,
                width: 22,
                color: AppColor.black,
              ),
              spaceWidthWidget(8),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  title,
                  style: textStyleWithPoppin(
                      fontSize: 14,
                      color: AppColor.naturalBlackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.greyColor.withOpacity(0.2)),
                  child: const Center(child: Icon(Icons.add)),
                ),
              )
            ],
          ),
          spaceHeightWidget(5),
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: Row(
              children: [
                isTitleLeading ?? false
                    ? Image.asset(
                        AppIcons.homeOutlineIcon,
                        color: AppColor.black,
                        width: 15,
                        height: 15,
                      )
                    : const SizedBox.shrink(),
                isTitleLeading ?? false
                    ? spaceWidthWidget(8)
                    : const SizedBox.shrink(),
                Text(
                  desTitle,
                  style: textStyleWithPoppin(
                      fontSize: 13,
                      color: AppColor.naturalBlackColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          spaceHeightWidget(5),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              des,
              style: textStyleWithPoppin(
                  fontSize: 13,
                  color: AppColor.naturalBlackColor,
                  fontWeight: FontWeight.w400),
            ),
          ),
          spaceHeightWidget(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: onEditButton,
                  child: Text(
                    S.of(context).edit,
                    style: textStyleWithPoppin(
                        fontSize: 14,
                        color: AppColor.blue,
                        fontWeight: FontWeight.w500),
                  )),
              spaceWidthWidget(8),
              const Icon(Icons.edit_outlined, size: 18, color: AppColor.blue)
            ],
          ),
          spaceHeightWidget(5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.of(context).seeMore,
                style: textStyleWithPoppin(
                    fontSize: 13,
                    color: AppColor.black,
                    fontWeight: FontWeight.w400),
              ),
              spaceWidthWidget(10),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColor.black,
                size: 25,
              )
            ],
          )
        ],
      ),
    );
  }
}
