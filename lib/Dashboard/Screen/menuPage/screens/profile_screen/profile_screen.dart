import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/profile_screen/widgets/sliver_appbar.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/space_width_widget.dart';
import 'package:sangathan/route/route_path.dart';

import '../../../../../Values/app_colors.dart';
import '../../../../../Values/space_height_widget.dart';
import '../../../../../common/appstyle.dart';
import '../../../../../generated/l10n.dart';
import '../personal_info/personal_information_screen.dart';
import 'cubit/profile_cubit.dart';
import 'network/model/user_detail_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    var profileCubit = context.read<ProfileCubit>();
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: ((context, state) {
            if (state is ErrorState) {
              EasyLoading.showError(state.error);
            }
          }),
          builder: (context, state) {
            var cubit = context.read<ProfileCubit>();
            if (state is UserDetailFetchedState) {
              if (state.data.data != null) {
                cubit.userDetails = state.data;
              }
            }
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.36,
                  child: MyAppBar(
                      img: cubit.userDetails?.data?.avatar ?? '',
                      persantage:
                          cubit.userDetails?.data?.percentage?.toDouble() !=
                                  null
                              ? ((cubit.userDetails?.data?.percentage
                                      ?.toDouble())! /
                                  100)
                              : 0.00),
                ),
                Text(
                  cubit.userDetails?.data?.name ?? '',
                  style: textStyleWithPoppin(
                      fontSize: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w700),
                ),
                spaceHeightWidget(2),
                Text(
                  cubit.userDetails?.data?.username ?? '',
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
                        buildMobileRow(cubit: cubit),
                        spaceHeightWidget(15),
                        buildGenderRow(cubit: cubit),
                        spaceHeightWidget(15),
                        customDivider(),
                        spaceHeightWidget(15),
                        buildContainer(
                            showMore: cubit.showAddress,
                            onShowMore: () {
                              cubit.showAddress = !cubit.showAddress;
                              cubit.emitState();
                            },
                            isTitleLeading: true,
                            title: S.of(context).address,
                            icon: AppIcons.marker,
                            des:
                                "${cubit.userDetails?.data?.addresses?.first.houseNumber},${cubit.userDetails?.data?.addresses?.first.area},${cubit.userDetails?.data?.addresses?.first.city},${cubit.userDetails?.data?.addresses?.first.state},${cubit.userDetails?.data?.addresses?.first.pinCode}",
                            desTitle: S.of(context).home,
                            bottomWidget: cubit.showAddress
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: cubit
                                        .userDetails?.data?.addresses?.length,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return SizedBox.shrink();
                                      }
                                      return Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${cubit.userDetails?.data?.addresses?[index].houseNumber},${cubit.userDetails?.data?.addresses?[index].area},${cubit.userDetails?.data?.addresses?[index].city},${cubit.userDetails?.data?.addresses?[index].state},${cubit.userDetails?.data?.addresses?[index].pinCode}",
                                              style: textStyleWithPoppin(
                                                  fontSize: 13,
                                                  color: AppColor
                                                      .naturalBlackColor,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        RoutePath
                                                            .editAddressScreen,
                                                        arguments: {
                                                          "flatNumber": cubit
                                                              .userDetails
                                                              ?.data
                                                              ?.addresses?[
                                                                  index]
                                                              .houseNumber,
                                                          "area": cubit
                                                              .userDetails
                                                              ?.data
                                                              ?.addresses?[
                                                                  index]
                                                              .area,
                                                          "pinCode": cubit
                                                              .userDetails
                                                              ?.data
                                                              ?.addresses?[
                                                                  index]
                                                              .pinCode,
                                                          "town": cubit
                                                              .userDetails
                                                              ?.data
                                                              ?.addresses?[
                                                                  index]
                                                              .city,
                                                          "state": cubit
                                                              .userDetails
                                                              ?.data
                                                              ?.addresses?[
                                                                  index]
                                                              .state,
                                                        });
                                                  },
                                                  child: Text(
                                                    S.of(context).edit,
                                                    style: textStyleWithPoppin(
                                                        fontSize: 14,
                                                        color: AppColor.blue,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                              spaceWidthWidget(8),
                                              const Icon(Icons.edit_outlined,
                                                  size: 18,
                                                  color: AppColor.blue)
                                            ],
                                          ),
                                          spaceHeightWidget(10)
                                        ],
                                      );
                                    })
                                : const SizedBox.shrink(),
                            onEditButton: () {
                              Navigator.pushNamed(
                                  context, RoutePath.editAddressScreen,
                                  arguments: {
                                    "flatNumber": cubit.userDetails?.data
                                        ?.addresses?.first.houseNumber,
                                    "area": cubit.userDetails?.data?.addresses
                                        ?.first.area,
                                    "pinCode": cubit.userDetails?.data
                                        ?.addresses?.first.pinCode,
                                    "town": cubit.userDetails?.data?.addresses
                                        ?.first.city,
                                    "state": cubit.userDetails?.data?.addresses
                                        ?.first.state,
                                  });
                            }),
                        spaceHeightWidget(15),
                        customDivider(),
                        spaceHeightWidget(15),
                        buildContainer(
                            showMore: cubit.showEducation,
                            onShowMore: () {
                              cubit.showEducation = !cubit.showEducation;
                              cubit.emitState();
                            },
                            title: S.of(context).education,
                            icon: AppIcons.educationIcon,
                            des:
                                "${cubit.userDetails?.data?.educationalDetails?.first.startYear} - ${cubit.userDetails?.data?.educationalDetails?.first.endYear}\n${cubit.userDetails?.data?.educationalDetails?.first.institute}",
                            desTitle: cubit.userDetails?.data
                                    ?.educationalDetails?.first.level ??
                                '',
                            bottomWidget: cubit.showEducation
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: cubit.userDetails?.data
                                        ?.educationalDetails?.length,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return SizedBox.shrink();
                                      }
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit
                                                    .userDetails
                                                    ?.data
                                                    ?.educationalDetails?[index]
                                                    .level ??
                                                '',
                                            style: textStyleWithPoppin(
                                                fontSize: 13,
                                                color:
                                                    AppColor.naturalBlackColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "${cubit.userDetails?.data?.educationalDetails?[index].startYear} - ${cubit.userDetails?.data?.educationalDetails?[index].endYear}",
                                            style: textStyleWithPoppin(
                                                fontSize: 13,
                                                color:
                                                    AppColor.naturalBlackColor,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            cubit
                                                    .userDetails
                                                    ?.data
                                                    ?.educationalDetails?[index]
                                                    .institute ??
                                                '',
                                            style: textStyleWithPoppin(
                                                fontSize: 13,
                                                color:
                                                    AppColor.naturalBlackColor,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        RoutePath
                                                            .editEducationScreen,
                                                        arguments: {
                                                          "level": cubit
                                                              .userDetails
                                                              ?.data
                                                              ?.educationalDetails?[
                                                                  index]
                                                              .level,
                                                          "startYear": cubit
                                                              .userDetails
                                                              ?.data
                                                              ?.educationalDetails?[
                                                                  index]
                                                              .startYear,
                                                          "endYear": cubit
                                                              .userDetails
                                                              ?.data
                                                              ?.educationalDetails?[
                                                                  index]
                                                              .endYear,
                                                          "collage": cubit
                                                              .userDetails
                                                              ?.data
                                                              ?.educationalDetails?[
                                                                  index]
                                                              .institute,
                                                        });
                                                  },
                                                  child: Text(
                                                    S.of(context).edit,
                                                    style: textStyleWithPoppin(
                                                        fontSize: 14,
                                                        color: AppColor.blue,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                              spaceWidthWidget(8),
                                              const Icon(Icons.edit_outlined,
                                                  size: 18,
                                                  color: AppColor.blue)
                                            ],
                                          ),
                                          spaceHeightWidget(10)
                                        ],
                                      );
                                    })
                                : SizedBox.shrink(),
                            onEditButton: () {
                              Navigator.pushNamed(
                                  context, RoutePath.editEducationScreen,
                                  arguments: {
                                    "level": cubit.userDetails?.data
                                        ?.educationalDetails?.first.level,
                                    "startYear": cubit.userDetails?.data
                                        ?.educationalDetails?.first.startYear,
                                    "endYear": cubit.userDetails?.data
                                        ?.educationalDetails?.first.endYear,
                                    "collage": cubit.userDetails?.data
                                        ?.educationalDetails?.first.institute,
                                  });
                            }),
                        spaceHeightWidget(15),
                        customDivider(),
                        spaceHeightWidget(15),
                        buildContainer(
                            showMore: cubit.showBusiness,
                            onShowMore: () {
                              cubit.showBusiness = !cubit.showBusiness;
                              cubit.emitState();
                            },
                            title: S.of(context).business,
                            icon: AppIcons.businessIcon,
                            des:
                                "${cubit.userDetails?.data?.professionalDetails?.first.startYear} - ${cubit.userDetails?.data?.professionalDetails?.first.endYear}\n${cubit.userDetails?.data?.professionalDetails?.first.orgName}",
                            desTitle: cubit.userDetails?.data
                                    ?.professionalDetails?.first.position ??
                                '',
                            bottomWidget: cubit.showBusiness
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: cubit.userDetails?.data
                                        ?.professionalDetails?.length,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return SizedBox.shrink();
                                      }
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit
                                                    .userDetails
                                                    ?.data
                                                    ?.professionalDetails?[
                                                        index]
                                                    .position ??
                                                '',
                                            style: textStyleWithPoppin(
                                                fontSize: 13,
                                                color:
                                                    AppColor.naturalBlackColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "${cubit.userDetails?.data?.professionalDetails?[index].startYear} - ${cubit.userDetails?.data?.professionalDetails?[index].endYear}",
                                            style: textStyleWithPoppin(
                                                fontSize: 13,
                                                color:
                                                    AppColor.naturalBlackColor,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            cubit
                                                    .userDetails
                                                    ?.data
                                                    ?.professionalDetails?[
                                                        index]
                                                    .orgName ??
                                                '',
                                            style: textStyleWithPoppin(
                                                fontSize: 13,
                                                color:
                                                    AppColor.naturalBlackColor,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        RoutePath
                                                            .editBusinessScreen,
                                                        arguments: {
                                                          "organization": cubit
                                                              .userDetails
                                                              ?.data
                                                              ?.professionalDetails?[
                                                                  index]
                                                              .orgName,
                                                          "startYear": cubit
                                                              .userDetails
                                                              ?.data
                                                              ?.professionalDetails?[
                                                                  index]
                                                              .startYear,
                                                          "endYear": cubit
                                                              .userDetails
                                                              ?.data
                                                              ?.professionalDetails?[
                                                                  index]
                                                              .endYear,
                                                          "position": cubit
                                                              .userDetails
                                                              ?.data
                                                              ?.professionalDetails?[
                                                                  index]
                                                              .position,
                                                        });
                                                  },
                                                  child: Text(
                                                    S.of(context).edit,
                                                    style: textStyleWithPoppin(
                                                        fontSize: 14,
                                                        color: AppColor.blue,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                              spaceWidthWidget(8),
                                              const Icon(Icons.edit_outlined,
                                                  size: 18,
                                                  color: AppColor.blue)
                                            ],
                                          ),
                                          spaceHeightWidget(10)
                                        ],
                                      );
                                    })
                                : SizedBox.shrink(),
                            onEditButton: () {
                              Navigator.pushNamed(
                                  context, RoutePath.editBusinessScreen,
                                  arguments: {
                                    "organization": cubit.userDetails?.data
                                        ?.professionalDetails?.first.orgName,
                                    "startYear": cubit.userDetails?.data
                                        ?.professionalDetails?.first.startYear,
                                    "endYear": cubit.userDetails?.data
                                        ?.professionalDetails?.first.endYear,
                                    "position": cubit.userDetails?.data
                                        ?.professionalDetails?.first.position,
                                  });
                            }),
                        spaceHeightWidget(15),
                        customDivider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15.0),
                          child: Row(
                            children: [
                              Image.asset(AppIcons.logOutIcon,
                                  height: 18,
                                  width: 18,
                                  color: AppColor.naturalBlackColor
                                      .withOpacity(0.5)),
                              spaceWidthWidget(8),
                              Text(
                                "Logout",
                                style: textStyleWithPoppin(
                                    fontSize: 14,
                                    color: AppColor.naturalBlackColor
                                        .withOpacity(0.5),
                                    fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              Text(
                                "Version 2.11",
                                style: textStyleWithPoppin(
                                    fontSize: 11,
                                    color: AppColor.naturalBlackColor
                                        .withOpacity(0.5),
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
            );
          },
        ),
      ),
    );
  }

  buildMobileRow({required ProfileCubit cubit}) {
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
            cubit.userDetails?.data?.phoneNumber ?? '',
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
            cubit.userDetails?.data?.dob ?? '',
            style: textStyleWithPoppin(
                fontSize: 14,
                color: AppColor.naturalBlackColor,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  buildGenderRow({required ProfileCubit cubit}) {
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
            cubit.userDetails?.data?.gender ?? '',
            style: textStyleWithPoppin(
                fontSize: 14,
                color: AppColor.naturalBlackColor,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          InkWell(
              onTap: () {
                Navigator.pushNamed(
                    context, RoutePath.personalInformationScreen,
                    arguments: cubit.userDetails?.toJson());
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
    return Divider(color: AppColor.greyColor.withOpacity(0.4));
  }

  buildContainer(
      {required String icon,
      required String title,
      required String desTitle,
      required VoidCallback onShowMore,
      required bool showMore,
      required Widget bottomWidget,
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
          GestureDetector(
            onTap: onShowMore,
            child: Row(
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
                Icon(
                  showMore
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_rounded,
                  color: AppColor.black,
                  size: 25,
                )
              ],
            ),
          ),
          spaceHeightWidget(5),
          bottomWidget
        ],
      ),
    );
  }
}
