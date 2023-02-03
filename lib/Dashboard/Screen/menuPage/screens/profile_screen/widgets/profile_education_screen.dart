import 'package:flutter/material.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../Values/icons.dart';
import '../../../../../../Values/space_height_widget.dart';
import '../../../../../../Values/space_width_widget.dart';
import '../../../../../../common/appstyle.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../route/route_path.dart';
import '../cubit/profile_cubit.dart';

class ProfileEducationScreen extends StatefulWidget {
  final ProfileCubit cubit;
  const ProfileEducationScreen({Key? key,required this.cubit}) : super(key: key);

  @override
  State<ProfileEducationScreen> createState() => _ProfileEducationScreenState();
}

class _ProfileEducationScreenState extends State<ProfileEducationScreen> {
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
                AppIcons.educationIcon,
                height: 25,
                width: 25,
                color: AppColor.black,
              ),
              spaceWidthWidget(8),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  S.of(context).education,
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
                      context, RoutePath.editEducationScreen,
                      arguments: {
                        "isNew": true,
                        "educationalDetails": widget.cubit.userDetails?.data?.educationalDetails
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
          widget.cubit.userDetails?.data?.educationalDetails?.isNotEmpty ?? false ? Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.cubit.userDetails?.data
                      ?.educationalDetails?.first.level ??
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
                  "${widget.cubit.userDetails?.data?.educationalDetails?.first.startYear} - ${widget.cubit.userDetails?.data?.educationalDetails?.first.endYear}\n${widget.cubit.userDetails?.data?.educationalDetails?.first.institute}",
                  style: textStyleWithPoppin(
                      fontSize: 13,
                      color: AppColor.naturalBlackColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
              spaceHeightWidget(5),
            ],
          ) : SizedBox.shrink(),
          widget.cubit.userDetails?.data?.educationalDetails?.isNotEmpty ?? false ? Align(
           alignment: Alignment.centerRight,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(
                      context, RoutePath.editEducationScreen,
                      arguments: {
                        "index": 0,
                        "educationalDetails": widget.cubit.userDetails?.data?.educationalDetails
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
              ),
            ),
          ) : SizedBox.shrink(),
          widget.cubit.showEducation
              ? ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.cubit.userDetails?.data
                  ?.educationalDetails?.length,
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
                      "${widget.cubit.userDetails?.data?.educationalDetails?[index].startYear} - ${widget.cubit.userDetails?.data?.educationalDetails?[index].endYear}",
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
                          ?.educationalDetails?[index]
                          .institute ??
                          '',
                      style: textStyleWithPoppin(
                          fontSize: 13,
                          color:
                          AppColor.naturalBlackColor,
                          fontWeight: FontWeight.w400),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: InkWell(
                          onTap: (){
                            Navigator.pushNamed(
                                context, RoutePath.editEducationScreen,
                                arguments: {
                                  "index": index,
                                  "educationalDetails": widget.cubit.userDetails?.data?.educationalDetails
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
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
                        ),
                      ),
                    ),
                    spaceHeightWidget(10)
                  ],
                );
              })
              : const SizedBox.shrink(),
          widget.cubit.userDetails!.data!.educationalDetails!.length > 1
              ? GestureDetector(
            onTap: (){
              widget.cubit.showEducation = !widget.cubit.showEducation;
              setState(() {
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.cubit.showEducation ? S.of(context).seeLess : S.of(context).seeMore,
                  style: textStyleWithPoppin(
                      fontSize: 13,
                      color: AppColor.black,
                      fontWeight: FontWeight.w400),
                ),
                spaceWidthWidget(10),
                Icon(
                  widget.cubit.showEducation
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
