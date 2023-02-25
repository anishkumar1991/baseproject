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
import 'data_sub_unit_bottom_sheet_widget.dart';

class DataUnit extends StatefulWidget {
  final String type;
  final int dataLevelId;

  const DataUnit({Key? key, required this.type, required this.dataLevelId}) : super(key: key);

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
                    cubit.subUnitId = cubit.coreSangathanList?.first.id.toString() ?? "";
                  }
                  cubit.unitId = cubit.dataUnitList?[i].id;
                }

                if (cubit.dataUnitList?[i].name?.contains('Morcha') ?? false) {
                  cubit.morchaList.add(cubit.dataUnitList![i]);
                }
              }
              if (cubit.coreSangathanList == null && cubit.morchaList.isEmpty) {
                for (int i = 0; i < (cubit.dataUnitList?.length ?? 0); i++) {
                  if (cubit.dataUnitList?[i].name != "Core Sangathan" &&
                      (cubit.dataUnitList?[i].name?.contains('Morcha') ?? false) == false) {
                    for (int j = 0; j < (cubit.dataUnitList?[i].subUnits?.length ?? 0); j++) {
                      print("----------------------   ${cubit.dataUnitList?[i].subUnits?[j].name}");
                      cubit.unitId = cubit.dataUnitList?[i].id;
                      cubit.subUnitId = cubit.dataUnitList?[i].subUnits?[j].id.toString() ?? "0";
                    }
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
                  locationId: context.read<SangathanDetailsCubit>().selectedAllottedLocation?.id ?? 0,
                  locationType: context.read<SangathanDetailsCubit>().typeLevelName ?? "");
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
                  : cubit.dataUnitList?.isEmpty ?? true
                      ? Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.20),
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
                            cubit.dataUnitList?.isNotEmpty ?? false
                                ? Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          ListView.builder(
                                              shrinkWrap: true,
                                              controller: cubit.controller,
                                              physics: const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: cubit.coreSangathanList?.length ?? 0,
                                              itemBuilder: ((context, index) {
                                                final data = cubit.coreSangathanList![index];
                                                return InkWell(
                                                  onTap: (() async {
                                                    cubit.animateToIndex(index);
                                                    for (var i = 0; i < (cubit.dataUnitList?.length ?? 0); i++) {
                                                      if (cubit.dataUnitList?[i].name == 'Core Sangathan') {
                                                        cubit.unitId = cubit.dataUnitList?[i].id;
                                                      }
                                                    }
                                                    cubit.onTapFilterData(
                                                        subUnit: data.id.toString(), unit: cubit.unitId);
                                                    await context.read<ZilaDataCubit>().getEntryData(data: {
                                                      "level": widget.dataLevelId,
                                                      "unit": cubit.unitId ?? "",
                                                      "sub_unit": cubit.subUnitId,
                                                      "level_name": cubit.levelNameId
                                                    });
                                                  }),
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                                    margin: const EdgeInsets.only(right: 16),
                                                    decoration: BoxDecoration(
                                                      color: cubit.subUnitId == data.id.toString()
                                                          ? AppColor.buttonOrangeBackGroundColor
                                                          : AppColor.orange300Color,
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                            getUnitDataLocalization(
                                                                context, data.name ?? "", widget.type),
                                                            style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 18,
                                                                color: cubit.subUnitId == data.id.toString()
                                                                    ? AppColor.white
                                                                    : AppColor.greyColor))),
                                                  ),
                                                );
                                              })),
                                          cubit.morchaList.isNotEmpty
                                              ? Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                                  margin: const EdgeInsets.only(right: 16),
                                                  decoration: BoxDecoration(
                                                      color: cubit.unitId == cubit.morchaData.id
                                                          ? AppColor.buttonOrangeBackGroundColor
                                                          : AppColor.orange300Color,
                                                      borderRadius: BorderRadius.circular(8)),
                                                  child: Row(
                                                    children: [
                                                      PopupMenuButton(
                                                        itemBuilder: ((context) {
                                                          return cubit.morchaList
                                                              .map((e) =>
                                                                  PopupMenuItem(value: e, child: Text(e.name ?? '')))
                                                              .toList();
                                                        }),
                                                        onSelected: ((value) async {
                                                          cubit.onSelectMorcha(value);
                                                          await context.read<ZilaDataCubit>().getEntryData(data: {
                                                            "level": widget.dataLevelId,
                                                            "sub_unit": cubit.subUnitId,
                                                            "unit": cubit.unitId ?? "",
                                                            "level_name": cubit.levelNameId
                                                          });
                                                        }),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              cubit.unitId == cubit.morchaData.id
                                                                  ? cubit.morchaData.name ?? ''
                                                                  : "Morcha",
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 18,
                                                                  color: cubit.unitId == cubit.morchaData.id
                                                                      ? AppColor.white
                                                                      : AppColor.greyColor),
                                                            ),
                                                            Icon(
                                                              Icons.arrow_drop_down,
                                                              color: cubit.unitId == cubit.morchaData.id
                                                                  ? AppColor.white
                                                                  : AppColor.greyColor,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          for (int i = 0; i < (cubit.dataUnitList?.length ?? 0); i++)
                                            if (cubit.dataUnitList?[i].name != "Core Sangathan" &&
                                                (cubit.dataUnitList?[i].name?.contains('Morcha') ?? false) ==
                                                    false) ...[
                                              if (cubit.dataUnitList?[i].subUnits?.isNotEmpty ?? false)
                                                GestureDetector(
                                                  onTap: () {
                                                    if (cubit.dataUnitList?[i].subUnits != null &&
                                                        (cubit.dataUnitList?[i].subUnits?.isNotEmpty ?? false)) {
                                                      showModalBottomSheet(
                                                          enableDrag: false,
                                                          context: context,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(30.0),
                                                                  topRight: Radius.circular(30.0))),
                                                          builder: (builder) {
                                                            return DataSubUnitBottomSheetWidget(
                                                              level: widget.dataLevelId,
                                                              unitId: cubit.dataUnitList?[i].id ?? 0,
                                                              subUnits: cubit.dataUnitList?[i].subUnits ?? [],
                                                            );
                                                          });
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                                    margin: const EdgeInsets.only(right: 16),
                                                    decoration: BoxDecoration(
                                                      color: cubit.unitId == cubit.dataUnitList?[i].id
                                                          ? AppColor.buttonOrangeBackGroundColor
                                                          : AppColor.orange300Color,
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Center(
                                                        child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Flexible(
                                                          child: ConstrainedBox(
                                                            constraints: const BoxConstraints(maxWidth: 250),
                                                            child: Text(
                                                                getNameOfSubUnit(cubit.dataUnitList?[i].id ?? 0) != ""
                                                                    ? getNameOfSubUnit(cubit.dataUnitList?[i].id ?? 0)
                                                                    : cubit.dataUnitList?[i].name ?? "",
                                                                overflow: TextOverflow.ellipsis,
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 18,
                                                                    color: cubit.unitId == cubit.dataUnitList?[i].id
                                                                        ? AppColor.white
                                                                        : AppColor.greyColor)),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 5),
                                                        if (cubit.dataUnitList?[i].subUnits != null &&
                                                            (cubit.dataUnitList?[i].subUnits?.isNotEmpty ?? false))
                                                          Icon(
                                                            Icons.arrow_drop_down,
                                                            color: cubit.unitId == cubit.dataUnitList?[i].id
                                                                ? AppColor.white
                                                                : AppColor.greyColor,
                                                          )
                                                        else
                                                          const SizedBox(),
                                                      ],
                                                    )),
                                                  ),
                                                )
                                            ]
                                        ],
                                      ),
                                    ),
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
          context.read<ZilaDataCubit>().getPannaKramaankList(cubit.levelNameId ?? 0, cubit.acId ?? 0);
        }
        return Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColor.pannaStatusColor, borderRadius: BorderRadius.circular(8)),
          child: IntrinsicHeight(
            child: Row(children: [
              Expanded(
                child: boothPannaStatusColumn(S.of(context).totalPanna, cubit.boothPannasStatus?.data?.total ?? 0),
              ),
              const VerticalDivider(
                color: AppColor.dividerColor,
                width: 1,
              ),
              Expanded(
                child: boothPannaStatusColumn(S.of(context).pannaParmukh, cubit.boothPannasStatus?.data?.pramukh ?? 0),
              ),
              const VerticalDivider(
                color: AppColor.dividerColor,
                width: 1,
              ),
              Expanded(
                child: boothPannaStatusColumn(S.of(context).panaaSamiti, cubit.boothPannasStatus?.data?.samiti ?? 0),
              )
            ]),
          ),
        );
      },
    );
  }

  getNameOfSubUnit(int unitId) {
    var cubit = context.read<ZilaDataCubit>();
    String name = "";
    for (int i = 0; i < (cubit.dataUnitList?.length ?? 0); i++) {
      if (unitId == cubit.dataUnitList?[i].id) {
        for (int j = 0; j < (cubit.dataUnitList?[i].subUnits?.length ?? 0); j++) {
          if (cubit.subUnitId == cubit.dataUnitList?[i].subUnits?[j].id.toString()) {
            name = cubit.dataUnitList?[i].subUnits?[j].name ?? "";
            break;
          }
        }
      }
    }
    return name;
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
