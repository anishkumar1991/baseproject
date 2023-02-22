import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../Storage/user_storage_service.dart';
import '../../../../../../Values/app_colors.dart';
import '../../../../../../common/common_logo_widget.dart';
import '../../../../../../generated/l10n.dart';
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

  const DependentDropdownWidget({Key? key, required this.type, required this.typeLevel, this.countryStateId, this.dataLevelId}) : super(key: key);

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
          /* cubit.dependentDropdownList.sort((a, b) {
            return (a.name?.toLowerCase() ?? 'z').compareTo((b.name?.toLowerCase()) ?? 'z');
          });*/

          if (widget.type == "Panna") {
            if (cubit.dependentDropdownList.isNotEmpty) {
              context.read<ZilaDataCubit>().getBoothPannasStatus(cubit.dependentDropdownList.first.id ?? 0);
            }
          } else {
            context
                .read<ZilaDataCubit>()
                .getUnitData(data: {"type": "Unit", "data_level": widget.dataLevelId, "country_state_id": widget.countryStateId ?? StorageService.userData?.user?.countryStateId});
          }
          if (cubit.dependentDropdownList.isNotEmpty) {
            cubit.dependentDropdownSelected = cubit.dependentDropdownList.first;
            cubit.dependentLevelNameId = cubit.dependentDropdownList.first.id;
            cubit.levelNameId = cubit.dependentLevelNameId;
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
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
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
                              style: GoogleFonts.roboto(color: AppColor.greyColor, fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                            Text(
                              cubit.dependentDropdownSelected?.name ?? "",
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
                    ? "${getLocalizationNameOfLevel(context, DropdownHandler.dependentDropdownName(widget.type, context))} ${S.of(context).choose}"
                    : "${S.of(context).choose} ${getLocalizationNameOfLevel(context, DropdownHandler.dependentDropdownName(widget.type, context))}",
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
                      Future.delayed(Duration.zero).then((value) => Navigator.pop(context));
                    },
                    child: Container(
                      width: double.infinity,
                      color: AppColor.transparent,
                      child: Row(
                        children: [
                          CommonLogoWidget(name: locationList[index].name ?? "", isSelected: cubit.dependentDropdownSelected?.id == locationList[index].id),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            locationList[index].name ?? "",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w500),
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
}
