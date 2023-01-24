import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/AddEntry/Cubit/add_entry_cubit.dart';
import 'package:sangathan/AddEntry/Cubit/add_entry_state.dart';
import 'package:sangathan/Values/app_colors.dart';

class CustomDropDown extends StatelessWidget {
  CustomDropDown(
      {super.key,
      required this.title,
      required this.dropDownList,
      this.hintText,
      this.selectedValue});
  String title;
  String? hintText;

  String? selectedValue;
  List<String> dropDownList = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 16),
        ),
        BlocBuilder<AddEntryCubit, AddEntryState>(
          builder: (context, state) {
            return DropdownButtonHideUnderline(
              child: DropdownButton(
                  icon: const Icon(
                    Icons.expand_more,
                    color: AppColor.textBlackColor,
                  ),
                  isExpanded: true,
                  value: selectedValue,
                  hint: Text(
                    hintText ?? "",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColor.greyColor),
                  ),
                  items: dropDownList
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColor.textBlackColor),
                          )))
                      .toList(),
                  onChanged: ((value) {
                    //cubit.onTapDropDownButton(value);
                  })),
            );
          },
        ),
        const Divider(
          height: 2,
          thickness: 1.5,
          color: AppColor.textBlackColor,
        )
      ],
    );
  }
}
