import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../cubit/zila_data_cubit.dart';
import '../network/model/data_unit_model.dart';

class DataSubUnitBottomSheetWidget extends StatefulWidget {
  final int level;
  final int unitId;
  final List<SubUnits> subUnits;

  const DataSubUnitBottomSheetWidget({Key? key, required this.subUnits, required this.unitId, required this.level})
      : super(key: key);

  @override
  State<DataSubUnitBottomSheetWidget> createState() => _DataSubUnitBottomSheetWidgetState();
}

class _DataSubUnitBottomSheetWidgetState extends State<DataSubUnitBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ZilaDataCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 20, bottom: 0, left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).selectSubUnit,
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
            child: ListView.separated(
          separatorBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Divider(
                color: AppColor.borderColor,
              ),
            );
          },
          padding: EdgeInsets.zero,
          itemCount: widget.subUnits.length,
          itemBuilder: (context, index) {
            var subUnit = widget.subUnits[index];
            return GestureDetector(
              onTap: () {
                cubit.onTapFilterData(subUnit: subUnit.id == null ? "" : subUnit.id.toString(), unit: widget.unitId);
                context.read<ZilaDataCubit>().getEntryData(data: {
                  "level": widget.level,
                  "sub_unit": subUnit.id ?? "",
                  "unit": widget.unitId,
                  "level_name": cubit.levelNameId
                });

                Navigator.pop(context);
              },
              child: Container(
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.infinity,
                color: AppColor.transparent,
                alignment: Alignment.centerLeft,
                child: Text(
                  subUnit.name ?? "",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            );
          },
        ))
      ],
    );
  }
}
