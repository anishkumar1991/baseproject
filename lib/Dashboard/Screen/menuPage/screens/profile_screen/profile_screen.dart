import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/profile_screen/widgets/profile_address_tile.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/profile_screen/widgets/profile_business_screen.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/profile_screen/widgets/profile_education_screen.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/profile_screen/widgets/sliver_appbar.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/space_width_widget.dart';
import 'package:sangathan/route/route_path.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../Login/Cubit/login_cubit.dart';
import '../../../../../Login/Cubit/login_state.dart';
import '../../../../../Values/app_colors.dart';
import '../../../../../Values/space_height_widget.dart';
import '../../../../../common/appstyle.dart';
import '../../../../../generated/l10n.dart';
import '../../../../Cubit/dashboard_cubit.dart';
import 'cubit/profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

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
                context.read<ProfileCubit>().getDropdownData();
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

                        /// profile address tile
                        ProfileAddressTile(cubit: cubit),
                        spaceHeightWidget(15),
                        customDivider(),
                        spaceHeightWidget(15),

                        /// profile education tile
                        ProfileEducationScreen(cubit: cubit),
                        spaceHeightWidget(15),
                        customDivider(),
                        spaceHeightWidget(15),

                        /// profile business tile
                        ProfileBusinessScreen(cubit: cubit),
                        spaceHeightWidget(15),
                        customDivider(),


                        BlocListener<LoginCubit, LoginState>(
                          listener: (context, state) {
                            if (state is UserLogOutSuccessState) {
                              EasyLoading.showSuccess(state.msg);

                              Navigator.pushNamedAndRemoveUntil(context, RoutePath.loginScreen, (route) => false);
                              context.read<DashBoardCubit>().onTapIcons(0);
                            } else if (state is LogOutLoadingState) {
                              EasyLoading.show();
                            } else if (state is UserLogOutFaieldState) {
                              EasyLoading.showError(state.error);
                            }
                          },
                          child: InkWell(
                            onTap: () async {
                              showConfirmDialog();
                            },
                            child: Padding(
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
                            ),
                          )
                        ),
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

  sizedBoxRow(){
    return Row(
      children: const [
        SizedBox(width: 100),
        Spacer(),
        SizedBox(width: 100),
      ],
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
            onTap: (){
              Navigator.pushNamed(
                  context, RoutePath.personalInformationScreen,
                  arguments: cubit.userDetails?.toJson());
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Text(
                    S.of(context).edit,
                    style: textStyleWithPoppin(
                        fontSize: 14,
                        color: AppColor.blue,
                        fontWeight: FontWeight.w500),
                  ),
                  spaceWidthWidget(8),
                  const Icon(Icons.edit_outlined, size: 18, color: AppColor.blue)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  customDivider() {
    return Divider(color: AppColor.greyColor.withOpacity(0.4));
  }

  Future showConfirmDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(23),
              borderSide: BorderSide.none
          ),
          title:  Text("${S.of(context).logOut}?",style: textStyleWithPoppin(fontSize: 20,color: AppColor.black,fontWeight: FontWeight.w400)),
          content:  Text(S.of(context).logOutDes,style: textStyleWithPoppin(fontSize: 14,color: AppColor.black,fontWeight: FontWeight.w400),),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context),
                child:  Text((S.of(context).noThanks),
                )),
            TextButton(
              onPressed: () async {
                await context.read<LoginCubit>().logOut();
              },
              child:  Text(S.of(context).logOut),
            ),

          ],
        );
      },
    );
  }
}
