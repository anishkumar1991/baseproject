import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sangathan/AddEntry/Screen/widget/custom_textfield.dart';
import 'package:sangathan/AddEntry/Screen/widget/image_preview_dialog.dart';
import 'package:sangathan/AddEntry/VerifyPerson/screen/submit_dialog.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/cubit/zila_data_cubit.dart';

import '../../Values/app_colors.dart';
import '../../Values/icons.dart';
import '../../Values/space_height_widget.dart';
import '../../Values/space_width_widget.dart';
import '../../common/common_button.dart';
import '../../generated/l10n.dart';
import '../../route/route_path.dart';
import '../Cubit/add_entry_cubit.dart';
import '../Cubit/add_entry_state.dart';
import '../dynamic_ui_handler/dynamic_ui_handler.dart';
import '../dynamic_ui_handler/field_handler.dart';
import 'widget/select_boxs.dart';

class AddEntryPreviewSubmit extends StatefulWidget {
  const AddEntryPreviewSubmit({Key? key, this.isEdit = false})
      : super(key: key);
  final bool isEdit;

  @override
  State<AddEntryPreviewSubmit> createState() => _AddEntryPreviewSubmitState();
}

class _AddEntryPreviewSubmitState extends State<AddEntryPreviewSubmit> {
  String dateDDMMMYYYY(String date) {
    if (date.contains("/")) {
      DateTime tempDate =
          DateFormat("dd-MM-yyyy").parse(date.replaceAll("/", "-"));
      var outputFormat = DateFormat('dd MMM yyyy');
      var outputDate = outputFormat.format(tempDate);
      return outputDate;
    } else {
      DateTime tempDate = DateFormat("yyyy-MM-dd").parse(date);
      var outputFormat = DateFormat('dd MMM yyyy');
      var outputDate = outputFormat.format(tempDate);
      return outputDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEntryCubit>();
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AddEntryCubit, AddEntryState>(
            listener: (context, state) {
              if (state is SubmitAddEntrySuccessState) {
                EasyLoading.showSuccess(state.message);
                widget.isEdit
                    ? Navigator.popUntil(
                        context, ModalRoute.withName(RoutePath.zilaDataPage))
                    : showDialog(
                        context: context,
                        builder: ((context) {
                          return SubmitDialog(
                            mobileNo: state.mobileNo,
                            personId: cubit.personId ?? 0,
                            onTapSkip: (() {
                              BlocProvider.of<ZilaDataCubit>(context,
                                      listen: false)
                                  .getEntryData(data: {
                                "level": cubit.levelId,
                                "unit": cubit.unitId,
                                "level_name": cubit.levelName
                              });
                              Navigator.popUntil(context,
                                  ModalRoute.withName(RoutePath.zilaDataPage));
                            }),
                          );
                        }));
              }
              if (state is SubmitAddEntryErrorState) {
                EasyLoading.showError(state.errorString);
              }
            },
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
                  Text(
                    '${widget.isEdit ? S.of(context).edit : S.of(context).adds} ${S.of(context).entry}',
                    style: const TextStyle(
                        fontFamily: 'Tw Cen MT',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: AppColor.textBlackColor),
                  )
                ],
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var item in cubit.finalAllDataList.entries)
                        if (item.key == "photo") ...[
                          if (item.value.toString().contains("http")) ...[
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  item.value,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      AppIcons.personLogo,
                                      height: 68,
                                    );
                                  },
                                ),
                              ),
                            )
                          ] else ...[
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
                          ]
                        ] else ...[
                          const SizedBox()
                        ],
                      spaceHeightWidget(20),
                      for (int i = 0; i < cubit.entryField!.length; i++)
                        if (cubit.entryField![i].primary ?? false)
                          nonEditableField(cubit, i),
                      spaceHeightWidget(20),
                      for (int i = 0; i < cubit.entryField!.length; i++)
                        if (cubit.entryField![i].primary ?? false)
                          multiCheckBox(cubit, i),

                      /// Here Secondary logic
                      ExpansionTile(
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        iconColor: AppColor.black,
                        collapsedIconColor: AppColor.black,
                        tilePadding: EdgeInsets.zero,
                        initiallyExpanded: true,
                        title: Text(
                          'Fill Secondary Information',
                          style: GoogleFonts.quicksand(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        children: [
                          spaceHeightWidget(20),
                          for (int i = 0; i < cubit.entryField!.length; i++)
                            if (cubit.entryField![i].primary == false)
                              nonEditableField(cubit, i),
                          for (int i = 0; i < cubit.entryField!.length; i++)
                            if (cubit.entryField![i].primary == false)
                              multiCheckBox(cubit, i),
                          spaceHeightWidget(20),
                        ],
                      ),
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
                                cubit.pressAddEntrySubmitButton();
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
                      ),
                    ],
                  ),
                ),
              )),
              spaceHeightWidget(50),
            ])),
      ),
    );
  }

  nonEditableField(AddEntryCubit cubit, int i) {
    return Column(
      children: [
        for (var item in cubit.finalAllDataList.entries) ...[
          if (cubit.entryField![i].fieldName == item.key) ...[
            if (DynamicUIHandler.dropdowns.contains(item.key) ||
                DynamicUIHandler.textfield.contains(item.key) ||
                DynamicUIHandler.radioButton.contains(item.key) ||
                DynamicUIHandler.calenderView.contains(item.key) ||
                (DynamicUIHandler.filePickerUrl.contains(item.key)))
              if (item.value != "")
                if ((DynamicUIHandler.filePicker.contains(item.key)) ||
                    (DynamicUIHandler.filePickerUrl.contains(item.key))) ...[
                  spaceHeightWidget(8),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      IgnorePointer(
                        child: CommonTextField(
                          isMandatoryField:
                              cubit.entryField![i].mandatoryField ?? false,
                          title: FieldHandler.getFieldName(item.key, cubit),
                          hintText: item.value,
                        ),
                      ),
                      uploadImage(gettingFilePath(item.key, cubit), cubit, i),
                    ],
                  ),
                ] else if (DynamicUIHandler.calenderView
                    .contains(item.key)) ...[
                  spaceHeightWidget(8),
                  IgnorePointer(
                    child: CommonTextField(
                      isMandatoryField:
                          cubit.entryField![i].mandatoryField ?? false,
                      title: FieldHandler.getFieldName(item.key, cubit),
                      hintText: dateDDMMMYYYY(item.value),
                    ),
                  )
                ] else ...[
                  spaceHeightWidget(8),
                  if (DynamicUIHandler.dropdowns.contains(item.key))
                    IgnorePointer(
                      child: CommonTextField(
                        isMandatoryField:
                            cubit.entryField![i].mandatoryField ?? false,
                        title: FieldHandler.getFieldName(item.key, cubit),
                        hintText: FieldHandler.getDropdownSelectedValueName(
                            item.key, cubit),
                      ),
                    )
                  else
                    IgnorePointer(
                      child: CommonTextField(
                        isMandatoryField:
                            cubit.entryField![i].mandatoryField ?? false,
                        title: FieldHandler.getFieldName(item.key, cubit),
                        hintText: item.value,
                      ),
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
      crossAxisAlignment: WrapCrossAlignment.start,
      runSpacing: 5.0,
      spacing: 5.0,
      children: <Widget>[
        for (var item in cubit.finalAllDataList.entries)
          if (cubit.entryField![i].fieldName == item.key)
            if (DynamicUIHandler.multiSelectionField.contains(item.key))
              IntrinsicWidth(
                child: SelectPropertyBox(
                  value: item.value == "Yes" ? true : false,
                  title: FieldHandler.getFieldName(item.key, cubit),
                  onChanged: (value) {},
                ),
              ),
      ],
    );
  }

  Widget uploadImage(String fileName, AddEntryCubit cubit, int i) {
    return fileName != null && fileName != ""
        ? FittedBox(
            fit: BoxFit.scaleDown,
            child: InkWell(
              onTap: (() {
                print('dddd');
                int index = cubit.allImagePickerList.indexWhere((element) =>
                    element["fieldName"].toString().split("_")[0] ==
                    (cubit.entryField![i].fieldName ?? "")
                        .split(RegExp(r"[A-Z]"))[0]);
                showDialog(
                    context: context,
                    builder: ((context) => ImagePreViewDialog(
                        path: cubit.allImagePickerList[index]["value"])));
              }),
              child:
                  //  Container(
                  //   width: 200,
                  //   margin: const EdgeInsets.only(right: 6, bottom: 12),
                  //   padding: const EdgeInsets.all(6),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(6),
                  //       border:
                  //           Border.all(color: AppColor.greyColor.withOpacity(0.3))),
                  // child:
                  Container(
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.greenshade900),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppIcons.galleryColorImage,
                      height: 15,
                      color: AppColor.greenshade900,
                    ),
                    spaceWidthWidget(5),
                    Text(
                      'File uploaded',
                      style: TextStyle(
                          color: AppColor.greenshade900, fontSize: 12),
                    )
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Image.asset(
              //       AppIcons.galleryColorImage,
              //       height: 16,
              //     ),
              //     spaceWidthWidget(4),
              //     Expanded(
              //       child: Text(
              //         fileName.split("/").last,
              //         maxLines: 2,
              //         style: GoogleFonts.quicksand(
              //             color: AppColor.greyColor,
              //             fontSize: 10,
              //             fontWeight: FontWeight.w400),
              //       ),
              //     )
              //   ],
              // ),
            ),
          )
        // )
        : const SizedBox();
  }

  gettingFilePath(String key, AddEntryCubit cubit) {
    Iterable<String> foundKey = DynamicUIHandler.filePickerUrl.where(
        (element) => element.split("_")[0] == key.split(RegExp(r"[A-Z]"))[0]);
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
