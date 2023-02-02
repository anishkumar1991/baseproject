import 'package:flutter/material.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/profile_screen/cubit/profile_cubit.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../Values/icons.dart';
import '../../../../../../Values/space_height_widget.dart';
import '../../../../../../Values/space_width_widget.dart';
import '../../../../../../common/appstyle.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../route/route_path.dart';

class ProfileAddressTile extends StatefulWidget {
  final ProfileCubit cubit;

  const ProfileAddressTile({Key? key, required this.cubit}) : super(key: key);

  @override
  State<ProfileAddressTile> createState() => _ProfileAddressTileState();
}

class _ProfileAddressTileState extends State<ProfileAddressTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppIcons.marker,
                height: 25,
                width: 25,
                color: AppColor.black,
              ),
              spaceWidthWidget(5),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  S.of(context).address,
                  style: textStyleWithPoppin(
                      fontSize: 14,
                      color: AppColor.naturalBlackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutePath.editAddressScreen,arguments: {
                    "isNew" : true,
                    "addresses": widget.cubit.userDetails?.data?.addresses
                  });
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.greyColor.withOpacity(0.2)),
                  child: const Center(child: Icon(Icons.add)),
                ),
              )
            ],
          ),
          spaceHeightWidget(5),
          spaceHeightWidget(5),
          widget.cubit.userDetails?.data?.addresses?.isNotEmpty ?? false ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3.0,bottom: 5),
                child: Row(
                  children: [
                    Image.asset(
                      AppIcons.homeOutlineIcon,
                      color: AppColor.black,
                      width: 15,
                      height: 15,
                    ),
                    spaceWidthWidget(8),
                    Text(
                      S.of(context).home,
                      style: textStyleWithPoppin(
                          fontSize: 13,
                          color: AppColor.naturalBlackColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.cubit.userDetails?.data?.addresses?.first.houseNumber},${widget.cubit.userDetails?.data?.addresses?.first.area},${widget.cubit.userDetails?.data?.addresses?.first.city},${widget.cubit.userDetails?.data?.addresses?.first.state},${widget.cubit.userDetails?.data?.addresses?.first.pinCode}",
                  style: textStyleWithPoppin(
                      fontSize: 13,
                      color: AppColor.naturalBlackColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ) : SizedBox.shrink(),
          spaceHeightWidget(5),
          widget.cubit.userDetails?.data?.addresses?.isNotEmpty ?? false ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePath.editAddressScreen,
                        arguments: {
                          "index": 0,
                          "addresses": widget.cubit.userDetails?.data?.addresses
                        });
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
          ) : const SizedBox.shrink(),
          spaceHeightWidget(5),
          widget.cubit.showAddress
              ? ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.cubit.userDetails?.data?.addresses?.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0,bottom: 5),
                          child: Row(
                            children: [
                              Image.asset(
                                AppIcons.homeOutlineIcon,
                                color: AppColor.black,
                                width: 15,
                                height: 15,
                              ),
                              spaceWidthWidget(8),
                              Text(
                                S.of(context).home,
                                style: textStyleWithPoppin(
                                    fontSize: 13,
                                    color: AppColor.naturalBlackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${widget.cubit.userDetails?.data?.addresses?[index].houseNumber},${widget.cubit.userDetails?.data?.addresses?[index].area},${widget.cubit.userDetails?.data?.addresses?[index].city},${widget.cubit.userDetails?.data?.addresses?[index].state},${widget.cubit.userDetails?.data?.addresses?[index].pinCode}",
                            style: textStyleWithPoppin(
                                fontSize: 13,
                                color: AppColor.naturalBlackColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  print("hello");
                                  Navigator.pushNamed(
                                      context, RoutePath.editAddressScreen,
                                      arguments: {
                                        "index": index,
                                        "addresses": widget.cubit.userDetails?.data?.addresses
                                      });
                                },
                                child: Text(
                                  S.of(context).edit,
                                  style: textStyleWithPoppin(
                                      fontSize: 14,
                                      color: AppColor.blue,
                                      fontWeight: FontWeight.w500),
                                )),
                            spaceWidthWidget(8),
                            const Icon(Icons.edit_outlined,
                                size: 18, color: AppColor.blue)
                          ],
                        ),
                        spaceHeightWidget(10)
                      ],
                    );
                  })
              : const SizedBox.shrink(),
          widget.cubit.userDetails!.data!.addresses!.length > 1
              ? GestureDetector(
            onTap: () {
              widget.cubit.showAddress = !widget.cubit.showAddress;
              // cubit.emitState();
              setState(() {
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.cubit.showAddress ? S.of(context).seeLess : S.of(context).seeMore,
                  style: textStyleWithPoppin(
                      fontSize: 13,
                      color: AppColor.black,
                      fontWeight: FontWeight.w400),
                ),
                spaceWidthWidget(10),
                Icon(
                  widget.cubit.showAddress
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_rounded,
                  color: AppColor.black,
                  size: 25,
                )
              ],
            ),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
