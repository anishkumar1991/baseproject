import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../sangathan_details/cubit/sangathan_detail_cubit.dart';
import '../cubit/zila_data_cubit.dart';
import '../cubit/zila_data_state.dart';
import '../dropdown_handler/dropdown_handler.dart';
import '../zila_data_screen.dart';

class DataUnit extends StatefulWidget {
  final String type;
  final int dataLevelId;

  const DataUnit({Key? key, required this.type, required this.dataLevelId})
      : super(key: key);

  @override
  State<DataUnit> createState() => _DataUnitState();
}

class _DataUnitState extends State<DataUnit> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ZilaDataCubit>();
    return SizedBox(
      height: widget.type == "Panna" ? 100 : 44,
      child: BlocConsumer<ZilaDataCubit, ZilaDataState>(
        listener: (context, state) {
          if (state is GetDataUnitErrorState) {
            EasyLoading.showError(state.error);
          }
        },
        builder: (context, state) {
          if (state is UnitDataFetchedState) {
            if (state.dataUnit.data?.isNotEmpty ?? false) {
              cubit.morchaList.clear();
              cubit.coreSangathanList = null;
              cubit.morchaData.name = 'Morcha';

              //cubit.filterDtaSelectedIndex = 0;
              cubit.dataUnitList = state.dataUnit.data!;

              for (var i = 0; i < (cubit.dataUnitList?.length ?? 0); i++) {
                if (cubit.dataUnitList?[i].name == 'Core Sangathan') {
                  if (cubit.dataUnitList?[i].subUnits?.isNotEmpty ?? false) {
                    cubit.coreSangathanList = cubit.dataUnitList?[i].subUnits;
                    cubit.subUnitId =
                        cubit.coreSangathanList?.first.id.toString() ?? "";
                  }
                  cubit.unitId = cubit.dataUnitList?[i].id;
                }

                if (cubit.dataUnitList?[i].name?.contains('Morcha') ?? false) {
                  cubit.morchaList.add(cubit.dataUnitList![i]);
                  if (cubit.coreSangathanList?.isEmpty ??
                      false || cubit.coreSangathanList == null) {
                    cubit.unitId = cubit.morchaList.first.id;
                    cubit.morchaData.id = cubit.morchaList.first.id;
                    cubit.morchaData.name = cubit.morchaList.first.name;
                  }
                }
              }
            } else {
              cubit.morchaList.clear();
              cubit.dataUnitList = [];
              cubit.coreSangathanList = null;
              cubit.unitId = null;
              cubit.subUnitId = "";
            }
            if (cubit.levelNameId != null && widget.type != "Panna") {
              context.read<ZilaDataCubit>().getEntryData(data: {
                "level": widget.dataLevelId,
                "unit": cubit.unitId ?? "",
                "sub_unit": cubit.subUnitId,
                "level_name": cubit.levelNameId
              });
            }

            if (widget.type == "Panna") {
              DropdownHandler.dynamicDependentDropdown(
                  context: context,
                  type: widget.type,
                  id: cubit.levelNameId.toString(),
                  locationId: context
                          .read<SangathanDetailsCubit>()
                          .selectedAllottedLocation
                          ?.id ??
                      0,
                  locationType:
                      context.read<SangathanDetailsCubit>().typeLevelName ??
                          "");
            }
          }

          return widget.type == "Panna"
              ? boothPannaStatusWidget()
              : cubit.dataUnitList == null
                  ? Shimmer.fromColors(
                      baseColor: AppColor.greyColor.withOpacity(0.3),
                      highlightColor: Colors.grey.withOpacity(0.1),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              3,
                              (index) => Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    height: 30,
                                    width: 140,
                                    color: AppColor.white,
                                  )).toList(),
                        ),
                      ))
                  : cubit.coreSangathanList?.isEmpty ??
                          true && cubit.morchaList.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.20),
                          child: Text(
                            S.of(context).noDataUnit,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            cubit.coreSangathanList?.isNotEmpty ?? false
                                ? Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        controller: cubit.controller,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            cubit.coreSangathanList?.length ??
                                                0,
                                        itemBuilder: ((context, index) {
                                          final data =
                                              cubit.coreSangathanList![index];

                                          return Row(
                                            children: [
                                              InkWell(
                                                onTap: (() async {
                                                  cubit.animateToIndex(index);
                                                  for (var i = 0;
                                                      i <
                                                          (cubit.dataUnitList
                                                                  ?.length ??
                                                              0);
                                                      i++) {
                                                    if (cubit.dataUnitList?[i]
                                                            .name ==
                                                        'Core Sangathan') {
                                                      cubit.unitId = cubit
                                                          .dataUnitList?[i].id;
                                                    }
                                                  }
                                                  cubit.onTapFilterData(
                                                      id: data.id.toString(),
                                                      unitsId: cubit.unitId);
                                                  await context
                                                      .read<ZilaDataCubit>()
                                                      .getEntryData(data: {
                                                    "level": widget.dataLevelId,
                                                    "unit": cubit.unitId ?? "",
                                                    "sub_unit": cubit.subUnitId,
                                                    "level_name":
                                                        cubit.levelNameId
                                                  });
                                                }),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16),
                                                  margin: const EdgeInsets.only(
                                                      right: 16),
                                                  decoration: BoxDecoration(
                                                    color: cubit.subUnitId ==
                                                            data.id.toString()
                                                        ? AppColor
                                                            .buttonOrangeBackGroundColor
                                                        : AppColor
                                                            .orange300Color,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                          getUnitDataLocalization(
                                                              context,
                                                              data.name ?? "",
                                                              widget.type),
                                                          style: GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 18,
                                                              color: cubit.subUnitId ==
                                                                      data.id
                                                                          .toString()
                                                                  ? AppColor
                                                                      .white
                                                                  : AppColor
                                                                      .greyColor))),
                                                ),
                                              ),
                                              index + 1 ==
                                                      cubit.coreSangathanList
                                                          ?.length
                                                  ? cubit.morchaList.isNotEmpty
                                                      ? Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 10),
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 16),
                                                          decoration: BoxDecoration(
                                                              color: cubit.unitId ==
                                                                      cubit
                                                                          .morchaData
                                                                          .id
                                                                  ? AppColor
                                                                      .buttonOrangeBackGroundColor
                                                                  : AppColor
                                                                      .orange300Color,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: Row(
                                                            children: [
                                                              PopupMenuButton(
                                                                itemBuilder:
                                                                    ((context) {
                                                                  return cubit
                                                                      .morchaList
                                                                      .map((e) => PopupMenuItem(
                                                                          value:
                                                                              e,
                                                                          child:
                                                                              Text(e.name ?? '')))
                                                                      .toList();
                                                                }),
                                                                onSelected:
                                                                    ((value) async {
                                                                  cubit.onSelectMorcha(
                                                                      value);
                                                                  await context
                                                                      .read<
                                                                          ZilaDataCubit>()
                                                                      .getEntryData(
                                                                          data: {
                                                                        "level":
                                                                            widget.dataLevelId,
                                                                        "sub_unit":
                                                                            cubit.subUnitId,
                                                                        "unit":
                                                                            cubit.unitId ??
                                                                                "",
                                                                        "level_name":
                                                                            cubit.levelNameId
                                                                      });
                                                                }),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      cubit.morchaData
                                                                              .name ??
                                                                          '',
                                                                      style: GoogleFonts.poppins(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              18,
                                                                          color: cubit.unitId == cubit.morchaData.id
                                                                              ? AppColor.white
                                                                              : AppColor.greyColor),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_drop_down,
                                                                      color: cubit.unitId ==
                                                                              cubit
                                                                                  .morchaData.id
                                                                          ? AppColor
                                                                              .white
                                                                          : AppColor
                                                                              .greyColor,
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : const SizedBox.shrink()
                                                  : const SizedBox.shrink()
                                            ],
                                          );
                                        })),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        );
        },
      ),
    );
  }

  Widget boothPannaStatusWidget() {
    return BlocBuilder<ZilaDataCubit, ZilaDataState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<ZilaDataCubit>(context);

        if (state is BoothPannasStatusSuccessState) {
          cubit.boothPannasStatus = null;
          cubit.boothPannasStatus = state.boothPannasStatus;
          context
              .read<ZilaDataCubit>()
              .getPannaKramaankList(cubit.levelNameId ?? 0, cubit.acId ?? 0);
        }
        return Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColor.pannaStatusColor,
              borderRadius: BorderRadius.circular(8)),
          child: IntrinsicHeight(
            child: Row(children: [
              Expanded(
                child: boothPannaStatusColumn(S.of(context).totalPanna,
                    cubit.boothPannasStatus?.data?.total ?? 0),
              ),
              const VerticalDivider(
                color: AppColor.dividerColor,
                width: 1,
              ),
              Expanded(
                child: boothPannaStatusColumn(S.of(context).pannaParmukh,
                    cubit.boothPannasStatus?.data?.pramukh ?? 0),
              ),
              const VerticalDivider(
                color: AppColor.dividerColor,
                width: 1,
              ),
              Expanded(
                child: boothPannaStatusColumn(S.of(context).panaaSamiti,
                    cubit.boothPannasStatus?.data?.samiti ?? 0),
              )
            ]),
          ),
        );
      },
    );
  }

  boothPannaStatusColumn(String title, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: AppColor.black700,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              )),
          const SizedBox(
            height: 5,
          ),
          Text("$value",
              style: GoogleFonts.poppins(
                color: AppColor.black700,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              )),
        ],
      ),
    );
  }
}
