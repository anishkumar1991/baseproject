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
import '../../../../../Values/icons.dart';
import 'cubit/zila_data_state.dart';
import 'dropdown_handler/dropdown_handler.dart';
import 'panna_pdf_viewer.dart';
import 'widget/designation_filter_widget.dart';
import 'widget/filter_options_widget.dart';
import 'widget/panna_no_list_bottom_sheet_widget.dart';

int pannaCountryStateId = 14;

class ZilaDataScreen extends StatefulWidget {
  ZilaDataScreen(
      {super.key, required this.type, this.countryStateId, this.dataLevelId});

  final String? type;
  int? countryStateId;
  final int? dataLevelId;

  @override
  State<ZilaDataScreen> createState() => _ZilaDataScreenState();
}

class _ZilaDataScreenState extends State<ZilaDataScreen> {
  @override
  void initState() {
    print(widget.type);
    context.read<ZilaDataCubit>().dataList = null;
    context.read<ZilaDataCubit>().partyzilaList = [];
    context.read<ZilaDataCubit>().selectedPannaNo = null;
    context.read<ZilaDataCubit>().selectedPannaNo = null;
    context.read<ZilaDataCubit>().boothPannasStatus = null;
    context.read<ZilaDataCubit>().pannaKramaankListData = [];
    context.read<ZilaDataCubit>().dataUnitList = null;
    context.read<ZilaDataCubit>().dependentDropdownList = [];
    context.read<ZilaDataCubit>().dependentDropdownSelected = null;
    context.read<ZilaDataCubit>().zilaSelected = null;

    /// TODO : here country id is static (just remove condition)
    if (widget.type == "Panna") {
      widget.countryStateId = pannaCountryStateId;
    }
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
                    widget.type == "Panna" ||
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
                          print(
                              "------------------- Entry Data Lis Length ------------------");
                          print(
                              "List length :${state.data.data?.data?.length}");
                          cubit.dataList = state.data.data!.data!;
                        }
                      }

                      if (state is PannaKramaankSuccessState) {
                        cubit.pannaKramaankListData =
                            state.pannaKramaankListData.data?.locations ?? [];
                        if (cubit.pannaKramaankListData.isNotEmpty) {
                          cubit.selectedPannaNo =
                              cubit.pannaKramaankListData.first;
                          if (cubit.levelNameId != null) {
                            context.read<ZilaDataCubit>().getEntryData(data: {
                              "level": widget.dataLevelId,
                              "unit": cubit.unitId ?? "",
                              "sub_unit": cubit.subUnitId,
                              "level_name": cubit.pannaKramaankListData.first.id
                            });
                          }
                        } else {
                          cubit.dataList = [];
                        }
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.type == "Panna")
                            const SizedBox()
                          else
                            cubit.dataList?.isEmpty ?? true
                                ? const SizedBox()
                                : Row(
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
                          spaceHeightWidget(5),

                          /// filter options
                          if (widget.type == "Panna")
                            pannaNumberSelectionWidget()
                          else
                            cubit.dataList?.isEmpty ?? true
                                ? const SizedBox()
                                : const FilterOptions(),

                          Expanded(
                            child: SingleChildScrollView(
                              child: cubit.dataList?.isEmpty ?? false
                                  ? Center(
                                      heightFactor:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      child: Text(
                                        S.of(context).noDataAvailable,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppColor.black),
                                      ))
                                  : Column(
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
          return widget.type == 'Panna' && cubit.pannaKramaankListData.isEmpty
              ? const SizedBox.shrink()
              : FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  backgroundColor: AppColor.buttonOrangeBackGroundColor,
                  onPressed: (() {
                    if (widget.type == "Panna") {
                      context.read<AddEntryCubit>().cleanAllVariableData();
                      Navigator.pushNamed(context, RoutePath.addEntryScreen,
                          arguments: AddEntryPage(
                            type: widget.type ?? '',
                            leaveId: widget.dataLevelId ?? 0,
                            unitId: cubit.unitId ?? "",
                            subUnitId: cubit.subUnitId,
                            isEditEntry: false,
                            levelName: cubit.selectedPannaNo?.id ?? 0,

                            /// TODO : here country id is static when type is panna we need make dynamic in future
                            countryStateId: widget.type == "Panna"
                                ? pannaCountryStateId
                                : widget.countryStateId,
                            pannaID: cubit.selectedPannaNo?.number,
                            personData: null,
                          ));
                    } else {
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

                              ///TODO : here country id is static when type is panna we need make dynamic in future
                              countryStateId: widget.type == "Panna"
                                  ? pannaCountryStateId
                                  : widget.countryStateId,
                              personData: null,
                            ));
                      }
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

  Widget pannaNumberSelectionWidget() {
    var cubit = context.read<ZilaDataCubit>();
    return BlocBuilder<ZilaDataCubit, ZilaDataState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      builder: (builder) {
                        return PannaNoListBottomSheetWidget(
                          dataLevelId: widget.dataLevelId ?? 0,
                        );
                      });
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.dividerColor,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: Image(
                        image: AssetImage(
                          AppIcons.fileListIcon,
                        ),
                        width: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).pannaNo,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            )),
                        Text("${cubit.selectedPannaNo?.number ?? ""}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ))
                      ],
                    )),
                    const Icon(Icons.keyboard_arrow_down),
                  ]),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return PannaPdfViewer(
                      pdfLink: cubit.selectedPannaNo?.pdfUrl,
                      // pdfLink:
                      //     "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
                      pannaNumber: cubit.selectedPannaNo?.number,
                    );
                  },
                ));
              },
              child: const Image(
                image: AssetImage(
                  AppIcons.pdfIcon,
                ),
                width: 60,
              ),
            )
          ],
        );
      },
    );
  }

  Widget dataUnit(ZilaDataCubit cubit) {
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
                  context,
                  widget.type ?? "",
                  cubit.levelNameId.toString(),
                  widget.countryStateId ?? 0);
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
                                                          data.name ?? '',
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
                  cubit.acId = cubit.partyzilaList.first.id;
                }

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
                            widget.type == "Panna" ||
                            widget.type == "Shakti Kendra") {
                          DropdownHandler.dynamicDependentDropdown(
                              context,
                              widget.type ?? "",
                              cubit.levelNameId.toString(),
                              widget.countryStateId ?? 0);
                        }
                        if (widget.type != "Mandal" &&
                            widget.type != "Booth" &&
                            widget.type != "Panna" &&
                            widget.type != "Shakti Kendra") {
                          await context
                              .read<ZilaDataCubit>()
                              .getEntryData(data: {
                            "level": widget.dataLevelId,
                            "unit": cubit.unitId ?? "",
                            "sub_unit": cubit.subUnitId,
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
                if (widget.type == "Panna") {
                  if (cubit.dependentDropdownList.isNotEmpty) {
                    context.read<ZilaDataCubit>().getBoothPannasStatus(
                        cubit.dependentDropdownList.first.id ?? 0);
                  }
                } else {
                  context.read<ZilaDataCubit>().getUnitData(data: {
                    "type": "Unit",
                    "data_level": widget.dataLevelId,
                    "country_state_id": widget.countryStateId ??
                        StorageService.userData?.user?.countryStateId
                  });
                }
                if (cubit.dependentDropdownList.isNotEmpty) {
                  cubit.dependentDropdownSelected =
                      cubit.dependentDropdownList.first;
                  cubit.dependentLevelNameId =
                      cubit.dependentDropdownList.first.id;
                  cubit.levelNameId = cubit.dependentLevelNameId;
                } else {
                  cubit.dataList = [];
                  cubit.selectedPannaNo = null;
                  cubit.boothPannasStatus = null;
                  cubit.pannaKramaankListData = [];
                  cubit.onDataFound();
                }
              }

              return DropdownButtonHideUnderline(
                  child: SizedBox(
                height: 50,
                child: DropdownButton(
                    isDense: true,
                    hint: cubit.dependentDropdownList.isNotEmpty
                        ? Text(
                            'Select ${DropdownHandler.dependentDropdownName(widget.type ?? "")}',
                            maxLines: 2,
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: AppColor.greyColor,
                                fontSize: 16))
                        : Text(
                            'No ${DropdownHandler.dependentDropdownName(widget.type ?? "")} available',
                            maxLines: 2,
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
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            )))
                        .toList(),
                    onChanged: ((value) async {
                      cubit.onDependentDropdown(value);
                      cubit.selectedPannaNo = null;
                      if (widget.type == "Panna") {
                        await context
                            .read<ZilaDataCubit>()
                            .getBoothPannasStatus(value?.id ?? 0);
                      } else {
                        await context.read<ZilaDataCubit>().getEntryData(data: {
                          "level": widget.dataLevelId,
                          "unit": cubit.unitId ?? "",
                          "sub_unit": cubit.subUnitId,
                          "level_name": cubit.levelNameId
                        });
                      }
                    })),
              ));
            },
          ),
        ],
      ),
    );
  }
}
