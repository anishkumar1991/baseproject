import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../Storage/user_storage_service.dart';
import '../../../../../../Values/app_colors.dart';
import '../../../../../../common/common_logo_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../sangathan_details/cubit/sangathan_detail_cubit.dart';
import '../../sangathan_details/sangathan_deatils_page.dart';
import '../cubit/zila_data_cubit.dart';
import '../cubit/zila_data_state.dart';
import '../dropdown_handler/dropdown_handler.dart';
import '../network/model/independent_drodown_model.dart';

class MainDropdownWidget extends StatefulWidget {
  final String typeName;
  final String typeLevel;
  final int? countryStateId;
  final int? dataLevelId;

  const MainDropdownWidget(
      {Key? key, required this.typeLevel, required this.typeName, this.dataLevelId, this.countryStateId})
      : super(key: key);

  @override
  State<MainDropdownWidget> createState() => _MainDropdownWidgetState();
}

class _MainDropdownWidgetState extends State<MainDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ZilaDataCubit, ZilaDataState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<ZilaDataCubit>(context);
        if (state is PartyZilaSelectedState) {
          cubit.selectedFilterIndex = 1;
          cubit.zilaSelected = null;
          cubit.partyzilaList = state.data;
          locationListSortBasedOnType();

          if (cubit.partyzilaList.isNotEmpty) {
            cubit.levelNameId = cubit.partyzilaList.first.id;
            cubit.zilaSelected = cubit.partyzilaList.first;
            cubit.acId = cubit.partyzilaList.first.id;
          }
          if (context.read<SangathanDetailsCubit>().typeLevelName ==
              DropdownHandler.gettingLocationTypeForCondition(widget.typeName)) {
            print("get unit data widget ");
            if (widget.typeName == "Panna") {
              print(cubit.zilaSelected?.toJson());
              context.read<ZilaDataCubit>().getBoothPannasStatus(cubit.zilaSelected?.id ?? 0);
            } else {
              print("get unit data cubit.zilaSelected?.toJson()");
              context.read<ZilaDataCubit>().getUnitData(data: {
                "type": "Unit",
                "data_level": widget.dataLevelId,
                "country_state_id": widget.countryStateId ?? StorageService.userData?.user?.countryStateId
              });
            }
          } else {
            if (widget.typeName == "Mandal" ||
                widget.typeName == "Booth" ||
                widget.typeName == "Shakti Kendra" ||
                widget.typeName == "Panna") {
              DropdownHandler.dynamicDependentDropdown(
                  context: context,
                  type: widget.typeName,
                  id: cubit.levelNameId.toString(),
                  locationId: context.read<SangathanDetailsCubit>().selectedAllottedLocation?.id ?? 0,
                  locationType: context.read<SangathanDetailsCubit>().typeLevelName ?? "");
            } else {
              context.read<ZilaDataCubit>().getUnitData(data: {
                "type": "Unit",
                "data_level": widget.dataLevelId,
                "country_state_id": widget.countryStateId ?? StorageService.userData?.user?.countryStateId
              });
            }
          }
        }
        return Expanded(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  enableDrag: false,
                  isDismissible: false,
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
                  builder: (builder) {
                    return bottomSheetWidget(cubit.partyzilaList);
                  });
            },
            child: Container(
              width: double.infinity,
              color: AppColor.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mainDropdownName(),
                              style: GoogleFonts.roboto(
                                  color: AppColor.greyColor, fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                            Text(
                              showDropdownValueBasedOnType(cubit.zilaSelected),
                              style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded)
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  mainDropdownName() {
    if (context.read<SangathanDetailsCubit>().typeLevelName ==
        DropdownHandler.gettingLocationTypeForCondition(widget.typeName)) {
      return getLocalizationNameOfLevel(context, widget.typeName,
          levelUser: context.read<SangathanDetailsCubit>().typeLevelName);
    } else {
      return "${getLocalizationNameOfLevel(context, DropdownHandler.mainDropdownName(widget.typeName, context), levelUser: context.read<SangathanDetailsCubit>().typeLevelName ?? "")}";
    }
  }

  Widget bottomSheetWidget(List<Locations> locationList) {
    String currentLocale = Localizations.localeOf(context).toString();
    final cubit = BlocProvider.of<ZilaDataCubit>(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentLocale == "hi"
                    ? "${mainDropdownName()} ${S.of(context).choose}"
                    : "${S.of(context).choose} ${mainDropdownName()}",
                textAlign: TextAlign.left,
                style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
        ),
        const Divider(
          color: AppColor.borderColor,
        ),
        Expanded(
            child: ListView.builder(
          itemCount: locationList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      cubit.onChnageZila(locationList[index]);
                      if (context.read<SangathanDetailsCubit>().typeLevelName ==
                          DropdownHandler.gettingLocationTypeForCondition(widget.typeName)) {
                        context.read<ZilaDataCubit>().getUnitData(data: {
                          "type": "Unit",
                          "data_level": widget.dataLevelId,
                          "country_state_id": widget.countryStateId ?? StorageService.userData?.user?.countryStateId
                        });
                      } else {
                        if (widget.typeName == "Mandal" ||
                            widget.typeName == "Booth" ||
                            widget.typeName == "Panna" ||
                            widget.typeName == "Shakti Kendra") {
                          DropdownHandler.dynamicDependentDropdown(
                              context: context,
                              type: widget.typeName,
                              id: cubit.levelNameId.toString(),
                              locationId: context.read<SangathanDetailsCubit>().selectedAllottedLocation?.id ?? 0,
                              locationType: context.read<SangathanDetailsCubit>().typeLevelName ?? "");
                        }
                      }
                      if (widget.typeName != "Mandal" &&
                          widget.typeName != "Booth" &&
                          widget.typeName != "Panna" &&
                          widget.typeName != "Shakti Kendra") {
                        context.read<ZilaDataCubit>().getEntryData(data: {
                          "level": widget.dataLevelId,
                          "unit": cubit.unitId ?? "",
                          "sub_unit": cubit.subUnitId,
                          "level_name": cubit.levelNameId
                        });
                      }
                      Future.delayed(Duration.zero).then((value) => Navigator.pop(context));
                    },
                    child: Container(
                      width: double.infinity,
                      color: AppColor.transparent,
                      child: Row(
                        children: [
                          CommonLogoWidget(
                              name: locationList[index].name ?? "",
                              backgroundColor: cubit.zilaSelected?.id == locationList[index].id
                                  ? AppColor.orange
                                  : AppColor.naturalBlackColor),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  showDropdownValueBasedOnType(locationList[index]),
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                                if (widget.typeName == "Booth" && widget.typeLevel == "Booth")
                                  Text(
                                    locationList[index].mandalName == null
                                        ? S.of(context).notMappedWithAnyMandal
                                        : "${S.of(context).mappedMandal} :${locationList[index].mandalName ?? ""}",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.quicksand(
                                        fontSize: 14, fontWeight: FontWeight.w500, color: AppColor.borderColor),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: AppColor.borderColor,
                    thickness: 0.2,
                  ),
                ],
              ),
            );
          },
        ))
      ],
    );
  }

  showDropdownValueBasedOnType(Locations? zilaSelected) {
    String type = DropdownHandler.mainDropdownName(widget.typeName, context);
    if (type == S.of(context).vidhanSabha || type == "Lok Sabha") {
      return "${zilaSelected?.number ?? ""} - ${zilaSelected?.name ?? ""}";
    } else {
      return zilaSelected?.name ?? "";
    }
  }

  locationListSortBasedOnType() {
    final cubit = BlocProvider.of<ZilaDataCubit>(context);
    String typeOfLevel = DropdownHandler.mainDropdownName(widget.typeName, context);
    if (typeOfLevel == "Panna" ||
        typeOfLevel == S.of(context).booth ||
        typeOfLevel == "Lok Sabha" ||
        typeOfLevel == S.of(context).vidhanSabha) {
      cubit.partyzilaList.sort((a, b) => int.parse(a.number.toString()).compareTo(int.parse(b.number.toString())));
    } else {
      cubit.partyzilaList.sort((a, b) => (a.name ?? "").compareTo(b.name ?? ""));
    }
  }
}
