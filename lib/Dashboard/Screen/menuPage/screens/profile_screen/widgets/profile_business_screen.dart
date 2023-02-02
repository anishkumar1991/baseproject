import 'package:flutter/material.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../Values/icons.dart';
import '../../../../../../Values/space_height_widget.dart';
import '../../../../../../Values/space_width_widget.dart';
import '../../../../../../common/appstyle.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../route/route_path.dart';
import '../cubit/profile_cubit.dart';

class ProfileBusinessScreen extends StatefulWidget {
  final ProfileCubit cubit;
  const ProfileBusinessScreen({Key? key,required this.cubit}) : super(key: key);

  @override
  State<ProfileBusinessScreen> createState() => _ProfileBusinessScreenState();
}

class _ProfileBusinessScreenState extends State<ProfileBusinessScreen> {
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
                AppIcons.businessIcon,
                height: 25,
                width: 25,
                color: AppColor.black,
              ),
              spaceWidthWidget(8),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  S.of(context).business,
                  style: textStyleWithPoppin(
                      fontSize: 14,
                      color: AppColor.naturalBlackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context, RoutePath.editBusinessScreen,
                      arguments: {
                        "isNew": true,
                        "professionalDetails": widget.cubit.userDetails?.data?.professionalDetails
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
          widget.cubit.userDetails?.data?.professionalDetails?.isNotEmpty ?? false ? Column(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.cubit.userDetails?.data
                    ?.professionalDetails?.first.position ??
                    '',
                style: textStyleWithPoppin(
                    fontSize: 13,
                    color: AppColor.naturalBlackColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
            spaceHeightWidget(5),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${widget.cubit.userDetails?.data?.professionalDetails?.first.startYear} - ${widget.cubit.userDetails?.data?.professionalDetails?.first.endYear}\n${widget.cubit.userDetails?.data?.professionalDetails?.first.orgName}",
                style: textStyleWithPoppin(
                    fontSize: 13,
                    color: AppColor.naturalBlackColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
            spaceHeightWidget(5),
          ],) : SizedBox.shrink(),
          widget.cubit.userDetails?.data?.professionalDetails?.isNotEmpty ?? false ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: (){
                    Navigator.pushNamed(
                        context, RoutePath.editBusinessScreen,
                        arguments: {
                          "index": 0,
                          "professionalDetails": widget.cubit.userDetails?.data?.professionalDetails
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
          ) : SizedBox.shrink(),
          widget.cubit.showBusiness
            ? ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.cubit.userDetails?.data
                ?.professionalDetails?.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const SizedBox.shrink();
              }
              return Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cubit
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
                    "${widget.cubit.userDetails?.data?.professionalDetails?[index].startYear} - ${widget.cubit.userDetails?.data?.professionalDetails?[index].endYear}",
                    style: textStyleWithPoppin(
                        fontSize: 13,
                        color:
                        AppColor.naturalBlackColor,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    widget.cubit
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
                                  "index": index,
                                  "professionalDetails": widget.cubit.userDetails?.data?.professionalDetails
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
          widget.cubit.userDetails!.data!.professionalDetails!.length > 1
              ? GestureDetector(
            onTap: (){
              widget.cubit.showBusiness = !widget.cubit.showBusiness;
              setState(() {
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.cubit.showBusiness ? S.of(context).seeLess : S.of(context).seeMore,
                  style: textStyleWithPoppin(
                      fontSize: 13,
                      color: AppColor.black,
                      fontWeight: FontWeight.w400),
                ),
                spaceWidthWidget(10),
                Icon(
                  widget.cubit.showBusiness
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_rounded,
                  color: AppColor.black,
                  size: 25,
                )
              ],
            ),
          )
          : SizedBox.shrink(),
        ],
      ),
    );
  }
}
