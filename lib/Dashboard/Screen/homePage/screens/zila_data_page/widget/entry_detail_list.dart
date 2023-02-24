import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/cubit/zila_data_cubit.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../AddEntry/Cubit/add_entry_cubit.dart';
import '../../../../../../AddEntry/Screen/add_entry_screen.dart';
import '../../../../../../AddEntry/VerifyPerson/screen/submit_dialog.dart';
import '../../../../../../Values/app_colors.dart';
import '../../../../../../Values/icons.dart';
import '../../../../../../Values/space_height_widget.dart';
import '../../../../../../Values/space_width_widget.dart';
import '../../../../../../common/common_button.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../route/route_path.dart';
import '../cubit/zila_data_state.dart';
import '../zila_data_screen.dart';

//27234
class EntryDetailsList extends StatelessWidget {
  EntryDetailsList({
    Key? key,
    this.type,
    this.dataLevelId,
    this.countryStateId,
  }) : super(key: key);
  final String? type;
  final int? dataLevelId;
  final int? countryStateId;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ZilaDataCubit>();

    return BlocListener<ZilaDataCubit, ZilaDataState>(
      listener: (context, state) {
        if (state is ErrorState) {
          EasyLoading.showError(state.error);
        }
        if (state is DeletePersonSuccessState) {
          EasyLoading.showSuccess(state.message);
        }
        if (state is DeleteReasonErrorState) {
          EasyLoading.showError(state.error);
        }
        if (state is DeletePersonErrorState) {
          EasyLoading.showError(state.error);
        }
      },
      child: BlocBuilder<ZilaDataCubit, ZilaDataState>(
        builder: (context, state) {
          if (state is EntryDataFetchedState) {
            if (state.data.data != null) {
              cubit.dataList = state.data.data!.data!;
              if (cubit.dataList?.isNotEmpty ?? false || cubit.dataList != null) {
                cubit.filterData();
              }
            }
          }
          if (state is DataFetchingLoadingState) {
            cubit.dataList = null;
            return shimmerWidget();
          }
          if (state is DeleteReasonFetchedState) {
            cubit.deleteReasonData = state.deleteReason;
          }

          return cubit.dataList == null
              ? shimmerWidget()
              : Column(
                  children: [
                    ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cubit.dataList?.length ?? 0,
                        separatorBuilder: ((context, index) => spaceHeightWidget(18)),
                        itemBuilder: ((context, index) {
                          final data = cubit.dataList?[index];
                          return Column(
                            children: [
                              Slidable(
                                key: UniqueKey(),
                                endActionPane: ActionPane(motion: const ScrollMotion(), children: [
                                  SlidableAction(
                                    padding: EdgeInsets.zero,
                                    onPressed: ((context) {
                                      print('status=${data?.otpStatus ?? ""}');
                                      data?.otpStatus != null
                                          ? data?.otpStatus == 'verified'
                                              ? EasyLoading.showToast(S.of(context).alreadyVerified)
                                              : showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: ((context) {
                                                    return SubmitDialog(
                                                      subUnitId: cubit.subUnitId,
                                                      mobileNo: data?.phone ?? '',
                                                      personId: data?.id ?? 0,
                                                      levelId: dataLevelId,
                                                      levelName: cubit.levelNameId,
                                                      unitId: cubit.unitId,
                                                      isEdit: true,
                                                      onTapSkip: (() {
                                                        Navigator.pop(context);
                                                      }),
                                                    );
                                                  }))
                                          : null;
                                    }),
                                    backgroundColor: AppColor.greenshade100,
                                    foregroundColor: AppColor.greenshade900,
                                    icon: Icons.verified_user,
                                    label: S.of(context).verify,
                                  ),
                                  cubit.isEditPermission
                                      ? SlidableAction(
                                          padding: EdgeInsets.zero,
                                          onPressed: ((context) {
                                            context.read<AddEntryCubit>().cleanAllVariableData();

                                            ///TODO : here country id is static when type is panna we need make dynamic in future
                                            Navigator.pushNamed(context, RoutePath.addEntryScreen,
                                                arguments: AddEntryPage(
                                                  type: type!,
                                                  isEditEntry: true,
                                                  leaveId: dataLevelId ?? 0,
                                                  unitId: cubit.unitId,
                                                  subUnitId: cubit.subUnitId,
                                                  countryStateId:
                                                      type == "Panna" ? pannaCountryStateId : countryStateId,
                                                  levelName:
                                                      type == "Panna" ? cubit.selectedPannaNo?.id : cubit.levelNameId,
                                                  personID: data?.id,
                                                  pannaID: data?.pannaNumber == null
                                                      ? null
                                                      : int.tryParse(data?.pannaNumber ?? "0"),
                                                  personData: data?.toJson(),
                                                ));
                                          }),
                                          backgroundColor: AppColor.white,
                                          icon: Icons.edit,
                                          label: S.of(context).edit,
                                        )
                                      : const SizedBox(),
                                  cubit.isDeletePermission
                                      ? SlidableAction(
                                          padding: EdgeInsets.zero,
                                          onPressed: ((context) async {
                                            print('data?.otpStatus=${data?.otpStatus}');
                                            cubit.getDeleteId(data?.id);

                                            /// Data Entry Delete Dialog
                                            await dataEntryDeleteDialog(context, cubit, index);
                                          }),
                                          backgroundColor: AppColor.redShade100,
                                          foregroundColor: AppColor.redShade600,
                                          icon: Icons.delete_outline,
                                          label: S.of(context).delete,
                                        )
                                      : SizedBox(),
                                ]),
                                child: InkWell(
                                  onTap: (() {
                                    if (cubit.isEditPermission) {
                                      context.read<AddEntryCubit>().cleanAllVariableData();
                                      Navigator.pushNamed(context, RoutePath.addEntryScreen,
                                          arguments: AddEntryPage(
                                            type: type!,
                                            isEditEntry: true,
                                            leaveId: dataLevelId ?? 0,
                                            unitId: cubit.unitId,
                                            subUnitId: cubit.subUnitId,
                                            countryStateId: type == "Panna" ? pannaCountryStateId : countryStateId,
                                            levelName: type == "Panna" ? cubit.selectedPannaNo?.id : cubit.levelNameId,
                                            personID: data?.id,
                                            pannaID: data?.pannaNumber == null
                                                ? null
                                                : int.tryParse(data?.pannaNumber ?? "0"),
                                            personData: data?.toJson(),
                                          ));
                                    }
                                  }),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image.network(
                                            data?.photo ?? '',
                                            height: 56,
                                            width: 56,
                                            fit: BoxFit.cover,
                                            errorBuilder: ((context, error, stackTrace) => Container(
                                                  height: 56,
                                                  width: 56,
                                                  color: AppColor.navyBlue,
                                                  child: const Icon(
                                                    Icons.person,
                                                    color: AppColor.white,
                                                    size: 28,
                                                  ),
                                                )),
                                          )),
                                      spaceWidthWidget(16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: AutoSizeText(
                                                    /* Localizations.localeOf(
                                                                    context)
                                                                .toString() ==
                                                            "hi"
                                                        ? data?.hindiName ?? ''
                                                        : */
                                                    data?.englishName ?? '',
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600, color: AppColor.textBlackColor),
                                                  ),
                                                ),
                                                spaceWidthWidget(5),
                                                data?.otpStatus != null
                                                    ? data?.otpStatus == 'verified'
                                                        ? const Icon(
                                                            Icons.verified,
                                                            color: AppColor.blue,
                                                            size: 12,
                                                          )
                                                        : const SizedBox.shrink()
                                                    : const SizedBox.shrink()
                                              ],
                                            ),
                                            Text(
                                              data?.designationName ?? '',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500, fontSize: 10, color: AppColor.greyColor),
                                            ),
                                            Text(
                                              "+91-${data?.phone ?? ''}",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600, fontSize: 12, color: AppColor.greyColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (() {
                                          if (data?.phone != null) {
                                            cubit.makePhoneCall(phoneNumber: data?.phone ?? '');
                                          }
                                        }),
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 4),
                                          child: Image.asset(
                                            AppIcons.callIcon,
                                            height: 20,
                                          ),
                                        ),
                                      ),
                                      spaceWidthWidget(4)
                                    ],
                                  ),
                                ),
                              ),
                              index + 1 == cubit.dataList?.length
                                  ? spaceHeightWidget(MediaQuery.of(context).size.height * 0.1)
                                  : const SizedBox.shrink()
                            ],
                          );
                        })),
                  ],
                );
        },
      ),
    );
  }

  dataEntryDeleteDialog(BuildContext context, ZilaDataCubit cubit, int index) async {
    showDialog(
        context: context,
        builder: ((context) {
          return Dialog(child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) privateSetState) {
              return Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      S.of(context).reasonforDeletion,
                      style: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.w600, color: AppColor.textBlackColor),
                    ),
                    spaceHeightWidget(14),
                    ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: ((context, index) => const Divider(
                              color: AppColor.greyColor,
                            )),
                        itemCount: cubit.deleteReasonData?.data?.deletionReasons?.karyakarta?.length ?? 0,
                        itemBuilder: ((context, index) {
                          final data = cubit.deleteReasonData?.data?.deletionReasons?.karyakarta?[index];
                          return InkWell(
                            onTap: (() {
                              context.read<ZilaDataCubit>().selectedDeleteResonIndex = index;
                              context.read<ZilaDataCubit>().selectedDeleteReson = data;
                              privateSetState(() {});
                            }),
                            child: Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: cubit.selectedDeleteResonIndex == index
                                            ? AppColor.buttonOrangeBackGroundColor
                                            : AppColor.greyColor.withOpacity(0.7)),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: cubit.selectedDeleteResonIndex == index
                                            ? AppColor.buttonOrangeBackGroundColor
                                            : AppColor.greyColor.withOpacity(0.7)),
                                  ),
                                ),
                                spaceWidthWidget(6),
                                AutoSizeText(
                                  data ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          );
                        })),
                    const Divider(
                      color: AppColor.greyColor,
                    ),
                    spaceHeightWidget(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CommonButton(
                              onTap: (() {
                                Navigator.pop(context);
                              }),
                              bordercolor: AppColor.white,
                              backGroundcolor: AppColor.white,
                              title: S.of(context).cancel,
                              borderRadius: 5,
                              height: 30,
                              margin: const EdgeInsets.only(left: 20),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600, fontSize: 14, color: AppColor.orange)),
                        ),
                        Expanded(
                          child: CommonButton(
                              onTap: (() {
                                if (cubit.selectedDeleteReson == null) {
                                  EasyLoading.showError(S.of(context).pleaseSelectReason);
                                } else {
                                  Navigator.pop(context);

                                  showDialog(
                                      context: context,
                                      builder: ((context) => AlertDialog(
                                            content: Text(
                                              S.of(context).sureToDelete,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600, color: AppColor.textBlackColor),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: (() {
                                                    Navigator.pop(context);
                                                  }),
                                                  child: Text(S.of(context).no)),
                                              ElevatedButton(
                                                  onPressed: (() async {
                                                    Navigator.pop(context);
                                                    await cubit.deletePerson(
                                                        deleteDataEntryId: cubit.deleteId ?? 0,
                                                        reason: cubit.selectedDeleteReson!,
                                                        index: index);
                                                  }),
                                                  child: Text(S.of(context).yes)),
                                            ],
                                          )));
                                }
                              }),
                              borderRadius: 5,
                              height: 35,
                              margin: const EdgeInsets.only(left: 20),
                              bordercolor: AppColor.redLight,
                              backGroundcolor: AppColor.redLight,
                              title: S.of(context).delete,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600, fontSize: 14, color: AppColor.white)),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ));
        }));
  }

  Widget shimmerWidget() {
    return Shimmer.fromColors(
      baseColor: AppColor.greyColor.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       height: 20,
          //       width: 30,
          //       color: AppColor.white,
          //     ),
          //     Container(
          //       height: 20,
          //       width: 30,
          //       color: AppColor.white,
          //     )
          //   ],
          // ),
          // spaceHeightWidget(10),
          // Container(
          //   height: 32,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //       color: AppColor.white, borderRadius: BorderRadius.circular(20)),
          //   margin: const EdgeInsets.symmetric(horizontal: 10),
          // ),
          spaceHeightWidget(10),
          ListView.separated(
            separatorBuilder: ((context, index) => spaceHeightWidget(10)),
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.white),
                  ),
                  spaceWidthWidget(20),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: AppColor.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: AppColor.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 50.0,
                        height: 8.0,
                        color: AppColor.white,
                      ),
                    ]),
                  ),
                  const Spacer(),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.white),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
