import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../common/common_logo_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../zila_data_page/dropdown_handler/dropdown_handler.dart';
import '../../zila_data_page/network/model/independent_drodown_model.dart';
import '../cubit/sangathan_detail_cubit.dart';
import '../sangathan_deatils_page.dart';

class SelectAllottedLocationSheetWidget extends StatefulWidget {
  final String typeLevel;
  final List<Locations> locationList;

  const SelectAllottedLocationSheetWidget({Key? key, required this.typeLevel, required this.locationList})
      : super(key: key);

  @override
  State<SelectAllottedLocationSheetWidget> createState() => _SelectAllottedLocationSheetWidgetState();
}

class _SelectAllottedLocationSheetWidgetState extends State<SelectAllottedLocationSheetWidget> {
  Future<bool> isExist() async {
    var cubit = context.read<SangathanDetailsCubit>();
    return cubit.selectedAllottedLocation != null ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    String currentLocale = Localizations.localeOf(context).toString();
    var cubit = context.read<SangathanDetailsCubit>();
    return WillPopScope(
      onWillPop: isExist,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentLocale == "hi"
                      ? "${getLocalizationNameOfLevel(context, DropdownHandler.gettingReverseLocationTypeForCondition(widget.typeLevel))} ${S.of(context).choose}"
                      : "${S.of(context).choose} ${getLocalizationNameOfLevel(context, DropdownHandler.gettingReverseLocationTypeForCondition(widget.typeLevel))}",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                cubit.selectedAllottedLocation == null
                    ? const SizedBox()
                    : IconButton(
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
            itemCount: widget.locationList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          cubit.onSelectAllottedLocation(widget.locationList[index]);
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        color: AppColor.transparent,
                        child: Row(
                          children: [
                            CommonLogoWidget(
                                name: widget.locationList[index].name ?? "",
                                backgroundColor: cubit.selectedAllottedLocation?.name == widget.locationList[index].name
                                    ? AppColor.orange
                                    : AppColor.naturalBlackColor),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.locationList[index].name ?? "",
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
      ),
    );
  }
}
