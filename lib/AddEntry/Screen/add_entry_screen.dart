import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:sangathan/AddEntry/Screen/widget/drop_down_widget.dart';
import 'package:sangathan/AddEntry/Screen/widget/image_not_uploaded_widget.dart';
import 'package:sangathan/AddEntry/Screen/widget/upload_file_widget.dart';
import 'package:sangathan/AddEntry/dynamic_ui_handler/dynamic_ui_handler.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/common/common_button.dart';
import 'package:sangathan/common/textfiled_widget.dart';

import '../../Storage/user_storage_service.dart';
import '../../generated/l10n.dart';
import '../../route/route_path.dart';
import '../Cubit/add_entry_cubit.dart';
import '../Cubit/add_entry_state.dart';
import '../dynamic_ui_handler/field_handler.dart';
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
      this.personID})
      : super(key: key);
  final String type;
  final int leaveId;
  final int? unitId;
  final int? countryStateId;
  final int? personID;

  final String? subUnitId;

  final int? levelName;
  final Map<String, dynamic>? personData;

  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  OtpFieldController otpFieldController = OtpFieldController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<AddEntryCubit>().getDropdownData();
    print(
        "----------------------------------------  required parameter  -------------------------------------");
    print("Level name :: ${widget.levelName}");
    print("Unit :: ${widget.unitId}");
    print("Level  :: ${widget.leaveId}");
    print("from:: ${widget.type}Entry");
    print("type id: : 1");
    print("Sub unit :: ${widget.subUnitId}");
    print("personID :: ${widget.personID}");
    print(
        "--------------------------------------------------------------------------------------------------");
    final cubit = context.read<AddEntryCubit>();
    cubit.type = 1;
    cubit.levelId = widget.leaveId;
    cubit.unitId = widget.unitId;
    cubit.from = "${widget.type}Entry";
    cubit.subUnitId = widget.subUnitId ?? "";
    cubit.levelName = widget.levelName;
    cubit.personID = widget.personID;

    cubit.entryField = [];
    super.initState();
  }

  // @override
  // void dispose() {
  //   context.read<AddEntryCubit>().disposePage();
  //   super.dispose();
  // }

  formFieldWidget(AddEntryCubit cubit, int i) {
    return Column(
      children: [
        /// Here getting specify dropdown list
        if (DynamicUIHandler.dropdowns
            .contains(cubit.entryField![i].fieldName)) ...[
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
                } else {
                  return [];
                }
              }

              return CustomDropDown(
                selectedValue: FieldHandler.getDropdownSelected(
                    cubit.entryField![i].fieldName ?? "", cubit),
                title: cubit.entryField![i].displayNameForUI ?? "",
                hintText: 'Select ${cubit.entryField![i].displayNameForUI}',
                validator: (dynamic value) {
                  if (cubit.entryField![i].mandatoryField ?? false) {
                    if (value == null) {
                      return 'Please select ${cubit.entryField![i].displayNameForUI ?? ""}';
                    }
                  }
                  return null;
                },
                dropDownList: getDropdownList(
                        cubit.entryField![i].fieldName ?? "", cubit)
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.name ?? '')))
                    .toList(),
                onChange: ((value) {
                  cubit.changeDropdownValue(
                      value, cubit.entryField![i].fieldName ?? "");
                  //  cubit.onChangeDesignationDropDown(value);
                }),
              );
            },
          )
        ]

        /// Here text field  generate logic
        else if (DynamicUIHandler.textfield
            .contains(cubit.entryField![i].fieldName)) ...[
          spaceHeightWidget(20),

          /// Here text field with file picker generate logic
          if (DynamicUIHandler.filePicker
              .contains(cubit.entryField![i].fieldName)) ...[
            if (widget.personData != null) ...[
              for (var item in widget.personData!.entries) ...[
                if (cubit.entryField![i].fieldName == item.key)
                  if (item.value != null || item.value != "") ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFieldWidget(
                            initialValue: item.value.toString(),
                            validator: (value) {
                              if (cubit.entryField![i].mandatoryField ??
                                  false) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter ${cubit.entryField![i].displayNameForUI ?? ""}';
                                }
                              }
                              return null;
                            },
                            onChanged: (value) {
                              FieldHandler.onUpdate(i, value,
                                  cubit.entryField![i].fieldName ?? "", cubit);
                            },
                            title: cubit.entryField![i].displayNameForUI ?? "",
                            keyboardType: TextInputType.text,
                            hintText:
                                'Enter Your ${cubit.entryField![i].displayNameForUI}'),
                        spaceHeightWidget(8),
                        UploadCard(
                          uploadedFilePath: FieldHandler.getFileName(
                                  "${(cubit.entryField![i].formControlName ?? "").split(RegExp(r"[A-Z]"))[0]}_url",
                                  cubit)
                              .split("/")
                              .last,
                          onTap: (() async {
                            await cubit.pickFile(
                                "${(cubit.entryField![i].formControlName ?? "").split(RegExp(r"[A-Z]"))[0]}_url");
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
                      validator: (value) {
                        if (cubit.entryField![i].mandatoryField ?? false) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter ${cubit.entryField![i].displayNameForUI ?? ""}';
                          }
                        }
                        return null;
                      },
                      onChanged: (value) {
                        FieldHandler.onUpdate(i, value,
                            cubit.entryField![i].fieldName ?? "", cubit);
                      },
                      title: cubit.entryField![i].displayNameForUI ?? "",
                      keyboardType: TextInputType.text,
                      hintText:
                          'Enter Your ${cubit.entryField![i].displayNameForUI}'),
                  spaceHeightWidget(8),
                  UploadCard(
                    uploadedFilePath: FieldHandler.getFileName(
                            "${(cubit.entryField![i].formControlName ?? "").split(RegExp(r"[A-Z]"))[0]}_url",
                            cubit)
                        .split("/")
                        .last,
                    onTap: (() async {
                      await cubit.pickFile(
                          "${(cubit.entryField![i].formControlName ?? "").split(RegExp(r"[A-Z]"))[0]}_url");
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
                        validator: (value) {
                          if (cubit.entryField![i].mandatoryField ?? false) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter ${cubit.entryField![i].displayNameForUI ?? ""}';
                            }
                          }
                          return null;
                        },
                        onChanged: (value) {
                          FieldHandler.onUpdate(i, value,
                              cubit.entryField![i].fieldName ?? "", cubit);
                        },
                        title: cubit.entryField![i].displayNameForUI ?? "",
                        keyboardType: TextInputType.text,
                        hintText:
                            'Enter Your ${cubit.entryField![i].displayNameForUI}')
                  ]
              ]
            ] else ...[
              TextFieldWidget(
                  validator: (value) {
                    if (cubit.entryField![i].mandatoryField ?? false) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ${cubit.entryField![i].displayNameForUI ?? ""}';
                      }
                    }
                    return null;
                  },
                  onChanged: (value) {
                    FieldHandler.onUpdate(
                        i, value, cubit.entryField![i].fieldName ?? "", cubit);
                  },
                  title: cubit.entryField![i].displayNameForUI ?? "",
                  keyboardType: TextInputType.text,
                  hintText:
                      'Enter Your ${cubit.entryField![i].displayNameForUI}')
            ]
          ]
        ]

        /// Here radio button
        else if (DynamicUIHandler.radioButton
            .contains(cubit.entryField![i].fieldName)) ...[
          BlocBuilder<AddEntryCubit, AddEntryState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cubit.entryField![i].displayNameForUI ?? "",
                    style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.greyColor),
                  ),
                  CustomRadioButton(
                    title: 'Male',
                    value: 'male',
                    groupValue: cubit.selectRadio ?? "",
                  ),
                  CustomRadioButton(
                    title: 'Female',
                    value: 'female',
                    groupValue: cubit.selectRadio ?? "",
                  ),
                  CustomRadioButton(
                    title: 'Transgender',
                    value: 'transGender',
                    groupValue: cubit.selectRadio ?? "",
                  ),
                ],
              );
            },
          )
        ]

        /// Here calender view
        else if (DynamicUIHandler.calenderView
            .contains(cubit.entryField![i].fieldName)) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceHeightWidget(20),
              Text(cubit.entryField![i].displayNameForUI ?? ""),
              spaceHeightWidget(8),
              BlocBuilder<AddEntryCubit, AddEntryState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Text(
                        cubit.date,
                        style: const TextStyle(
                          color: AppColor.greyColor,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          cubit.selectedDoaDate(context);
                        },
                        child: const Icon(Icons.calendar_month_outlined),
                      )
                    ],
                  );
                },
              ),
              spaceHeightWidget(4),
              const Divider(
                height: 2,
                thickness: 1.5,
                color: AppColor.textBlackColor,
              )
            ],
          )
        ]
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEntryCubit>();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    cubit.qualificationData =
                        state.category.data!.personEducation!;
                    cubit.religionData = state.category.data!.religion!;
                    cubit.professionData =
                        state.category.data!.personProfession!;
                    context.read<AddEntryCubit>().getDesignationDropdown(data: {
                      "type": "Designation",
                      "data_level": widget.leaveId,
                      "country_state_id": widget.countryStateId ??
                          StorageService.userData?.user?.countryStateId,
                      "unit_id": widget.unitId,
                      "sub_unit_id": widget.subUnitId
                    });
                  } else if (state is CastFetchedState) {
                    cubit.castSelected = null;
                    cubit.castData = state.cast.data!;
                  } else if (state is DesignationDropDownSuccessState) {
                    cubit.designationData = [];
                    cubit.designationData = state.designationList.data ?? [];

                    context.read<AddEntryCubit>().getAddEntryFormStructure(
                        levelID: widget.leaveId.toString(),
                        countryId: widget.countryStateId ??
                            StorageService.userData?.user?.countryStateId);
                  } else if (state is GetAddEntryFormStructureSuccessState) {
                    if (state.addEntryFormStructure.dataEntryField == null) {
                      cubit.entryField = null;
                    } else {
                      cubit.entryField =
                          state.addEntryFormStructure.dataEntryField ?? [];
                    }
                    if (widget.personData != null) {
                      cubit.getInitialTextfieldData(widget.personData);
                      cubit.getInitialUserprofileImageData(widget.personData);
                      cubit.getInitialGenderData(widget.personData);
                      cubit
                          .getInitialMultiSelectionFieldData(widget.personData);
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    spaceHeightWidget(14),

                                    /// User profile photo
                                    Center(
                                        child: ImageNotUploaded(
                                      initialUserprofileURL:
                                          cubit.initialUserprofileURL,
                                      onTap: (() {
                                        cubit.requestPermission(
                                            ImageSource.gallery);
                                      }),
                                    )),

                                    spaceHeightWidget(20),

                                    for (int i = 0;
                                        i < cubit.entryField!.length;
                                        i++)

                                      /// Here primary logic
                                      if (cubit.entryField![i].primary ?? false)
                                        formFieldWidget(cubit, i),
                                    spaceHeightWidget(20),

                                    /// Here primary multi check
                                    Wrap(
                                      runSpacing: 5.0,
                                      spacing: 5.0,
                                      children: <Widget>[
                                        for (var item in cubit.entryField!)
                                          if (DynamicUIHandler
                                              .multiSelectionField
                                              .contains(item.formControlName))
                                            if (item.primary ?? false)
                                              IntrinsicWidth(
                                                child: SelectPropertyBox(
                                                  value: cubit.allMultiFieldData
                                                      .any((element) => element
                                                          .values
                                                          .contains(item
                                                              .formControlName)),
                                                  title:
                                                      item.displayNameForUI ??
                                                          "",
                                                  onChanged: (value) {
                                                    cubit.getAllMultiCheckData(
                                                      item.formControlName ??
                                                          "",
                                                      value,
                                                    );
                                                  },
                                                ),
                                              ),
                                      ],
                                    ),
                                    spaceHeightWidget(20),

                                    /// Here Secondary logic
                                    Text(
                                      'Fill Secondary Information',
                                      style: GoogleFonts.quicksand(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    spaceHeightWidget(20),
                                    for (int i = 0;
                                        i < cubit.entryField!.length;
                                        i++)
                                      if (cubit.entryField![i].primary == false)
                                        formFieldWidget(cubit, i),
                                    spaceHeightWidget(20),

                                    /// Here Secondary multi check
                                    Wrap(
                                      runSpacing: 5.0,
                                      spacing: 5.0,
                                      children: <Widget>[
                                        for (var item in cubit.entryField!)
                                          if (DynamicUIHandler
                                              .multiSelectionField
                                              .contains(item.formControlName))
                                            if (item.primary == false)
                                              IntrinsicWidth(
                                                child: SelectPropertyBox(
                                                  value: cubit.allMultiFieldData
                                                      .any((element) => element
                                                          .values
                                                          .contains(item
                                                              .formControlName)),
                                                  title:
                                                      item.displayNameForUI ??
                                                          "",
                                                  onChanged: (value) {
                                                    cubit.getAllMultiCheckData(
                                                      item.formControlName ??
                                                          "",
                                                      value,
                                                    );
                                                  },
                                                ),
                                              ),
                                      ],
                                    ),
                                    spaceHeightWidget(30),
                                    CommonButton(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        final FormState form =
                                            _formKey.currentState!;
                                        if (form.validate()) {
                                          cubit.previewAndSubmitList();
                                          Navigator.pushNamed(context,
                                              RoutePath.addEntryPreviewSubmit);
                                        }
                                      },
                                      padding: const EdgeInsets.all(12),
                                      title: 'Preview & Submit Details',
                                      borderRadius: 10,
                                      style: GoogleFonts.quicksand(
                                          color: AppColor.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    spaceHeightWidget(30),
                                  ],
                                ),
                              ),
                            );
                },
              ),
            )
          ],
        ),
      )),
    );
  }

  CommonButton verifyOtpDialogButton(
      BuildContext context, AddEntryCubit cubit) {
    return CommonButton(
      height: 45,
      onTap: (() {
        Navigator.pop(context);
        cubit.count = 30;
        cubit.startTimer();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: ((context) {
              return BlocBuilder<AddEntryCubit, AddEntryState>(
                builder: (context, state) {
                  return AlertDialog(
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          S.of(context).verifyWithOtp,
                          style: GoogleFonts.quicksand(
                              color: AppColor.greyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        spaceHeightWidget(14),
                        Text(
                          'Enter OTP sent to 9988776655',
                          style: GoogleFonts.quicksand(
                              color: AppColor.greyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        OTPTextField(
                            controller: otpFieldController,
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                            fieldWidth: 25,
                            onCompleted: ((value) {}),
                            style: GoogleFonts.inter(
                                fontSize: 20, fontWeight: FontWeight.w500),
                            onChanged: (value) {}),
                        spaceHeightWidget(26),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: cubit.count == 0 ? (() {}) : null,
                                child: Text(
                                  S.of(context).resend,
                                  style: GoogleFonts.quicksand(
                                      fontSize: 10,
                                      color: AppColor.navyBlue,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w500),
                                )),
                            Text(
                              'OTP in 00:${cubit.count}',
                              style: GoogleFonts.quicksand(
                                  color: AppColor.greyColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        spaceHeightWidget(32),
                        CommonButton(
                          title: S.of(context).verify,
                          height: 45,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          style: GoogleFonts.quicksand(
                              color: AppColor.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  );
                },
              );
            }));
      }),
      title: S.of(context).verifyWithOtp,
      style: GoogleFonts.quicksand(
          color: AppColor.white, fontSize: 16, fontWeight: FontWeight.w700),
    );
  }
}
