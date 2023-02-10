import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/cubit/zila_data_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/widget/a_to_z_filter_widget.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/widget/new_entry_filter_widget.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/Values/space_width_widget.dart';
import 'package:sangathan/generated/l10n.dart';
import 'package:sangathan/route/route_path.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../AddEntry/Cubit/add_entry_cubit.dart';
import '../../../../../AddEntry/Screen/add_entry_screen.dart';
import '../../../../../Storage/user_storage_service.dart';
import 'cubit/zila_data_state.dart';
import 'dropdown_handler/dropdown_handler.dart';

import 'widget/designation_filter_widget.dart';

import 'widget/filter_options_widget.dart';

class ZilaDataScreen extends StatefulWidget {
  const ZilaDataScreen(
      {super.key, required this.type, this.countryStateId, this.dataLevelId});

  final String? type;
  final int? countryStateId;
  final int? dataLevelId;

  @override
  State<ZilaDataScreen> createState() => _ZilaDataScreenState();
}

class _ZilaDataScreenState extends State<ZilaDataScreen> {
  @override
  void initState() {
    context.read<ZilaDataCubit>().dataList = null;
    context.read<ZilaDataCubit>().partyzilaList = [];

    context.read<ZilaDataCubit>().dataUnitList = null;
    context.read<ZilaDataCubit>().dependentDropdownList = [];
    context.read<ZilaDataCubit>().dependentDropdownSelected = null;
    context.read<ZilaDataCubit>().zilaSelected = null;
    DropdownHandler.dynamicSangathanDropdown(
        context, widget.type ?? "", widget.countryStateId ?? 0);
    /* context.read<ZilaDataCubit>().getPartyZila(
        id: widget.countryStateId ??
            StorageService.userData!.user!.countryStateId!);*/
    print('data_level :${widget.dataLevelId}');
    print('country_state_id${widget.countryStateId}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ZilaDataCubit>();
    return Scaffold(
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            IconButton(
                splashRadius: 20,
                onPressed: (() {
                  Navigator.pop(context);
                }),
                icon: const Icon(Icons.arrow_back)),
            Text(
              '${widget.type} ${S.of(context).dataEntry}',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColor.textBlackColor),
            )
          ],
        ),
        spaceHeightWidget(20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    spaceWidthWidget(8),
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColor.textBlackColor,
                    ),
                    spaceWidthWidget(8),

                    /// dropdown location
                    dropdownMainLocation(),
                  ],
                ),
                const Divider(
                  thickness: 1.2,
                  color: AppColor.textBlackColor,
                ),
                spaceHeightWidget(13),

                /// dependent dropdown
                if (widget.type == "Mandal" ||
                    widget.type == "Booth" ||
                    widget.type == "Shakti Kendra") ...[
                  Row(
                    children: [
                      spaceWidthWidget(8),
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColor.textBlackColor,
                      ),
                      spaceWidthWidget(8),

                      /// dropdown location
                      dependentDropdownLocation(),
                    ],
                  ),
                  const Divider(
                    thickness: 1.2,
                    color: AppColor.textBlackColor,
                  ),
                ] else
                  const SizedBox(),

                spaceHeightWidget(13),

                /// unit data widget
                dataUnit(cubit),
                spaceHeightWidget(20),
                Expanded(
                  child: BlocBuilder<ZilaDataCubit, ZilaDataState>(
                    builder: (context, state) {
                      if (state is EntryDataFetchedState) {
                        if (state.data.data != null) {
                          cubit.dataList = state.data.data!.data!;
                        }
                      }
                      return cubit.dataList?.isEmpty ?? false
                          ? Center(
                              heightFactor:
                                  MediaQuery.of(context).size.height * 0.02,
                              child: Text(
                                S.of(context).noDataAvailable,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColor.black),
                              ))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(S.of(context).entry,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        )),
                                    Text(
                                        "${S.of(context).total}:${cubit.dataList?.length ?? 0}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColor.greyColor))
                                  ],
                                ),
                                spaceHeightWidget(10),

                                /// filter options
                                const FilterOptions(),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        spaceHeightWidget(10),
                                        if (cubit.selectedFilterIndex == 0) ...[
                                          NewEntryFilterPage(
                                            type: widget.type,
                                            dataLevelId: widget.dataLevelId,
                                            countryStateId:
                                                widget.countryStateId,
                                          ),
                                        ] else if (cubit.selectedFilterIndex ==
                                            1) ...[
                                          DesignationFilterPage(
                                            type: widget.type,
                                            dataLevelId: widget.dataLevelId,
                                            countryStateId:
                                                widget.countryStateId,
                                          )
                                        ] else ...[
                                          AtoZfilterPage(
                                            type: widget.type,
                                            dataLevelId: widget.dataLevelId,
                                            countryStateId:
                                                widget.countryStateId,
                                          ),
                                        ]
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ])),
      floatingActionButton: BlocBuilder<ZilaDataCubit, ZilaDataState>(
        builder: (context, state) {
          return FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              backgroundColor: AppColor.buttonOrangeBackGroundColor,
              onPressed: (() {
                if (cubit.coreSangathanList?.isEmpty ??
                    true && cubit.morchaList.isEmpty) {
                  EasyLoading.showError(S.of(context).dataUnitEmptyError);
                } else {
                  context.read<AddEntryCubit>().cleanAllVariableData();
                  Navigator.pushNamed(context, RoutePath.addEntryScreen,
                      arguments: AddEntryPage(
                        type: widget.type ?? '',
                        leaveId: widget.dataLevelId ?? 0,
                        unitId: cubit.unitId,
                        subUnitId: cubit.subUnitId,
                        isEditEntry: false,
                        levelName: cubit.levelNameId,
                        countryStateId: widget.countryStateId,
                        personData: null,
                      ));
                }
              }),
              icon: const Icon(Icons.add),
              label: Text(
                S.of(context).addEntry,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColor.white),
              ));
        },
      ),
    );
  }

  Widget dataUnit(ZilaDataCubit cubit) {
    return SizedBox(
      height: 44,
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
              cubit.filterDtaSelectedIndex = 0;
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
            if (cubit.levelNameId != null) {
              context.read<ZilaDataCubit>().getEntryData(data: {
                "level": widget.dataLevelId,
                "unit": cubit.unitId,
                "level_name": cubit.levelNameId
              });
            }
          }

          return cubit.dataUnitList == null
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
                                      cubit.coreSangathanList?.length ?? 0,
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
                                                    (cubit.dataUnitList?.length ??
                                                        0);
                                                i++) {
                                              if (cubit.dataUnitList?[i].name ==
                                                  'Core Sangathan') {
                                                cubit.unitId =
                                                    cubit.dataUnitList?[i].id;
                                              }
                                            }
                                            cubit.onTapFilterData(
                                                index: index,
                                                id: data.id.toString(),
                                                unitsId: cubit.unitId);
                                            await context
                                                .read<ZilaDataCubit>()
                                                .getEntryData(data: {
                                              "level": widget.dataLevelId,
                                              "unit": cubit.unitId,
                                              "level_name": cubit.levelNameId
                                            });
                                          }),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            margin:
                                                const EdgeInsets.only(right: 16),
                                            decoration: BoxDecoration(
                                              color: cubit.subUnitId ==
                                                      data.id.toString()
                                                  ? AppColor
                                                      .buttonOrangeBackGroundColor
                                                  : AppColor.orange300Color,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                                child: Text(data.name ?? '',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 18,
                                                        color: cubit.subUnitId ==
                                                                data.id.toString()
                                                            ? AppColor.white
                                                            : AppColor.greyColor))),
                                          ),
                                        ),
                                        index + 1 == cubit.coreSangathanList?.length ?    cubit.morchaList.isNotEmpty
                                            ? InkWell(
                                          onTap: (() {}),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16,vertical: 10),
                                            margin: const EdgeInsets.only(right: 16),
                                            decoration: BoxDecoration(
                                                color:
                                                cubit.unitId == cubit.morchaData.id
                                                    ? AppColor
                                                    .buttonOrangeBackGroundColor
                                                    : AppColor.orange300Color,
                                                borderRadius: BorderRadius.circular(8)),
                                            child: Row(
                                              children: [
                                                PopupMenuButton(
                                                  itemBuilder: ((context) {
                                                    return cubit.morchaList
                                                        .map((e) => PopupMenuItem(
                                                        value: e,
                                                        child: Text(e.name ?? '')))
                                                        .toList();
                                                  }),
                                                  onSelected: ((value) async {
                                                    cubit.onSelectMorcha(value);
                                                    await context
                                                        .read<ZilaDataCubit>()
                                                        .getEntryData(data: {
                                                      "level": widget.dataLevelId,
                                                      "unit": cubit.unitId,
                                                      "level_name": cubit.levelNameId
                                                    });
                                                  }),
                                                  child:    Row(
                                                    children: [
                                                      Text(
                                            cubit.morchaData.name ?? '',
                                              style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 18,
                                                      color: cubit.unitId ==
                                                          cubit.morchaData.id
                                                          ? AppColor.white
                                                          : AppColor.greyColor),
                                            ),
                                                      Icon(
                                                        Icons.arrow_drop_down,
                                                        color: cubit.unitId ==
                                                            cubit.morchaData.id
                                                            ? AppColor.white
                                                            : AppColor.greyColor,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                            : const SizedBox.shrink() : SizedBox.shrink()
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

  Widget dropdownMainLocation() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${DropdownHandler.mainDropdownName(widget.type ?? "")}',
            style: GoogleFonts.roboto(
                color: AppColor.greyColor,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          BlocConsumer<ZilaDataCubit, ZilaDataState>(
            listener: ((context, state) {
              if (state is GetPartZilaErrorState) {
                EasyLoading.showError(state.error);
              }
            }),
            builder: (context, state) {
              final cubit = BlocProvider.of<ZilaDataCubit>(context);
              if (state is PartyZilaSelectedState) {
                cubit.selectedFilterIndex = 1;

                context.read<ZilaDataCubit>().getDeleteReason();

                cubit.zilaSelected = null;
                cubit.partyzilaList = state.data;
                if (cubit.partyzilaList.isNotEmpty) {
                  cubit.levelNameId = cubit.partyzilaList.first.id;
                  cubit.zilaSelected = cubit.partyzilaList.first;
                }

                print('cubit.levelNameId==${cubit.levelNameId}');
                if (widget.type == "Mandal" ||
                    widget.type == "Booth" ||
                    widget.type == "Shakti Kendra") {
                  DropdownHandler.dynamicDependentDropdown(
                      context,
                      widget.type ?? "",
                      cubit.levelNameId.toString(),
                      widget.countryStateId ?? 0);
                } else {
                  context.read<ZilaDataCubit>().getUnitData(data: {
                    "type": "Unit",
                    "data_level": widget.dataLevelId,
                    "country_state_id": widget.countryStateId ??
                        StorageService.userData?.user?.countryStateId
                  });
                }
              }
              return DropdownButtonHideUnderline(
                  child: DropdownButton(
                      isDense: true,
                      hint: Text(
                          'Select ${DropdownHandler.mainDropdownName(widget.type ?? "")}',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              color: AppColor.greyColor,
                              fontSize: 16)),
                      value: cubit.zilaSelected,
                      icon: const Icon(
                        Icons.expand_more,
                        color: AppColor.textBlackColor,
                        size: 24,
                      ),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColor.textBlackColor),
                      isExpanded: true,
                      items: cubit.partyzilaList
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name ?? '',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              )))
                          .toList(),
                      onChanged: ((value) async {
                        cubit.onChnageZila(value);
                        if (widget.type == "Mandal" ||
                            widget.type == "Booth" ||
                            widget.type == "Shakti Kendra") {
                          DropdownHandler.dynamicDependentDropdown(
                              context,
                              widget.type ?? "",
                              cubit.levelNameId.toString(),
                              widget.countryStateId ?? 0);
                        }
                        if (widget.type != "Mandal" &&
                            widget.type != "Booth" &&
                            widget.type != "Shakti Kendra") {
                          await context
                              .read<ZilaDataCubit>()
                              .getEntryData(data: {
                            "level": widget.dataLevelId,
                            "unit": cubit.unitId,
                            "level_name": cubit.levelNameId
                          });
                        }
                      })));
            },
          ),
        ],
      ),
    );
  }

  Widget dependentDropdownLocation() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${DropdownHandler.dependentDropdownName(widget.type ?? "")}',
            style: GoogleFonts.roboto(
                color: AppColor.greyColor,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          BlocConsumer<ZilaDataCubit, ZilaDataState>(
            listener: ((context, state) {
              if (state is GetPartZilaErrorState) {
                EasyLoading.showError(state.error);
              }
            }),
            builder: (context, state) {
              final cubit = BlocProvider.of<ZilaDataCubit>(context);
              if (state is DependentDropdownSuccessState) {
                cubit.levelNameId = null;
                cubit.dependentDropdownList = state.dependentDropdownData;
                context.read<ZilaDataCubit>().getUnitData(data: {
                  "type": "Unit",
                  "data_level": widget.dataLevelId,
                  "country_state_id": widget.countryStateId ??
                      StorageService.userData?.user?.countryStateId
                });
                if (cubit.dependentDropdownList.isNotEmpty) {
                  cubit.dependentDropdownSelected =
                      cubit.dependentDropdownList.first;
                  cubit.dependentLevelNameId =
                      cubit.dependentDropdownList.first.id;
                  cubit.levelNameId = cubit.dependentLevelNameId;
                } else {
                  cubit.dataList = [];
                }
              }

              return DropdownButtonHideUnderline(
                  child: DropdownButton(
                      isDense: true,
                      hint: Text(
                          'Select ${DropdownHandler.dependentDropdownName(widget.type ?? "")}',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              color: AppColor.greyColor,
                              fontSize: 16)),
                      value: cubit.dependentDropdownSelected,
                      icon: const Icon(
                        Icons.expand_more,
                        color: AppColor.textBlackColor,
                        size: 24,
                      ),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColor.textBlackColor),
                      isExpanded: true,
                      items: cubit.dependentDropdownList
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name ?? '',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              )))
                          .toList(),
                      onChanged: ((value) async {
                        cubit.onDependentDropdown(value);
                        await context.read<ZilaDataCubit>().getEntryData(data: {
                          "level": widget.dataLevelId,
                          "unit": cubit.unitId,
                          "level_name": cubit.levelNameId
                        });
                      })));
            },
          ),
        ],
      ),
    );
  }
}
