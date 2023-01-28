import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:otp_text_field/otp_text_field.dart';
import 'package:sangathan/AddEntry/cubit/add_entry_cubit.dart';
import 'package:sangathan/AddEntry/cubit/add_entry_state.dart';
import 'package:sangathan/AddEntry/Screen/widget/drop_down_widget.dart';
import 'package:sangathan/AddEntry/Screen/widget/image_not_uploaded_widget.dart';
import 'package:sangathan/AddEntry/Screen/widget/user_image.dart';

import 'package:sangathan/AddEntry/dynamic_ui_handler/dynamic_ui_handler.dart';

import 'package:sangathan/common/textfiled_widget.dart';
import 'package:sangathan/common/common_button.dart';

import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/space_height_widget.dart';

import '../../Values/space_width_widget.dart';
import '../dynamic_ui_handler/field_handler.dart';

class AddEntryPage extends StatefulWidget {
  const AddEntryPage({Key? key, required this.type, required this.leaveId})
      : super(key: key);
  final String type;
  final int leaveId;

  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  OtpFieldController otpFieldController = OtpFieldController();
  @override
  void initState() {
    context.read<AddEntryCubit>().getDropdownData();
    //context.read<AddEntryCubit>().getCastData(id: '1');

    super.initState();
  }

  @override
  void dispose() {
    context.read<AddEntryCubit>().disposePage();
    super.dispose();
  }

  formFieldWidget(AddEntryCubit cubit, int i) {
    return Column(
      children: [
        if (DynamicUIHandler.dropdowns
            .contains(cubit.entryField[i].formControlName)) ...[
          spaceHeightWidget(20),
          BlocBuilder<AddEntryCubit, AddEntryState>(
            builder: (context, state) {
              /// Here getting specify dropdown list
              getDropdownList(String dropdownType, AddEntryCubit cubit) {
                if (dropdownType == "designation") {
                  return cubit.designationData;
                } else if (dropdownType == "category") {
                  return cubit.categoryData;
                } else if (dropdownType == "caste") {
                  return cubit.castData;
                } else if (dropdownType == "qualification") {
                  return cubit.qualificationData;
                } else if (dropdownType == "religion") {
                  return cubit.religionData;
                } else if (dropdownType == "profession") {
                  return cubit.professionData;
                } else {
                  return [];
                }
              }

              return CustomDropDown(
                selectedValue: FieldHandler.getDropdownSelected(
                    cubit.entryField[i].formControlName ?? "", cubit),
                title: cubit.entryField[i].displayNameForUI ?? "",
                hintText: 'Select ${cubit.entryField[i].displayNameForUI}',
                dropDownList: getDropdownList(
                        cubit.entryField[i].formControlName ?? "", cubit)
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.name ?? '')))
                    .toList(),
                onChange: ((value) {
                  cubit.changeDropdownValue(
                      value, cubit.entryField[i].formControlName ?? "");
                  //  cubit.onChangeDesignationDropDown(value);
                }),
              );
            },
          )
        ] else if (DynamicUIHandler.textfield
            .contains(cubit.entryField[i].formControlName)) ...[
          spaceHeightWidget(20),
          TextFieldWidget(
              onChanged: (value) {
                print(cubit.textFieldControllerData);
                FieldHandler.onUpdate(
                    i, value, cubit.entryField[i].fieldName ?? "", cubit);
              },
              title: cubit.entryField[i].displayNameForUI ?? "",
              keyboardType: TextInputType.text,
              hintText: 'Enter Your ${cubit.entryField[i].displayNameForUI}')
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
              child: SingleChildScrollView(
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
                      context
                          .read<AddEntryCubit>()
                          .getDesignationDropdown(data: {
                        "type": "Designation",
                        "data_level": 7,
                        "country_state_id": 3,
                        "unit_id": 25,
                        "sub_unit_id": 58
                      });
                    } else if (state is CastFetchedState) {
                      cubit.castSelected = null;
                      cubit.castData = state.cast.data!;
                    } else if (state is DesignationDropDownSuccessState) {
                      cubit.designationData = [];
                      cubit.designationData = state.designationList.data ?? [];
                      context.read<AddEntryCubit>().getAddEntryFormStructure(
                          levelID: widget.leaveId.toString());
                    } else if (state is GetAddEntryFormStructureSuccessState) {
                      cubit.entryField =
                          state.addEntryFormStructure.dataEntryField ?? [];
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        spaceHeightWidget(14),
                        Center(
                          child: widget.type == 'Zila'
                              ? ImageNotUploaded(
                                  onTap: (() {}),
                                )
                              : UserImageCard(
                                  onTap: (() {}),
                                  imageUrl: AppIcons.addUserImage,
                                ),
                        ),
                        spaceHeightWidget(20),

                        for (int i = 0; i < cubit.entryField.length; i++)
                          if (cubit.entryField[i].primary ?? false)
                            formFieldWidget(cubit, i),
                        spaceHeightWidget(20),
                        Text(
                          'Fill Secondary Information',
                          style: GoogleFonts.quicksand(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        for (int i = 0; i < cubit.entryField.length; i++)
                          if (cubit.entryField[i].primary == false)
                            formFieldWidget(cubit, i),

                        //if(){}
                        /* widget.type == 'Zila'
                            ? BlocBuilder<ZilaDataCubit, ZilaDataState>(
                                builder: (context, state) {
                                  final cubit = context.read<ZilaDataCubit>();
                                  return CustomDropDown(
                                    selectedValue: cubit.selectedFilterData,
                                    title: 'Designation',
                                    hintText: 'Select Designation',
                                    dropDownList: cubit.filterDataList
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.name ?? '')))
                                        .toList(),
                                    onChange: ((value) {
                                      cubit.onChangeDesignationDropDown(value);
                                    }),
                                  );
                                },

                              )
                            : CommonTextField(
                                keyboardType: TextInputType.name,
                                title: 'Name',
                                hintText: 'Enter Your Name',
                                controller: nameController,
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? TextFieldWidget(
                                controller: phoneController,
                                title: 'Mobile No',
                                keyboardType: TextInputType.phone,
                                hintText: 'Enter Your Mobile No')
                            : CommonTextField(
                                title: 'Phone No.',
                                hintText: 'Enter Your Phone Number',
                                keyboardType: TextInputType.phone,
                                controller: phoneController,
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? TextFieldWidget(
                                controller: nameController,
                                title: 'Full Name',
                                hintText: 'Enter Full Name')
                            : CommonTextField(
                                title: 'Designation',
                                hintText: 'Enter Your Designation',
                                controller: designationController,
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? BlocBuilder<AddEntryCubit, AddEntryState>(
                                builder: (context, state) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
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
                            : const SizedBox.shrink(),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? CustomDropDown(
                                selectedValue: cubit.categorySelected,
                                title: 'Category',
                                hintText: 'Select Category',
                                dropDownList: cubit.categoryData
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e.name ?? '')))
                                    .toList(),
                                onChange: ((value) {
                                  cubit.onChangeCategory(value!);
                                  context.read<AddEntryCubit>().getCastData(
                                      id: cubit.categorySelected!.id
                                          .toString());
                                }),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      title: 'DOB',
                                      hintText: 'Enter Your DOB',
                                      keyboardType: TextInputType.datetime,
                                      controller: dobController,
                                    ),
                                  ),
                                  spaceWidthWidget(9),
                                  Expanded(
                                    child: CommonTextField(
                                      title: 'Category',
                                      hintText: 'Enter Category',
                                      controller: categoryController,
                                    ),
                                  ),
                                ],
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? CustomDropDown(
                                selectedValue: cubit.castSelected,
                                title: 'Cast',
                                hintText: 'Select Cast',
                                dropDownList: cubit.castData
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e.name ?? '')))
                                    .toList(),
                                onChange: ((value) {
                                  cubit.onChangeCast(value);
                                }),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      title: 'Caste',
                                      hintText: 'Enter Your Cast',
                                      controller: castController,
                                    ),
                                  ),
                                  spaceWidthWidget(9),
                                  Expanded(
                                    child: CommonTextField(
                                      title: 'Mandal',
                                      hintText: 'Enter Mandal Name',
                                      controller: mandalController,
                                    ),
                                  ),
                                ],
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? CustomDropDown(
                                selectedValue: cubit.qualificationSelected,
                                title: 'Qualification',
                                hintText: 'Select Qualification',
                                dropDownList: cubit.qualificationData
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e.name ?? '')))
                                    .toList(),
                                onChange: ((value) {
                                  cubit.onChangeQualification(value);
                                }),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      title: 'Native State',
                                      hintText: 'Enter Your Native State',
                                      controller: nativeStateController,
                                    ),
                                  ),
                                  spaceWidthWidget(9),
                                  Expanded(
                                    child: CommonTextField(
                                      title: 'Age',
                                      hintText: 'Enter Your Age',
                                      keyboardType: TextInputType.number,
                                      controller: ageController,
                                    ),
                                  ),
                                ],
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? CustomDropDown(
                                selectedValue: cubit.religionSelected,
                                title: 'Religion',
                                hintText: 'Enter Religion',
                                dropDownList: cubit.religionData
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e.name ?? '')))
                                    .toList(),
                                onChange: ((value) {
                                  cubit.onChangeReligion(value);
                                }),
                              )
                            : const SizedBox.shrink(),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? CustomDropDown(
                                selectedValue: cubit.professionSelected,
                                title: 'Profession',
                                hintText: 'Select Profession',
                                dropDownList: cubit.professionData
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e.name ?? '')))
                                    .toList(),
                                onChange: ((value) {
                                  cubit.onChangeProfession(value);
                                }),
                              )
                            : CommonTextField(
                                title: 'Gender',
                                hintText: 'Enter Your Gender',
                                controller: genderController,
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  spaceHeightWidget(5),
                                  const Text('DOB'),
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
                                            child: const Icon(
                                                Icons.calendar_month_outlined),
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
                            : CommonTextField(
                                title: 'Address',
                                hintText: 'Enter Your Address',
                                controller: addressController,
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? TextFieldWidget(
                                controller: pinController,
                                title: 'Pin Code',
                                keyboardType: TextInputType.number,
                                hintText: 'Enter Pin Code')
                            : Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      title: 'Qualification',
                                      hintText: 'Enter Your Qualification',
                                      controller: qualificationController,
                                    ),
                                  ),
                                  spaceWidthWidget(9),
                                  Expanded(
                                    child: CommonTextField(
                                      title: 'Profession',
                                      hintText: 'Enter Your Profession',
                                      controller: professionController,
                                    ),
                                  ),
                                ],
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? Column(
                                children: [
                                  TextFieldWidget(
                                      controller: addressController,
                                      title: 'Adress',
                                      hintText: 'Enter Address'),
                                  spaceHeightWidget(8),
                                  TextFieldWidget(
                                      controller: mandalController,
                                      title: 'Mandal',
                                      hintText: 'Enter Mandal'),
                                  spaceHeightWidget(8),
                                  CustomDropDown(
                                    selectedValue: cubit.nativeStateSelected,
                                    title: 'Native State',
                                    hintText: 'Select State',
                                    dropDownList: cubit.nativeStateData
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.name ?? '')))
                                        .toList(),
                                    onChange: ((value) {
                                      cubit.onChangeNativeState(value);
                                    }),
                                  )
                                ],
                              )
                            : const SizedBox.shrink(),
                        spaceHeightWidget(24),
                        widget.type == 'Zila'
                            ? Text(
                                'Fill Secondary Information',
                                style: GoogleFonts.quicksand(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              )
                            : Text(
                                'Secondary Information',
                                style: GoogleFonts.quicksand(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                        spaceHeightWidget(12),
                        widget.type == 'Zila'
                            ? CustomDropDown(
                                title: 'Relation',
                                hintText: 'Select Relation',
                                // dropDownList: const ['ES', 'DD'],
                              )
                            : CommonTextField(
                                title: 'S/O',
                                hintText: 'Enter Your S/O',
                                controller: soController,
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? TextFieldWidget(
                                controller: fatherNameController,
                                title: 'Father’s / Husband Name',
                                hintText: 'Enter father’s / Husband Name')
                            : CommonTextField(
                                maxLines: 3,
                                title: 'Full Address',
                                hintText: 'Enter Your Full Address',
                                controller: fullAddressController,
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? TextFieldWidget(
                                controller: societyController,
                                title: 'Society',
                                hintText: 'Enter Society')
                            : Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      title: 'Religion',
                                      hintText: 'Enter Your Religion',
                                      controller: religionController,
                                    ),
                                  ),
                                  spaceWidthWidget(9),
                                  Expanded(
                                    child: CommonTextField(
                                      title: 'WhatsApp No.',
                                      hintText: 'Enter Your WhatsApp No.',
                                      keyboardType: TextInputType.phone,
                                      controller: whatsAppNoController,
                                    ),
                                  ),
                                ],
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? TextFieldWidget(
                                controller: houseController,
                                title: 'House No.',
                                hintText: 'Enter House No.')
                            : CommonTextField(
                                title: 'Alternate Phone No.',
                                hintText: 'Enter Your Alternate Phone No.',
                                keyboardType: TextInputType.phone,
                                controller: alternatePhoneNoController,
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? TextFieldWidget(
                                controller: streetController,
                                title: 'Street / Block',
                                hintText: 'Enter House No.')
                            : CommonTextField(
                                title: 'Email ID',
                                hintText: 'Enter Street / Block',
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextFieldWidget(
                                      controller: adharNoController,
                                      title: 'Enter Aadhar No.',
                                      keyboardType: TextInputType.number,
                                      hintText: 'Aadhar No.'),
                                  spaceHeightWidget(8),
                                  UploadCard(
                                    uploadedFilePath: cubit
                                        .adharFilePicked?.path
                                        .split('/')
                                        .last,
                                    onTap: (() {
                                      cubit.pickFile(isAdhar: true);
                                    }),
                                  ),
                                ],
                              )
                            : CommonTextField(
                                title: 'AADHAR No.',
                                hintText: 'Enter Your AADHAR No.',
                                keyboardType: TextInputType.phone,
                                controller: adharNoController,
                                suffixWidget: uploadImage(
                                    isUploaded: true, onTap: (() {})),
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextFieldWidget(
                                    controller: voterIDController,
                                    hintText: 'Enter Voter ID No.',
                                    title: 'Voter ID No.',
                                    keyboardType: TextInputType.number,
                                  ),
                                  spaceHeightWidget(8),
                                  UploadCard(
                                    uploadedFilePath: cubit
                                        .voterFilePicked?.path
                                        .split('/')
                                        .last,
                                    onTap: (() {
                                      cubit.pickFile(isVoter: true);
                                    }),
                                  ),
                                ],
                              )
                            : CommonTextField(
                                title: 'Voter ID',
                                hintText: 'Enter Your Voter ID No.',
                                keyboardType: TextInputType.phone,
                                controller: voterIDController,
                                suffixWidget: uploadImage(onTap: (() {})),
                              ),
                        spaceHeightWidget(8),
                        widget.type == 'Zila'
                            ? BlocBuilder<AddEntryCubit, AddEntryState>(
                                builder: (context, state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextFieldWidget(
                                        controller: rationCardNoController,
                                        hintText: 'Enter Ration Card No.',
                                        title: 'Ration Card No.',
                                        keyboardType: TextInputType.number,
                                      ),
                                      spaceHeightWidget(8),
                                      UploadCard(
                                        uploadedFilePath: cubit
                                            .rationFilePicked?.path
                                            .split('/')
                                            .last,
                                        onTap: (() async {
                                          await cubit.pickFile(isRation: true);
                                        }),
                                      ),
                                    ],
                                  );
                                },
                              )
                            : CommonTextField(
                                title: 'Ration Card No.',
                                hintText: 'Enter Your Ration Card No.',
                                keyboardType: TextInputType.phone,
                                controller: rationCardNoController,
                                suffixWidget: uploadImage(onTap: (() {})),
                              ),
                        spaceHeightWidget(10),
                        widget.type == 'Zila'
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SelectPropertyBox(
                                    value: false,
                                    title: 'Bike',
                                  ),
                                  SelectPropertyBox(
                                    value: false,
                                    title: 'Car',
                                  ),
                                  SelectPropertyBox(
                                    value: false,
                                    title: 'Smartphone',
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SelectPropertyBox(
                                    value: true,
                                    title: 'Bike',
                                  ),
                                  SelectPropertyBox(
                                    value: true,
                                    title: 'Car',
                                  ),
                                  SelectPropertyBox(
                                    value: true,
                                    title: 'Smartphone',
                                  ),
                                ],
                              ),
                        spaceHeightWidget(30),
                        widget.type == 'Zila'
                            ? CommonButton(
                                padding: const EdgeInsets.all(12),
                                title: 'Preview & Submit Details',
                                borderRadius: 10,
                                style: GoogleFonts.quicksand(
                                    color: AppColor.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CommonButton(
                                      onTap: (() {}),
                                      padding: const EdgeInsets.all(12),
                                      title: 'Edit',
                                      borderRadius: 10,
                                      backGroundcolor: AppColor.white,
                                      style: GoogleFonts.quicksand(
                                          color: AppColor
                                              .buttonOrangeBackGroundColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  spaceWidthWidget(30),
                                  Expanded(
                                    child: CommonButton(
                                      onTap: (() {
                                        showDialog(
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
                                            }));
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
                              ),*/

                        spaceHeightWidget(30),
                      ],
                    );
                  },
                ),
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
                          'Verify with OTP',
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
                                  'Resend',
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
                          title: 'Verify',
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
      title: 'Verify with OTP',
      style: GoogleFonts.quicksand(
          color: AppColor.white, fontSize: 16, fontWeight: FontWeight.w700),
    );
  }

  uploadImage({bool isUploaded = false, required GestureTapCallback onTap}) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: GestureDetector(
        onTap: onTap,
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
                isUploaded ? AppIcons.galleryColorImage : AppIcons.galleryImage,
                height: 16,
              ),
              spaceWidthWidget(4),
              Text(
                isUploaded ? 'Adhar Photo-1.JPG' : 'No file uploaded',
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
}
