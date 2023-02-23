import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/network/model/shakti_kendr_model.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/cubit/edit_shakti_kendr_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/widgets/delete_confirmation_dialog.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/widgets/header_widget_shakti_kendra.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/widgets/shimmer_widget.dart';
import 'package:sangathan/Values/icons.dart';

import '../../../../../Values/app_colors.dart';
import '../../../../../Values/space_height_widget.dart';
import '../../../../../Values/space_width_widget.dart';
import '../../../../../common/common_button.dart';
import '../../../../../common/common_logo_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../route/route_path.dart';
import '../sangathan_details/cubit/sangathan_detail_cubit.dart';
import '../sangathan_details/network/model/ClientAppPermissionModel.dart';
import 'cubit/shakti_kendra_cubit.dart';
import 'widgets/sk_filter.dart';

class ShaktiKendraScreen extends StatefulWidget {
  final List<AppPermissions>? permissionData;

  const ShaktiKendraScreen({Key? key, this.permissionData}) : super(key: key);

  @override
  State<ShaktiKendraScreen> createState() => _ShaktiKendraScreenState();
}

class _ShaktiKendraScreenState extends State<ShaktiKendraScreen> {
  @override
  void initState() {
    apiCall();
    super.initState();
  }

  int locationId = 0;
  String locationType = "";

  apiCall() async {
    locationId = context.read<SangathanDetailsCubit>().selectedAllottedLocation?.id ?? 0;
    locationType = context.read<SangathanDetailsCubit>().typeLevelName ?? "";
    for (int i = 0; i < (widget.permissionData?.length ?? 0); i++) {
      if (widget.permissionData?[i].action?.toLowerCase() == 'Edit'.toLowerCase()) {
        context.read<ShaktiKendraCubit>().isEditPermission = true;
      } else if (widget.permissionData?[i].action?.toLowerCase() == 'Create'.toLowerCase()) {
        context.read<ShaktiKendraCubit>().isCreatePermission = true;
      } else if (widget.permissionData?[i].action?.toLowerCase() == 'Delete'.toLowerCase()) {
        context.read<ShaktiKendraCubit>().isDeletePermission = true;
      }
    }
    context.read<ShaktiKendraCubit>().shaktiKendr.data = null;
    context.read<ShaktiKendraCubit>().sortedShaktiKendr.data = null;
    context.read<ShaktiKendraCubit>().isExpanded = false;
    context.read<ShaktiKendraCubit>().selectedMandal = "All";
    context.read<ShaktiKendraCubit>().zilaSelected = null;
    context.read<ShaktiKendraCubit>().isSelectedIndex = -1;
    context.read<ShaktiKendraCubit>().zilaSelectedName = "";

    context.read<ShaktiKendraCubit>().getDropDownValueOfVidhanSabha(id: locationId, locationType: locationType);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ShaktiKendraCubit>(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceHeightWidget(10),
              headerWidgetShaktiKendra(context),
              spaceHeightWidget(MediaQuery.of(context).size.height * 0.02),
              BlocBuilder<ShaktiKendraCubit, ShaktiKendraState>(
                builder: (context, state) {
                  final cubit = context.read<ShaktiKendraCubit>();
                  if (state is FatchDataVidhanSabhaState) {
                    vidhanSabha = state.data;
                    if (vidhanSabha.data?.locations != null && (vidhanSabha.data?.locations?.isNotEmpty ?? false)) {
                      cubit.zilaSelectedName = "${vidhanSabha.data?.locations?.first.number ?? ''} - ${vidhanSabha.data?.locations?.first.name ?? ''}";
                      cubit.zilaSelected = vidhanSabha.data?.locations?.first;
                      context.read<EditShaktiKendrCubit>().getDropDownValueOfmandal(id: vidhanSabha.data?.locations?.first.id ?? 0, isEdit: false);
                      cubit.getShaktiKendra(id: vidhanSabha.data?.locations?.first.id ?? 357);
                    }
                  } else if (state is ErrorVidhanSabhaState) {
                    EasyLoading.showError(state.error);
                    vidhanSabha.data?.locations = [];
                    cubit.shaktiKendr.data = [];
                  }
                  return vidhanSabha.data?.locations?.isNotEmpty ?? false
                      ? Column(
                          children: [
                            ListTile(
                              horizontalTitleGap: 8,
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28.0),
                                    ),
                                    builder: (builder) {
                                      return bottom(
                                        context: context,
                                        cubit: cubit,
                                        text: S.of(context).vidhanSabha,
                                      );
                                    });
                              },
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                height: 47,
                                width: 47,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      colors: [
                                        AppColor.purple50,
                                        AppColor.orange200,
                                      ],
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                child: Image.asset(AppIcons.vidhanSabha),
                              ),
                              title: Text(
                                S.of(context).vidhanSabha,
                                style: GoogleFonts.poppins(color: AppColor.black700, fontWeight: FontWeight.w400, fontSize: 14),
                              ),
                              subtitle: Text(
                                cubit.zilaSelectedName,
                                style: GoogleFonts.poppins(color: AppColor.black700, fontWeight: FontWeight.w400, fontSize: 14),
                              ),
                              trailing: const SizedBox(
                                height: double.infinity,
                                child: Icon(
                                  Icons.expand_more,
                                  color: AppColor.textBlackColor,
                                  size: 24,
                                ),
                              ),
                            ),
                            const Divider(
                              color: AppColor.black,
                              thickness: 1,
                            )
                          ],
                        )
                      : const SizedBox.shrink();
                },
              ),
              spaceHeightWidget(10),
              Expanded(
                child: BlocConsumer<ShaktiKendraCubit, ShaktiKendraState>(
                  listener: (BuildContext context, Object? state) {
                    if (state is ShaktiKendraErrorState) {
                      EasyLoading.showError(state.error);
                    }
                  },
                  builder: (BuildContext context, state) {
                    if (state is LoadingShaktiKendraDetailState) {
                      return const ShimmerWidget();
                    } else if (state is ShaktiKendraFatchData) {
                      if (state.data.data != null) {
                        Map<String, dynamic> clonedObject = json.decode(json.encode(state.data));
                        cubit.shaktiKendr = ShaktiKendr.fromJson(clonedObject);
                        cubit.sortedShaktiKendr = state.data;
                        cubit.selectedMandal = "All";
                        cubit.changeFilter();
                        cubit.filterBasedOnMandal();
                      }
                    }
                    return cubit.sortedShaktiKendr.data == null
                        ? const ShimmerWidget()
                        : Column(
                            children: [
                              /// SK Filter
                              const SKFilter(),
                              spaceHeightWidget(15),

                              /// Sk data List
                              Expanded(
                                child: (cubit.sortedShaktiKendr.data?.isNotEmpty ?? false)
                                    ? ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: cubit.sortedShaktiKendr.data?.length,
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return buildBottomContainer(data: cubit.sortedShaktiKendr.data![index], cubit: cubit);
                                        })
                                    : Center(
                                        child: Text(
                                          S.of(context).noDataAvailable,
                                          style: GoogleFonts.poppins(color: AppColor.black, fontSize: 14),
                                        ),
                                      ),
                              ),
                            ],
                          );
                  },
                ),
              ),
              spaceHeightWidget(15),
              cubit.isCreatePermission
                  ? BlocBuilder<ShaktiKendraCubit, ShaktiKendraState>(
                      builder: (context, state) {
                        return vidhanSabha.data?.locations?.isNotEmpty ?? false
                            ? CommonButton(
                                borderRadius: 10,
                                title: S.of(context).makeShaktikendr,
                                onTap: () {
                                  if (vidhanSabha.data?.locations?.isNotEmpty ?? false) {
                                    context.read<EditShaktiKendrCubit>().shaktiKendrCtr.clear();
                                    context.read<EditShaktiKendrCubit>().zilaSelected = "";
                                    context.read<EditShaktiKendrCubit>().mandalSelected = "";
                                    context.read<EditShaktiKendrCubit>().chekedValue = [];
                                    context.read<EditShaktiKendrCubit>().selectedBooth = [];
                                    context.read<EditShaktiKendrCubit>().alreadyExitBooth = [];
                                    Navigator.pushNamed(context, RoutePath.editShaktiKendraScreen, arguments: {
                                      'isEdit': false,
                                      "shaktiKendr": context.read<ShaktiKendraCubit>().shaktiKendr,
                                    });
                                  }
                                },
                                style: GoogleFonts.poppins(color: AppColor.white, fontSize: 14),
                                padding: const EdgeInsets.symmetric(vertical: 10))
                            : const SizedBox.shrink();
                      },
                    )
                  : const SizedBox.shrink(),
              spaceHeightWidget(cubit.isCreatePermission ? 15 : 0),
            ],
          ),
        ),
      ),
    );
  }

  buildBottomContainer({required ShaktiKendrData data, required ShaktiKendraCubit cubit}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        decoration: BoxDecoration(border: Border.all(color: AppColor.dividerColor), borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            ListTile(
              horizontalTitleGap: 8,
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.16),
                  gradient: const LinearGradient(
                      colors: [
                        AppColor.purple50,
                        AppColor.orange200,
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Image.asset(AppIcons.shaktikendraImage),
              ),
              title: Text(
                data.name ?? S.of(context).shaktikendr,
                style: GoogleFonts.poppins(color: AppColor.black, fontSize: 14),
              ),
              subtitle: data.mandal?.name != null
                  ? Text(
                      "${S.of(context).mandal} - ${data.mandal?.name}",
                      style: GoogleFonts.poppins(color: AppColor.naturalBlackColor, fontSize: 12),
                    )
                  : Text(
                      "${S.of(context).mandal} - ${S.of(context).noDataAvailable}",
                      style: GoogleFonts.poppins(color: AppColor.naturalBlackColor, fontSize: 12),
                    ),
              trailing: cubit.isEditPermission
                  ? InkWell(
                      onTap: () {
                        context.read<EditShaktiKendrCubit>().shaktiKendrCtr.clear();
                        context.read<EditShaktiKendrCubit>().zilaSelected = "";
                        context.read<EditShaktiKendrCubit>().mandalSelected = "";
                        context.read<EditShaktiKendrCubit>().chekedValue = [];
                        context.read<EditShaktiKendrCubit>().selectedBooth = [];
                        context.read<EditShaktiKendrCubit>().alreadyExitBooth = [];
                        List<int> boothId = [];
                        List<int> boothNumber = [];
                        if (data.booths?.isNotEmpty ?? false) {
                          for (int i = 0; i < (data.booths?.length ?? 0); i++) {
                            boothId.add(data.booths?[i].id ?? 0);
                            boothNumber.add(int.parse(data.booths?[i].number ?? ''));
                          }
                        }
                        Navigator.pushNamed(context, RoutePath.editShaktiKendraScreen, arguments: {
                          'isEdit': true,
                          'vidhanSabhaName': context.read<ShaktiKendraCubit>().zilaSelectedName,
                          "vidhanSabhaId": context.read<ShaktiKendraCubit>().zilaSelected?.id,
                          "mandalName": data.mandal?.name,
                          "shaktiKendrName": data.name,
                          "boothId": boothId,
                          "shaktiKendrId": data.id,
                          "boothNumber": boothNumber,
                          "shaktiKendr": context.read<ShaktiKendraCubit>().shaktiKendr
                        });
                      },
                      child: Container(
                        height: 38,
                        width: 38,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.16), color: AppColor.dividerColor.withOpacity(0.5)),
                        child: const Icon(Icons.mode_edit_outlined, color: AppColor.black),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColor.dividerColor.withOpacity(0.5)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).booth,
                            style: GoogleFonts.poppins(color: AppColor.naturalBlackColor.withOpacity(0.6), fontSize: 12),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            color: AppColor.naturalBlackColor.withOpacity(0.5),
                            width: 40,
                            height: 1,
                          )
                        ],
                      ),
                      spaceWidthWidget(10),
                      ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.5,
                          ),
                          child: data.booths?.isEmpty ?? false
                              ? Text(
                                  S.of(context).noBoothAvailable,
                                  style: GoogleFonts.poppins(color: AppColor.black700, fontWeight: FontWeight.w400, fontSize: 14),
                                )
                              : SizedBox(
                                  height: 25,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: data.booths?.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Text(
                                              data.booths![index].number.toString(),
                                              style: GoogleFonts.poppins(color: AppColor.black700, fontWeight: FontWeight.w400, fontSize: 14),
                                            ),
                                            index + 1 == data.booths?.length
                                                ? const SizedBox.shrink()
                                                : Text(
                                                    ", ",
                                                    style: GoogleFonts.poppins(color: AppColor.black700, fontWeight: FontWeight.w400, fontSize: 14),
                                                  ),
                                          ],
                                        );
                                      }),
                                )),
                    ],
                  ),
                ),
                const Spacer(),
                cubit.isDeletePermission
                    ? BlocBuilder<ShaktiKendraCubit, ShaktiKendraState>(
                        builder: (context, state) {
                          if (state is DeleteDataShaktiKendraLoadingState) {
                            EasyLoading.show();
                          } else if (state is DeleteShaktiKendraFatchDataState) {
                            EasyLoading.dismiss();
                            if (state.data.data?.askConfirmation == true) {
                            } else {
                              EasyLoading.showSuccess(state.data.message ?? '');
                              context.read<ShaktiKendraCubit>().getShaktiKendra(id: context.read<ShaktiKendraCubit>().zilaSelected?.id ?? 357);
                            }
                          } else if (state is DeleteShaktiKendraErrorState) {
                            EasyLoading.dismiss();
                            EasyLoading.showToast(state.error);
                          }
                          return InkWell(
                            onTap: () {
                              dataEntryDeleteDialog(
                                  title: "${S.of(context).deletrShaktiKendrTitle}?",
                                  subTitle: "${data.mandal?.name}\n${S.of(context).deleteShaktiKendr}",
                                  context: context,
                                  onDelete: () async {
                                    Navigator.pop(context);
                                    await context.read<ShaktiKendraCubit>().deleteShaktiKendr(id: data.id!, context: context, isConfirmDelete: false);
                                  });
                            },
                            child: Container(
                              height: 38,
                              width: 38,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.16), color: AppColor.dividerColor.withOpacity(0.5)),
                              child: const Icon(Icons.delete_outline, color: AppColor.black),
                            ),
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            )
          ],
        ),
      ),
    );
  }

  bottom({required BuildContext context, required ShaktiKendraCubit cubit, required String text}) {
    return Container(
      color: Colors.transparent,
      child: Container(
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0), topRight: Radius.circular(28.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceHeightWidget(30),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: AppColor.borderColor, fontSize: 16),
                ),
                spaceHeightWidget(30),
                Expanded(
                  child: vidhanSabha.data?.locations?.isNotEmpty ?? false
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: vidhanSabha.data?.locations?.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    cubit.zilaSelected = vidhanSabha.data?.locations?[index];
                                    cubit.zilaSelectedName = "${vidhanSabha.data?.locations?[index].number ?? ''} - ${vidhanSabha.data?.locations?[index].name ?? ''}";
                                    context.read<EditShaktiKendrCubit>().getDropDownValueOfmandal(id: cubit.zilaSelected?.id ?? 0, isEdit: false);
                                    cubit.getShaktiKendra(id: cubit.zilaSelected?.id ?? 357);
                                    Navigator.pop(context);
                                  },
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        CommonLogoWidget(
                                          name: vidhanSabha.data?.locations?[index].name ?? '',
                                          backgroundColor: cubit.zilaSelected == vidhanSabha.data?.locations?[index] ? AppColor.orange : AppColor.naturalBlackColor,
                                        ),
                                        Text(
                                          "${vidhanSabha.data?.locations?[index].number ?? ''} - ${vidhanSabha.data?.locations?[index].name ?? ''}",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(color: AppColor.black, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                spaceHeightWidget(15),
                                const Divider(
                                  color: AppColor.borderColor,
                                ),
                                spaceHeightWidget(15),
                              ],
                            );
                          })
                      : Text(
                          S.of(context).noDataAvailable,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(color: AppColor.black, fontSize: 16),
                        ),
                )
              ],
            ),
          )),
    );
  }
}
