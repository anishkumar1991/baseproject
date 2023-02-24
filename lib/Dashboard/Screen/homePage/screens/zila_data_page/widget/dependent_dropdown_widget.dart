import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

class DependentDropdownWidget extends StatefulWidget {
  final String type;
  final String typeLevel;
  final int? countryStateId;
  final int? dataLevelId;

  const DependentDropdownWidget(
      {Key? key, required this.type, required this.typeLevel, this.countryStateId, this.dataLevelId})
      : super(key: key);

  @override
  State<DependentDropdownWidget> createState() => _DependentDropdownWidgetState();
}

class _DependentDropdownWidgetState extends State<DependentDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ZilaDataCubit, ZilaDataState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<ZilaDataCubit>(context);
        if (state is DependentDropdownSuccessState) {
          cubit.levelNameId = null;
          cubit.dependentDropdownList = state.dependentDropdownData;
          locationListSortBasedOnType();
          if (widget.type == "Panna") {
            if (cubit.dependentDropdownList.isNotEmpty) {
              context.read<ZilaDataCubit>().getBoothPannasStatus(cubit.dependentDropdownList.first.id ?? 0);
            }
          } else {
            context.read<ZilaDataCubit>().getUnitData(data: {
              "type": "Unit",
              "data_level": widget.dataLevelId,
              "country_state_id": widget.countryStateId ?? StorageService.userData?.user?.countryStateId
            });
          }
          bool isFoundKey = false;
          if (cubit.dependentDropdownList.isNotEmpty) {
            if (widget.typeLevel == "Mandal") {
              if (widget.type == "Shakti Kendra" || widget.type == "Booth") {
                final sangathanDetailsCubit = BlocProvider.of<SangathanDetailsCubit>(context);
                for (int i = 0; i < cubit.dependentDropdownList.length; i++) {
                  for (int j = 0; j < (sangathanDetailsCubit.allotedLocationModel?.data?.locations?.length ?? 0); j++) {
                    if (isFoundKey == false) {
                      if (cubit.dependentDropdownList[i].mandalName ==
                          sangathanDetailsCubit.allotedLocationModel?.data?.locations?[j].name) {
                        cubit.dependentDropdownSelected = cubit.dependentDropdownList[i];
                        cubit.dependentLevelNameId = cubit.dependentDropdownList[i].id;
                        cubit.levelNameId = cubit.dependentLevelNameId;
                        isFoundKey = true;
                      }
                    }
                  }
                }
              }
            } else {
              cubit.dependentDropdownSelected = cubit.dependentDropdownList.first;
              cubit.dependentLevelNameId = cubit.dependentDropdownList.first.id;
              cubit.levelNameId = cubit.dependentLevelNameId;
            }
          } else {
            cubit.dataList = [];
            cubit.dataListWithoutSort = [];
            cubit.selectedPannaNo = null;
            cubit.boothPannasStatus = null;
            cubit.pannaKramaankListData = [];
            cubit.onDataFound();
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
                    return bottomSheetWidget(cubit.dependentDropdownList);
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
                              "${getLocalizationNameOfLevel(context, DropdownHandler.dependentDropdownName(widget.type, context))}",
                              style: GoogleFonts.roboto(
                                  color: AppColor.greyColor, fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                            Text(
                              getSelectedValue(),
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

  getSelectedValue() {
    final cubit = BlocProvider.of<ZilaDataCubit>(context);
    if (DropdownHandler.dependentDropdownName(widget.type, context) == S.of(context).booth) {
      return "${cubit.dependentDropdownSelected?.number ?? ""} - ${cubit.dependentDropdownSelected?.name ?? ""}";
    } else {
      return cubit.dependentDropdownSelected?.name ?? "";
    }
  }

  Widget bottomSheetWidget(List<Locations> locationList) {
    String currentLocale = Localizations.localeOf(context).toString();
    final cubit = BlocProvider.of<ZilaDataCubit>(context);
    String typeOfLevel = DropdownHandler.dependentDropdownName(widget.type, context);
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
                    ? "${getLocalizationNameOfLevel(context, typeOfLevel)} ${S.of(context).choose}"
                    : "${S.of(context).choose} ${getLocalizationNameOfLevel(context, typeOfLevel)}",
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
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: cubit.dependentDropdownSelected?.id == locationList[index].id
                      ? AppColor.pannaStatusColor
                      : AppColor.transparent,
                  child: GestureDetector(
                    onTap: () {
                      if (mappedMandalWithSKWhenUserIsMandal(locationList[index].mandalName ?? "")) {
                        if (widget.type == "Shakti Kendra") {
                          EasyLoading.showToast(S.of(context).dataEntryIsNotAllowedOnShaktiKendraOfOtherMandal,
                              toastPosition: EasyLoadingToastPosition.bottom, duration: const Duration(seconds: 3));
                        }
                        if (widget.type == "Booth") {
                          EasyLoading.showToast(S.of(context).dataEntryIsNotAllowedOnBoothOfOtherMandal,
                              toastPosition: EasyLoadingToastPosition.bottom, duration: const Duration(seconds: 3));
                        }
                      } else {
                        cubit.onDependentDropdown(locationList[index]);
                        cubit.selectedPannaNo = null;
                        if (widget.type == "Panna") {
                          context.read<ZilaDataCubit>().getBoothPannasStatus(locationList[index].id ?? 0);
                        } else {
                          context.read<ZilaDataCubit>().getEntryData(data: {
                            "level": widget.dataLevelId,
                            "unit": cubit.unitId ?? "",
                            "sub_unit": cubit.subUnitId,
                            "level_name": cubit.levelNameId
                          });
                        }
                        Future.delayed(Duration.zero).then((value) => Navigator.pop(context));
                      }
                    },
                    child: Container(
                      color: AppColor.transparent,
                      width: double.infinity,
                      child: Row(
                        children: [
                          typeOfLevel == S.of(context).booth
                              ? Container(
                                  width: 35,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11),
                                      color: locationList[index].mandalName == null
                                          ? AppColor.naturalBlackColor
                                          : gettingBackgroundColor(
                                              locationList[index].mandalName ?? "", locationList[index].id ?? 0)),
                                  child: Text(
                                    locationList[index].number ?? '',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(color: AppColor.white, fontSize: 12),
                                  ),
                                )
                              : CommonLogoWidget(
                                  name: locationList[index].name ?? "",
                                  backgroundColor: gettingBackgroundColor(
                                      locationList[index].mandalName ?? "", locationList[index].id ?? 0)),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  locationList[index].name ?? "",
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                                if (typeOfLevel == "Shakti Kendra" || typeOfLevel == S.of(context).booth)
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
                          ),
                          mappedMandalWithSKWhenUserIsMandal(locationList[index].mandalName ?? "")
                              ? IconButton(
                                  onPressed: () {
                                    if (widget.type == "Shakti Kendra") {
                                      EasyLoading.showToast(
                                          S.of(context).dataEntryIsNotAllowedOnShaktiKendraOfOtherMandal,
                                          toastPosition: EasyLoadingToastPosition.bottom,
                                          duration: const Duration(seconds: 3));
                                    }
                                    if (widget.type == "Booth") {
                                      EasyLoading.showToast(S.of(context).dataEntryIsNotAllowedOnBoothOfOtherMandal,
                                          toastPosition: EasyLoadingToastPosition.bottom,
                                          duration: const Duration(seconds: 3));
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.info,
                                    color: AppColor.borderColor,
                                  ))
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: AppColor.borderColor,
                  thickness: 0.2,
                ),
              ],
            );
          },
        ))
      ],
    );
  }

  locationListSortBasedOnType() {
    final cubit = BlocProvider.of<ZilaDataCubit>(context);
    String typeOfLevel = DropdownHandler.dependentDropdownName(widget.type, context);
    if (typeOfLevel == "Panna" || typeOfLevel == S.of(context).booth) {
      cubit.dependentDropdownList.sort((a, b) => int.parse(a.number ?? "0").compareTo(int.parse(b.number ?? "0")));
    } else {
      cubit.dependentDropdownList.sort((a, b) => (a.name ?? "").compareTo(b.name ?? ""));
    }
  }

  mappedMandalWithSKWhenUserIsMandal(String mandalName) {
    final cubit = BlocProvider.of<SangathanDetailsCubit>(context);
    bool isFound = false;
    if (cubit.allotedLocationModel?.data?.locationType == "Mandal") {
      if (widget.type == "Shakti Kendra" || widget.type == "Booth") {
        for (int i = 0; i < (cubit.allotedLocationModel?.data?.locations?.length ?? 0); i++) {
          if (isFound == false) {
            if (cubit.allotedLocationModel?.data?.locations?[i].name != mandalName) {
              isFound = true;
            } else {
              isFound = false;
            }
          }
        }
      }
    }
    return isFound;
  }

  gettingBackgroundColor(String mandal, int locationId) {
    final cubit = BlocProvider.of<ZilaDataCubit>(context);

    if (widget.typeLevel == "Mandal") {
      if (widget.type == "Shakti Kendra" || widget.type == "Booth") {
        if (cubit.dependentDropdownSelected?.id == locationId) {
          return AppColor.orange;
        } else {
          return mappedMandalWithSKWhenUserIsMandal(mandal)
              ? AppColor.naturalBlackColor
              : AppColor.boothContainerColour;
        }
      }
    } else {
      if (widget.type == "Booth" || widget.type == "Panna") {
        return cubit.dependentDropdownSelected?.id == locationId ? AppColor.orange : AppColor.boothContainerColour;
      } else {
        return cubit.dependentDropdownSelected?.id == locationId ? AppColor.orange : AppColor.naturalBlackColor;
      }
    }
  }
}
