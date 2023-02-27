import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Values/app_colors.dart';
import '../../Cubit/add_entry_cubit.dart';

class AddEntryCommonDropdownSheet extends StatefulWidget {
  final dynamic dropdownDataList;
  final String fieldName;
  final String displayNameForUI;

  const AddEntryCommonDropdownSheet({
    this.dropdownDataList,
    Key? key,
    required this.fieldName,
    required this.displayNameForUI,
  }) : super(key: key);

  @override
  State<AddEntryCommonDropdownSheet> createState() => _AddEntryCommonDropdownSheetState();
}

class _AddEntryCommonDropdownSheetState extends State<AddEntryCommonDropdownSheet> {
  @override
  Widget build(BuildContext context) {
    print(widget.fieldName);
    final cubit = context.read<AddEntryCubit>();
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
                "${widget.displayNameForUI} का चयन करें",
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
          itemCount: widget.dropdownDataList.length,
          itemBuilder: (context, index) {
            var dropdownData = widget.dropdownDataList[index];
            return GestureDetector(
              onTap: () {
                cubit.changeDropdownValue(dropdownData, widget.fieldName);
                Navigator.pop(context);
              },
              child: Container(
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.infinity,
                color: AppColor.transparent,
                alignment: Alignment.centerLeft,
                child: Text(
                  dropdownData.name ?? "",
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
