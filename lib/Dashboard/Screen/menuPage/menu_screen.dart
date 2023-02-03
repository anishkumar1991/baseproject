import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/profile_screen/cubit/profile_cubit.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/Values/space_width_widget.dart';
import 'package:sangathan/route/route_path.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/appstyle.dart';
import '../../../generated/l10n.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  Future callApi() async {
    context.read<ProfileCubit>().getUserDetails();
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state){
            var cubit = context.read<ProfileCubit>();
            if (state is UserDetailFetchedState) {
              if (state.data.data != null) {
                cubit.userDetails = state.data;
                // context.read<ProfileCubit>().getDropdownData();
              }
            }else if (state is ErrorState) {
              EasyLoading.showError(state.error);
            }else if(state is ProfileLoadingState){
              return Shimmer.fromColors(
                baseColor: AppColor.greyColor.withOpacity(0.3),
                highlightColor: Colors.grey.withOpacity(0.1),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(children: [
                      ListTile(
                        minLeadingWidth : 5,
                        onTap: () {
                          Navigator.pushNamed(context, RoutePath.profileScreen);
                        },
                        contentPadding: EdgeInsets.zero,
                        title: Container(
                            height: 15,
                          width: MediaQuery.of(context).size.width * 0.5,
                            color: AppColor.white
                        ),
                        subtitle: Container(
                          width: 50,
                          height: 10,
                            color: AppColor.white
                        ),
                        trailing: Container(
                            width: 20,
                            height:20, decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white
                        ),
                        ),
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white
                          ),
                        ),
                      ),
                      spaceHeightWidget(15),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.greyColor.withOpacity(0.2),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "#",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  )),
                              spaceWidthWidget(10),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  S.of(context).ThemeandInsight,
                                  style: textStyleWithPoppin(
                                      fontSize: 14,
                                      color: AppColor.naturalBlackColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const Spacer(),
                              const Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: Icon(Icons.arrow_forward_ios_outlined,
                                    size: 18, color: AppColor.naturalBlackColor),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.12,
                                right: 4),
                            child: Text(
                              S.of(context).ThemeDes,
                              style: textStyleWithPoppin(
                                  color: AppColor.greyColor.withOpacity(0.7),
                                  fontSize: 13),
                            ),
                          )
                        ],
                      ),
                      spaceHeightWidget(MediaQuery.of(context).size.height * 0.08),
                      customListTile(title: "Support", icon: AppIcons.supportIcon),
                      spaceHeightWidget(10),
                      const Divider(
                        color: AppColor.dividerColor,
                      ),
                      spaceHeightWidget(5),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: customBottomContainer())
                    ]))
              );
            }
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(children: [
                  ListTile(
                    minLeadingWidth : 5,
                    onTap: () {
                      Navigator.pushNamed(context, RoutePath.profileScreen);
                    },
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "${S.of(context).welcome}, ${cubit.userDetails?.data?.name}",
                      overflow: TextOverflow.ellipsis,
                      style: textStyleWithPoppin(
                          fontSize: 15,
                          color: AppColor.black,
                          fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      "@${cubit.userDetails?.data?.username}",
                      style: textStyleWithPoppin(
                          fontSize: 10,
                          color: AppColor.greyColor.withOpacity(0.7),
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                      color: AppColor.naturalBlackColor,
                    ),
                    leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(350),
                        child: Image.network(
                          cubit.userDetails?.data?.avatar ?? '',
                          fit: BoxFit.cover,
                          errorBuilder:
                              (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return const Icon(Icons.person,size: 25);
                          },
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),),
                    ),
                  ),
                  spaceHeightWidget(15),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.greyColor.withOpacity(0.2),
                              ),
                              child: const Center(
                                child: Text(
                                  "#",
                                  style: TextStyle(fontSize: 25),
                                ),
                              )),
                          spaceWidthWidget(10),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              S.of(context).ThemeandInsight,
                              style: textStyleWithPoppin(
                                  fontSize: 14,
                                  color: AppColor.naturalBlackColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                size: 18, color: AppColor.naturalBlackColor),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.12,
                            right: 4),
                        child: Text(
                          S.of(context).ThemeDes,
                          style: textStyleWithPoppin(
                              color: AppColor.greyColor.withOpacity(0.7),
                              fontSize: 13),
                        ),
                      )
                    ],
                  ),
                  spaceHeightWidget(MediaQuery.of(context).size.height * 0.08),
                  customListTile(title: "Support", icon: AppIcons.supportIcon),
                  spaceHeightWidget(10),
                  const Divider(
                    color: AppColor.dividerColor,
                  ),
                  spaceHeightWidget(5),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: customBottomContainer())
                ]));
          },
        ));
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
          height: height ?? 22,
        ),
        spaceWidthWidget(10),
        Text(
          title,
          style: textStyleWithPoppin(
              color: AppColor.greyColor.withOpacity(0.7), fontSize: 15),
        ),
      ],
    );
  }

  Widget customBottomContainer() {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.greyColor.withOpacity(0.4))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppIcons.customerService1,
            color: AppColor.greyColor.withOpacity(0.5),
            height: 22,
          ),
          spaceHeightWidget(5),
          Text(
            "Support",
            style: textStyleWithPoppin(
                color: AppColor.greyColor.withOpacity(0.7), fontSize: 13),
          )
        ],
      ),
    );
  }
}
