import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sangathan/AddEntry/Screen/widget/image_not_uploaded_widget.dart';
import 'package:sangathan/AddEntry/Screen/widget/image_picker_bottomsheet.dart';
import 'package:sangathan/AddEntry/Screen/widget/image_preview_dialog.dart';
import 'package:sangathan/AddEntry/Screen/widget/upload_file_widget.dart';
import 'package:sangathan/AddEntry/dynamic_ui_handler/dynamic_ui_handler.dart';
import 'package:sangathan/AddEntry/dynamic_ui_handler/dynamic_validator.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/common/common_button.dart';

import '../../Storage/user_storage_service.dart';
import '../../Values/space_height_widget.dart';
import '../../common/textfiled_widget.dart';
import '../../generated/l10n.dart';
import '../../route/route_path.dart';
import '../Cubit/add_entry_cubit.dart';
import '../Cubit/add_entry_state.dart';
import '../dynamic_ui_handler/field_handler.dart';
import 'add_entry_preview_submit_screen.dart';
import 'widget/add_entry_common_dropdown_sheet.dart';
import 'widget/custom_radio_button.dart';
import 'widget/select_boxs.dart';

class AddEntryPage extends StatefulWidget {
  const AddEntryPage(
      {Key? key,
      required this.type,
      required this.leaveId,
      required this.unitId,
      required this.levelName,
      this.countryStateId,
      this.subUnitId,
      this.personData,
      required this.isEditEntry,
      this.pannaID,
      this.personID})
      : super(key: key);
  final String type;
  final int leaveId;
  final dynamic unitId;
  final int? countryStateId;
  final int? personID;
  final bool isEditEntry;
  final String? subUnitId;
  final int? pannaID;

  final int? levelName;
  final Map<String, dynamic>? personData;

  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<AddEntryCubit>().getDropdownData();
    log(widget.personData.toString());
    print("----------------------------------------  required parameter  -------------------------------------");
    print("Level name :: ${widget.levelName}");
    print("Unit :: ${widget.unitId}");
    print("Level  :: ${widget.leaveId}");
    print("from:: ${widget.type}Entry");
    print("type id: : 1");
    print("Sub unit :: ${widget.subUnitId}");
    print("personID :: ${widget.personID}");
    print("--------------------------------------------------------------------------------------------------");
    final cubit = context.read<AddEntryCubit>();
    cubit.type = 1;
    cubit.levelId = widget.leaveId;
    cubit.unitId = widget.unitId ?? "";
    cubit.from = "${widget.type}Entry";
    cubit.subUnitId = widget.subUnitId ?? "";
    cubit.levelName = widget.levelName;
    cubit.personID = widget.personID;

    log(widget.personData.toString());
    cubit.entryField = [];
    super.initState();
  }

  formFieldWidget(AddEntryCubit cubit, int i) {
    String currentLocale = Localizations.localeOf(context).toString();

    return Column(
      children: [
        /// Here getting specify dropdown list
        if (DynamicUIHandler.dropdowns.contains(cubit.entryField![i].fieldName)) ...[
          spaceHeightWidget(20),
          BlocBuilder<AddEntryCubit, AddEntryState>(
            builder: (context, state) {
              /// Here getting specify dropdown list
              getDropdownList(String dropdownType, AddEntryCubit cubit) {
                if (dropdownType == "designation") {
                  return cubit.designationData;
                } else if (dropdownType == "categoryId") {
                  return cubit.categoryData;
                } else if (dropdownType == "caste") {
                  return cubit.castData;
                } else if (dropdownType == "educationId") {
                  return cubit.qualificationData;
                } else if (dropdownType == "religionId") {
                  return cubit.religionData;
                } else if (dropdownType == "professionId") {
                  return cubit.professionData;
                } else if (dropdownType == "blood_group") {
                  return DynamicUIHandler.bloodGroupList;
                } else if (dropdownType == "district") {
                  return cubit.districtDropdownData;
                } else {
                  return [];
                }
              }

              return TextFieldWidget(
                onTap: () {
                  if (cubit.entryField?[i].fieldName == "caste") {
                    if (cubit.categorySelected != null) {
                      showModalBottomSheet(
                          enableDrag: false,
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
                          builder: (builder) {
                            return AddEntryCommonDropdownSheet(
                              dropdownDataList: getDropdownList(cubit.entryField![i].fieldName ?? "", cubit),
                              fieldName: cubit.entryField![i].fieldName ?? "",
                              displayNameForUI: cubit.entryField![i].displayNameForUI ?? "",
                            );
                          });
                    } else {
                      EasyLoading.showToast(S.of(context).selectCategory,
                          toastPosition: EasyLoadingToastPosition.bottom);
                    }
                  } else {
                    showModalBottomSheet(
                        enableDrag: false,
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
                        builder: (builder) {
                          return AddEntryCommonDropdownSheet(
                            dropdownDataList: getDropdownList(cubit.entryField![i].fieldName ?? "", cubit),
                            fieldName: cubit.entryField![i].fieldName ?? "",
                            displayNameForUI: cubit.entryField![i].displayNameForUI ?? "",
                          );
                        });
                  }
                },
                controller: FieldHandler.getDropdownSelectedTextController(cubit.entryField![i].fieldName ?? "", cubit),
                validator: (value) => DynamicValidator.dropdownValidation(
                    context: context,
                    value: value,
                    mandatoryField: cubit.entryField![i].mandatoryField ?? false,
                    displayNameForUI: cubit.entryField![i].displayNameForUI ?? ""),
                readOnly: true,
                suffixWidget: const Icon(Icons.keyboard_arrow_down),
                isMandatoryField: cubit.entryField![i].mandatoryField ?? false,
                textInputFormatter:
                    DynamicValidator.addTextInputFormatters(fieldType: cubit.entryField![i].fieldName ?? ''),
                title: cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale),
                keyboardType: cubit.getTextInputType(fieldType: cubit.entryField![i].fieldName ?? ''),
                hintText: cubit.getHintText(
                    hintText: '${cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale)}',
                    currentLocale: currentLocale),
              );

              /*CustomDropDown(
                selectedValue: FieldHandler.getDropdownSelected(cubit.entryField![i].fieldName ?? "", cubit),
                title: cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale),
                // hintText:
                //     'Select ${cubit.entryField![i].displayNameForUI ?? ""}',
                hintText: cubit.getDropDownLocal(
                    text: cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale),
                    currentLocale: currentLocale),
                isMandatoryField: cubit.entryField![i].mandatoryField ?? false,
                validator: (dynamic value) {
                  if (cubit.entryField![i].mandatoryField ?? false) {
                    if (value == null) {
                      return '${S.of(context).please} ${cubit.entryField![i].displayNameForUI ?? ""} ${S.of(context).enter}';
                    }
                  }
                  return null;
                },
                dropDownList: getDropdownList(cubit.entryField![i].fieldName ?? "", cubit)
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name ?? '')))
                    .toList(),
                onChange: ((value) {
                  cubit.changeDropdownValue(value, cubit.entryField![i].fieldName ?? "");
                  //  cubit.onChangeDesignationDropDown(value);
                }),
              );*/
            },
          )
        ]

        /// Here text field  generate logic
        else if (DynamicUIHandler.textfield.contains(cubit.entryField![i].fieldName)) ...[
          spaceHeightWidget(20),

          /// Here text field with file picker generate logic
          if (DynamicUIHandler.filePicker.contains(cubit.entryField![i].fieldName)) ...[
            if (widget.personData != null) ...[
              for (var item in widget.personData!.entries) ...[
                if (cubit.entryField![i].fieldName == item.key)
                  if (item.value != null || item.value != "") ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFieldWidget(
                            initialValue: item.value.toString(),
                            textInputFormatter: DynamicValidator.addTextInputFormatters(
                                fieldType: cubit.entryField![i].fieldName ?? ''),
                            validator: (value) => DynamicValidator.getTextFieldValidation(
                                context: context,
                                fieldName: cubit.entryField![i].fieldName ?? '',
                                value: value,
                                mandatoryField: cubit.entryField![i].mandatoryField ?? false,
                                displayNameForUI: cubit.entryField![i].displayNameForUI ?? ""),
                            isMandatoryField: cubit.entryField![i].mandatoryField ?? false,
                            onChanged: (value) {
                              FieldHandler.onUpdate(i, value, cubit.entryField![i].fieldName ?? "", cubit);
                            },
                            title: cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale),
                            keyboardType: cubit.getTextInputType(fieldType: cubit.entryField![i].fieldName ?? ''),
                            hintText: cubit.getHintText(
                                hintText:
                                    '${cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale)}',
                                currentLocale: currentLocale)),
                        spaceHeightWidget(8),
                        UploadCard(
                          uploadedFilePath: FieldHandler.getFileName(
                                  "${(cubit.entryField![i].fieldName ?? "").split(RegExp(r"[A-Z]"))[0]}_url", cubit)
                              .split("/")
                              .last,
                          onTapImagePrivew: (() {
                            int index = cubit.allImagePickerList.indexWhere((element) {
                              return element["fieldName"].toString().split("_")[0] ==
                                  (cubit.entryField![i].fieldName ?? "").split(RegExp(r"[A-Z]"))[0];
                            });
                            showDialog(
                                context: context,
                                builder: ((context) =>
                                    ImagePreViewDialog(path: cubit.allImagePickerList[index]["value"])));
                          }),
                          onTap: (() async {
                            showModalBottomSheet(
                                context: context,
                                builder: ((context) => ImagePickerBottomSheet(onTapCamera: (() async {
                                      Navigator.pop(context);
                                      await cubit.pickFileFromCamera(
                                          "${(cubit.entryField![i].fieldName ?? "").split(RegExp(r"[A-Z]"))[0]}_url");
                                    }), onTapGallery: (() async {
                                      Navigator.pop(context);

                                      await cubit.pickFile(
                                          "${(cubit.entryField![i].fieldName ?? "").split(RegExp(r"[A-Z]"))[0]}_url");
                                    }))));
                          }),
                        ),
                      ],
                    )
                  ]
              ]
            ] else ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFieldWidget(
                      textInputFormatter:
                          DynamicValidator.addTextInputFormatters(fieldType: cubit.entryField![i].fieldName ?? ''),
                      validator: (value) => DynamicValidator.getTextFieldValidation(
                          context: context,
                          fieldName: cubit.entryField![i].fieldName ?? '',
                          value: value,
                          mandatoryField: cubit.entryField![i].mandatoryField ?? false,
                          displayNameForUI: cubit.entryField![i].displayNameForUI ?? ""),
                      isMandatoryField: cubit.entryField![i].mandatoryField ?? false,
                      onChanged: (value) {
                        FieldHandler.onUpdate(i, value, cubit.entryField![i].fieldName ?? "", cubit);
                      },
                      title: cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale),
                      keyboardType: cubit.getTextInputType(fieldType: cubit.entryField![i].fieldName ?? ""),
                      hintText: cubit.getHintText(
                          hintText:
                              '${cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale)}',
                          currentLocale: currentLocale)),
                  spaceHeightWidget(8),
                  UploadCard(
                    uploadedFilePath: FieldHandler.getFileName(
                            "${(cubit.entryField![i].fieldName ?? "").split(RegExp(r"[A-Z]"))[0]}_url", cubit)
                        .split("/")
                        .last,
                    onTapImagePrivew: (() {
                      int index = cubit.allImagePickerList.indexWhere((element) =>
                          element["fieldName"].toString().split("_")[0] ==
                          (cubit.entryField![i].fieldName ?? "").split(RegExp(r"[A-Z]"))[0]);
                      showDialog(
                          context: context,
                          builder: ((context) => ImagePreViewDialog(path: cubit.allImagePickerList[index]["value"])));
                    }),
                    onTap: (() async {
                      // await cubit.pickFile(
                      //     "${(cubit.entryField![i].fieldName ?? "").split(RegExp(r"[A-Z]"))[0]}_url");
                      showModalBottomSheet(
                          context: context,
                          builder: ((context) => ImagePickerBottomSheet(onTapCamera: (() async {
                                Navigator.pop(context);
                                await cubit.pickFileFromCamera(
                                    "${(cubit.entryField![i].fieldName ?? "").split(RegExp(r"[A-Z]"))[0]}_url");
                              }), onTapGallery: (() async {
                                Navigator.pop(context);

                                await cubit.pickFile(
                                    "${(cubit.entryField![i].fieldName ?? "").split(RegExp(r"[A-Z]"))[0]}_url");
                              }))));
                    }),
                  ),
                ],
              )
            ]
          ] else ...[
            if (widget.personData != null) ...[
              for (var item in widget.personData!.entries) ...[
                if (cubit.entryField![i].fieldName == item.key)
                  if (item.value != null || item.value != "") ...[
                    TextFieldWidget(
                      initialValue: item.value.toString(),
                      textInputFormatter: DynamicValidator.addTextInputFormatters(
                          fieldType: cubit.entryField![i].fieldName ?? '', initialValue: item.value.toString()),
                      validator: (value) => DynamicValidator.getTextFieldValidation(
                          context: context,
                          fieldName: cubit.entryField![i].fieldName ?? '',
                          value: value,
                          mandatoryField: cubit.entryField![i].mandatoryField ?? false,
                          displayNameForUI: cubit.entryField![i].displayNameForUI ?? ""),
                      isMandatoryField: cubit.entryField![i].mandatoryField ?? false,
                      onChanged: (value) {
                        FieldHandler.onUpdate(i, value, cubit.entryField![i].fieldName ?? "", cubit);
                      },
                      title: cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale),
                      keyboardType: cubit.getTextInputType(fieldType: cubit.entryField![i].fieldName ?? ''),
                      hintText: cubit.getHintText(
                          hintText:
                              '${cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale)}',
                          currentLocale: currentLocale),
                    )
                  ]
              ]
            ] else ...[
              if (cubit.entryField![i].fieldName == "pannaNumber") ...[
                if (widget.pannaID != null && widget.pannaID != "") ...[
                  TextFieldWidget(
                    initialValue: widget.pannaID == null ? "" : widget.pannaID.toString(),
                    readOnly: true,
                    textInputFormatter:
                        DynamicValidator.addTextInputFormatters(fieldType: cubit.entryField![i].fieldName ?? ''),
                    validator: (value) => DynamicValidator.getTextFieldValidation(
                        context: context,
                        fieldName: cubit.entryField![i].fieldName ?? '',
                        value: value,
                        mandatoryField: cubit.entryField![i].mandatoryField ?? false,
                        displayNameForUI: cubit.entryField![i].displayNameForUI ?? ""),
                    isMandatoryField: cubit.entryField![i].mandatoryField ?? false,
                    onChanged: (value) {
                      FieldHandler.onUpdate(i, value, cubit.entryField![i].fieldName ?? "", cubit);
                    },
                    title: cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale),
                    keyboardType: cubit.getTextInputType(fieldType: cubit.entryField![i].fieldName ?? ''),
                    hintText: cubit.getHintText(
                        hintText: '${cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale)}',
                        currentLocale: currentLocale),
                  ),
                ] else ...[
                  TextFieldWidget(
                    validator: (value) => DynamicValidator.getTextFieldValidation(
                        context: context,
                        fieldName: cubit.entryField![i].fieldName ?? '',
                        value: value,
                        mandatoryField: cubit.entryField![i].mandatoryField ?? false,
                        displayNameForUI: cubit.entryField![i].displayNameForUI ?? ""),
                    isMandatoryField: cubit.entryField![i].mandatoryField ?? false,
                    textInputFormatter:
                        DynamicValidator.addTextInputFormatters(fieldType: cubit.entryField![i].fieldName ?? ''),
                    onChanged: (value) {
                      FieldHandler.onUpdate(i, value, cubit.entryField![i].fieldName ?? "", cubit);
                    },
                    title: cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale),
                    keyboardType: cubit.getTextInputType(fieldType: cubit.entryField![i].fieldName ?? ''),
                    hintText: cubit.getHintText(
                        hintText: '${cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale)}',
                        currentLocale: currentLocale),
                  )
                ]
              ] else ...[
                TextFieldWidget(
                  validator: (value) => DynamicValidator.getTextFieldValidation(
                      context: context,
                      fieldName: cubit.entryField![i].fieldName ?? '',
                      value: value,
                      mandatoryField: cubit.entryField![i].mandatoryField ?? false,
                      displayNameForUI: cubit.entryField![i].displayNameForUI ?? ""),
                  isMandatoryField: cubit.entryField![i].mandatoryField ?? false,
                  textInputFormatter:
                      DynamicValidator.addTextInputFormatters(fieldType: cubit.entryField![i].fieldName ?? ''),
                  onChanged: (value) {
                    FieldHandler.onUpdate(i, value, cubit.entryField![i].fieldName ?? "", cubit);
                  },
                  title: cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale),
                  keyboardType: cubit.getTextInputType(fieldType: cubit.entryField![i].fieldName ?? ''),
                  hintText: cubit.getHintText(
                      hintText: '${cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale)}',
                      currentLocale: currentLocale),
                )
              ]
            ]
          ]
        ]

        /// Here radio button
        else if (DynamicUIHandler.radioButton.contains(cubit.entryField![i].fieldName)) ...[
          spaceHeightWidget(20),
          BlocBuilder<AddEntryCubit, AddEntryState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cubit.entryField![i].displayNameForUI ?? "",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  CustomRadioButton(
                    title: S.of(context).male,
                    value: 'male',
                    groupValue: cubit.selectRadio ?? "",
                  ),
                  CustomRadioButton(
                    title: S.of(context).female,
                    value: 'female',
                    groupValue: cubit.selectRadio ?? "",
                  ),
                  CustomRadioButton(
                    title: S.of(context).transgender,
                    value: 'transGender',
                    groupValue: cubit.selectRadio ?? "",
                  ),
                ],
              );
            },
          )
        ]

        /// Here calender view
        else if (DynamicUIHandler.calenderView.contains(cubit.entryField![i].fieldName)) ...[
          spaceHeightWidget(20),
          TextFieldWidget(
            onTap: (() async {
              cubit.selectedDoaDate(context);
            }),
            readOnly: true,
            controller: cubit.dobController,
            hintText: cubit.date == 'Select DOB of Birth'
                ? cubit.getDropDownLocal(
                    text: '${cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale)}',
                    currentLocale: currentLocale)
                : cubit.date,
            title: cubit.getLocaleName(cubit.entryField![i].displayNameForUI ?? "", currentLocale),
            validator: ((value) {
              if (value.isNotEmpty) {
                if (cubit.calculateAge(DateFormat("dd/MM/yyyy").parse(value)) < 16) {
                  return S.of(context).dobError;
                }
              }

              return null;
            }),
            suffixWidget: const Icon(
              Icons.calendar_month_outlined,
              color: AppColor.black,
            ),
            // hintText: cubit.date,
          ),
        ]
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEntryCubit>();
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                '${widget.isEditEntry ? S.of(context).edit : S.of(context).adds} ${S.of(context).entry}',
                style: const TextStyle(
                    fontFamily: 'Tw Cen MT', fontSize: 20, fontWeight: FontWeight.w400, color: AppColor.textBlackColor),
              )
            ],
          ),
          Expanded(
            flex: 2,
            child: BlocConsumer<AddEntryCubit, AddEntryState>(
              listener: (context, state) {
                if (state is AddEntryErrorState) {
                  EasyLoading.showError(state.error);
                }
              },
              builder: (context, state) {
                if (state is DropDownValueFetchedState) {
                  cubit.categorySelected = null;
                  cubit.nativeStateSelected = null;
                  cubit.qualificationSelected = null;
                  cubit.religionSelected = null;
                  cubit.professionSelected = null;
                  cubit.designationSelected = null;
                  // cubit.dropdownData = state.category.data;
                  cubit.categoryData = state.category.data!.personCategory!;
                  cubit.nativeStateData = state.category.data!.nativeState!;
                  cubit.qualificationData = state.category.data!.personEducation!;
                  cubit.religionData = state.category.data!.religion!;
                  cubit.professionData = state.category.data!.personProfession!;
                  context.read<AddEntryCubit>().getDesignationDropdown(data: {
                    "type": "Designation",
                    "data_level": widget.leaveId,
                    "country_state_id": widget.countryStateId ?? StorageService.userData?.user?.countryStateId,
                    "unit_id": widget.unitId ?? "",
                    "sub_unit_id": widget.subUnitId
                  });
                } else if (state is CastFetchedState) {
                  cubit.castData = state.cast.data!;
                  if (widget.personData != null) {
                    cubit.getInitialCasteData(widget.personData);
                  }
                } else if (state is DesignationDropDownSuccessState) {
                  cubit.designationData = [];
                  cubit.designationData = state.designationList.data ?? [];

                  context.read<AddEntryCubit>().getDistrictDropdown(widget.countryStateId.toString());
                } else if (state is DistrictDropdownSuccessState) {
                  cubit.districtDropdownData = state.districtDropdownData;
                  context.read<AddEntryCubit>().getAddEntryFormStructure(
                      levelID: widget.leaveId.toString(),
                      countryId: widget.countryStateId ?? StorageService.userData?.user?.countryStateId);
                } else if (state is GetAddEntryFormStructureSuccessState) {
                  if (state.addEntryFormStructure.dataEntryField == null) {
                    cubit.entryField = null;
                  } else {
                    cubit.entryField = state.addEntryFormStructure.dataEntryField ?? [];
                  }
                  if (widget.personData != null) {
                    cubit.getInitialTextfieldData(widget.personData);
                    cubit.getInitialImageUrls(widget.personData);
                    cubit.getInitialUserprofileImageData(widget.personData);
                    cubit.getInitialGenderData(widget.personData);
                    cubit.getInitialDOBData(widget.personData);
                    cubit.getInitialMultiSelectionFieldData(widget.personData);
                    cubit.getInitialDropdownData(widget.personData);
                  }
                }
                return cubit.entryField == null
                    ? const Center(
                        child: Text(
                          "No form available",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : cubit.entryField!.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    spaceHeightWidget(14),

                                    /// User profile photo
                                    Center(
                                        child: ImageNotUploaded(
                                      initialUserprofileURL: cubit.initialUserprofileURL,
                                      onTap: (() {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: ((context) => ImagePickerBottomSheet(onTapCamera: (() async {
                                                  Navigator.pop(context);
                                                  await cubit.requestPermission(ImageSource.camera);
                                                }), onTapGallery: (() async {
                                                  Navigator.pop(context);

                                                  await cubit.requestPermission(ImageSource.gallery);
                                                }))));
                                      }),
                                    )),

                                    spaceHeightWidget(20),

                                    for (int i = 0; i < cubit.entryField!.length; i++)

                                      /// Here primary logic
                                      if (cubit.entryField![i].primary ?? false) formFieldWidget(cubit, i),
                                    spaceHeightWidget(20),

                                    /// Here primary multi check
                                    Wrap(
                                      runSpacing: 5.0,
                                      spacing: 5.0,
                                      children: <Widget>[
                                        for (var item in cubit.entryField!)
                                          if (DynamicUIHandler.multiSelectionField.contains(item.formControlName))
                                            if (item.primary ?? false)
                                              IntrinsicWidth(
                                                child: SelectPropertyBox(
                                                  value: cubit.allMultiFieldData
                                                      .any((element) => element.values.contains(item.formControlName)),
                                                  title: item.displayNameForUI ?? "",
                                                  onChanged: (value) {
                                                    cubit.getAllMultiCheckData(
                                                      item.formControlName ?? "",
                                                      value,
                                                    );
                                                  },
                                                ),
                                              ),
                                      ],
                                    ),
                                    spaceHeightWidget(10),

                                    /// Here Secondary logic
                                    ExpansionTile(
                                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                      iconColor: AppColor.black,
                                      collapsedIconColor: AppColor.black,
                                      tilePadding: EdgeInsets.zero,
                                      title: Text(
                                        S.of(context).fillSecondaryInformation,
                                        style: GoogleFonts.quicksand(fontSize: 20, fontWeight: FontWeight.w600),
                                      ),
                                      children: [
                                        //spaceHeightWidget(10),
                                        for (int i = 0; i < cubit.entryField!.length; i++)
                                          if (cubit.entryField![i].primary == false) formFieldWidget(cubit, i),
                                        spaceHeightWidget(10),

                                        /// Here Secondary multi check
                                        Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.start,
                                          runSpacing: 5.0,
                                          spacing: 5.0,
                                          children: <Widget>[
                                            for (var item in cubit.entryField!)
                                              if (DynamicUIHandler.multiSelectionField.contains(item.formControlName))
                                                if (item.primary == false)
                                                  IntrinsicWidth(
                                                    child: SelectPropertyBox(
                                                      value: cubit.allMultiFieldData.any(
                                                          (element) => element.values.contains(item.formControlName)),
                                                      title: item.displayNameForUI ?? "",
                                                      onChanged: (value) {
                                                        cubit.getAllMultiCheckData(
                                                          item.formControlName ?? "",
                                                          value,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        spaceHeightWidget(20),
                                      ],
                                    ),
                                    spaceHeightWidget(10),
                                    CommonButton(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        final FormState form = _formKey.currentState!;

                                        for (int i = 0; i < (cubit.entryField?.length ?? 0); i++) {
                                          if (cubit.entryField?[i].name?.toLowerCase() == 'Photo'.toLowerCase()) {
                                            if (cubit.entryField?[i].mandatoryField == true) {
                                              cubit.isPhotoMandatory = true;
                                            }
                                          }
                                        }

                                        if (cubit.isPhotoMandatory) {
                                          if (cubit.file != null || cubit.initialUserprofileURL != null) {
                                            if (form.validate()) {
                                              cubit.previewAndSubmitList(widget.pannaID);
                                              Navigator.pushNamed(
                                                context,
                                                RoutePath.addEntryPreviewSubmit,
                                                arguments: AddEntryPreviewSubmit(
                                                    isEdit: widget.isEditEntry, pannaIDLevelName: widget.levelName),
                                              );
                                            } else {
                                              EasyLoading.showToast("Please fill all required field",
                                                  toastPosition: EasyLoadingToastPosition.top);
                                            }
                                          } else {
                                            EasyLoading.showToast(S.of(context).pleaseSelectPhoto,
                                                toastPosition: EasyLoadingToastPosition.top);
                                          }
                                        } else {
                                          if (form.validate()) {
                                            cubit.previewAndSubmitList(widget.pannaID);
                                            Navigator.pushNamed(
                                              context,
                                              RoutePath.addEntryPreviewSubmit,
                                              arguments: AddEntryPreviewSubmit(
                                                  isEdit: widget.isEditEntry, pannaIDLevelName: widget.levelName),
                                            );
                                          } else {
                                            EasyLoading.showToast("Please fill all required field",
                                                toastPosition: EasyLoadingToastPosition.top);
                                          }
                                        }
                                      },
                                      padding: const EdgeInsets.all(12),
                                      title: S.of(context).previewSubmitDetails,
                                      borderRadius: 10,
                                      style: GoogleFonts.quicksand(
                                          color: AppColor.white, fontSize: 16, fontWeight: FontWeight.w700),
                                    ),
                                    spaceHeightWidget(30),
                                  ],
                                ),
                              ),
                            ),
                          );
              },
            ),
          )
        ],
      )),
    );
  }
}
