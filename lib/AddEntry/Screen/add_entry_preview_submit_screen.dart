import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/AddEntry/Screen/widget/custom_textfield.dart';

import '../../Values/app_colors.dart';
import '../../Values/icons.dart';
import '../../Values/space_height_widget.dart';
import '../../Values/space_width_widget.dart';
import '../../common/common_button.dart';
import '../cubit/add_entry_cubit.dart';
import '../dynamic_ui_handler/dynamic_ui_handler.dart';
import 'widget/select_boxs.dart';

class AddEntryPreviewSubmit extends StatefulWidget {
  const AddEntryPreviewSubmit({Key? key}) : super(key: key);

  @override
  State<AddEntryPreviewSubmit> createState() => _AddEntryPreviewSubmitState();
}

class _AddEntryPreviewSubmitState extends State<AddEntryPreviewSubmit> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEntryCubit>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      splashRadius: 20,
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      icon: const Icon(Icons.arrow_back)),
                  const Text(
                    'Add Entry',
                    style: TextStyle(
                        fontFamily: 'Tw Cen MT',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: AppColor.textBlackColor),
                  )
                ],
              ),
              for (var item in cubit.finalAllDataList.entries)
                if (item.key == "photo") ...[
                  Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(
                          height: 115,
                          width: 115,
                          File(item.value),
                          fit: BoxFit.fill,
                        )),
                  )
                ] else ...[
                  const SizedBox()
                ],
              for (int i = 0; i < cubit.entryField!.length; i++)
                if (cubit.entryField![i].primary ?? false)
                  nonEditableField(cubit, i),
              spaceHeightWidget(20),
              for (int i = 0; i < cubit.entryField!.length; i++)
                if (cubit.entryField![i].primary ?? false)
                  multiCheckBox(cubit, i),

              /// Here Secondary logic
              Text(
                'Fill Secondary Information',
                style: GoogleFonts.quicksand(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              spaceHeightWidget(20),
              for (int i = 0; i < cubit.entryField!.length; i++)
                if (cubit.entryField![i].primary == false)
                  nonEditableField(cubit, i),
              for (int i = 0; i < cubit.entryField!.length; i++)
                if (cubit.entryField![i].primary == false)
                  multiCheckBox(cubit, i),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CommonButton(
                      onTap: (() {
                        Navigator.pop(context);
                      }),
                      padding: const EdgeInsets.all(12),
                      title: 'Edit',
                      borderRadius: 10,
                      backGroundcolor: AppColor.white,
                      style: GoogleFonts.quicksand(
                          color: AppColor.buttonOrangeBackGroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  spaceWidthWidget(30),
                  Expanded(
                    child: CommonButton(
                      onTap: (() {
                        /* showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                            20)),
                                    content: Padding(
                                      padding: const EdgeInsets.all(
                                          12.0),
                                      child: Column(
                                        mainAxisSize:
                                        MainAxisSize.min,
                                        children: [
                                          verifyOtpDialogButton(
                                              context, cubit),
                                          spaceHeightWidget(15),
                                          CommonButton(
                                            backGroundcolor:
                                            AppColor.white,
                                            height: 45,
                                            onTap: (() {
                                              Navigator.pop(
                                                  context);
                                              Navigator.pop(
                                                  context);
                                            }),
                                            title:
                                            'Skip & Add new entry',
                                            style: GoogleFonts
                                                .quicksand(
                                                color: AppColor
                                                    .buttonOrangeBackGroundColor,
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight
                                                    .w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }));*/
                      }),
                      padding: const EdgeInsets.all(12),
                      title: 'Submit',
                      borderRadius: 10,
                      style: GoogleFonts.quicksand(
                          color: AppColor.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  nonEditableField(AddEntryCubit cubit, int i) {
    return Column(
      children: [
        for (var item in cubit.finalAllDataList.entries) ...[
          if (cubit.entryField![i].formControlName == item.key) ...[
            if (DynamicUIHandler.dropdowns.contains(item.key) ||
                DynamicUIHandler.textfield.contains(item.key) ||
                DynamicUIHandler.radioButton.contains(item.key) ||
                DynamicUIHandler.calenderView.contains(item.key) ||
                (DynamicUIHandler.filePickerUrl.contains(item.key)))
              if ((DynamicUIHandler.filePicker.contains(item.key)) ||
                  (DynamicUIHandler.filePickerUrl.contains(item.key))) ...[
                spaceHeightWidget(8),
                CommonTextField(
                    title: cubit.getFieldName(item.key),
                    hintText: item.value,
                    suffixWidget:
                        uploadImage(gettingFilePath(item.key, cubit))),
              ] else ...[
                spaceHeightWidget(8),
                CommonTextField(
                  title: cubit.getFieldName(item.key),
                  hintText: item.value,
                )
              ],
          ] else ...[
            const SizedBox()
          ],
        ]
      ],
    );
  }

  multiCheckBox(AddEntryCubit cubit, int i) {
    return Wrap(
      runSpacing: 5.0,
      spacing: 5.0,
      children: <Widget>[
        for (var item in cubit.finalAllDataList.entries)
          if (cubit.entryField![i].formControlName == item.key)
            if (DynamicUIHandler.multiSelectionField.contains(item.key))
              IntrinsicWidth(
                child: SelectPropertyBox(
                  value: item.value == "true" ? true : false,
                  title: cubit.getFieldName(item.key),
                  onChanged: (value) {},
                ),
              ),
      ],
    );
  }

  uploadImage(String fileName) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: GestureDetector(
        child: Container(
          margin: const EdgeInsets.only(right: 6, bottom: 12),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColor.greyColor.withOpacity(0.3))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                AppIcons.galleryColorImage,
                height: 16,
              ),
              spaceWidthWidget(4),
              Text(
                fileName.split("/").last,
                style: GoogleFonts.quicksand(
                    color: AppColor.greyColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }

  gettingFilePath(String key, AddEntryCubit cubit) {
    Iterable<String> foundKey = DynamicUIHandler.filePickerUrl
        .where((element) => element.split("_")[0] == key.split("_")[0]);
    String newFoundKey =
        foundKey.toString().replaceAll("(", "").replaceAll(")", "");
    String imageFilePath = "";
    for (var item in cubit.finalAllDataList.entries) {
      if (item.key == newFoundKey) {
        imageFilePath = item.value;
      }
    }
    return imageFilePath;
  }
}
