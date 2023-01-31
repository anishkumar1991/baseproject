import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/personal_info/widgets/header_widget_personal_info_screen.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/Values/space_width_widget.dart';

import '../../../../../common/appstyle.dart';
import '../../../../../common/common_button.dart';
import '../../../../../common/textfiled_widget.dart';
import '../../../../../generated/l10n.dart';
import 'cubit/personal_info_cubit.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PersonalInfoCubit>();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            spaceHeightWidget(5),
            headerWidgetPersonalInfo(context),
            spaceHeightWidget(15),
            BlocBuilder<PersonalInfoCubit,
                PersonalInfoState>(
              builder: (context, state) {
                return cubit.imageFile == null
                    ? Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      border:Border.all(color: AppColor.greyColor.withOpacity(0.5)),
                      shape: BoxShape.circle
                  ),
                  child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(350),
                      child: Image.asset(
                          AppIcons.userLogo,
                          fit: BoxFit.cover)),
                )
                    : InkWell(
                  onTap: () {},
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border:Border.all(color: AppColor.greyColor.withOpacity(0.5)),
                        shape: BoxShape.circle
                    ),
                    child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(350),
                        child: Image.file(
                            cubit.imageFile!,
                            fit: BoxFit.cover)),
                  ),
                );
              },
            ),
            spaceHeightWidget(15),
            GestureDetector(
              onTap: (){
                cubit.selectImage();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppIcons.cameraIcon,height: 20,width: 20),
                  spaceWidthWidget(5),
                  Text(
                    "Update",
                    style: textStyleWithPoppin(
                        fontSize: 14,
                        color: AppColor.orange,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            spaceHeightWidget(15),
            Expanded(child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  BlocBuilder<PersonalInfoCubit,
                      PersonalInfoState>(
                    builder: (context, state) {
                      return   TextFieldWidget(
                        controller: cubit.nameCtr,
                        title: '',
                        labelText:  S.of(context).fullName,
                        onChanged: (value) {
                          cubit.emitState();
                        },
                        keyboardType: TextInputType.emailAddress,
                        suffixWidget: cubit.nameCtr.text.isNotEmpty
                            ? InkWell(
                          onTap: () {
                            cubit.nameCtr.clear();
                            cubit.emitState();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 15, right: 15),
                            child: Image.asset(
                              AppIcons.clearIcon,
                              height: 2,
                              width: 5,
                            ),
                          ),
                        )
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                  spaceHeightWidget(15),
                  BlocBuilder<PersonalInfoCubit,
                      PersonalInfoState>(
                    builder: (context, state) {
                      return   TextFieldWidget(
                        controller: cubit.userNameCtr,
                        title: '',
                        labelText:  S.of(context).userName,
                        onChanged: (value) {
                          cubit.emitState();
                        },
                        keyboardType: TextInputType.emailAddress,
                        suffixWidget: cubit.userNameCtr.text.isNotEmpty
                            ? InkWell(
                          onTap: () {
                            cubit.userNameCtr.clear();
                            cubit.emitState();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 15, right: 15),
                            child: Image.asset(
                              AppIcons.clearIcon,
                              height: 2,
                              width: 5,
                            ),
                          ),
                        )
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                  spaceHeightWidget(15),
                  BlocBuilder<PersonalInfoCubit,
                      PersonalInfoState>(
                    builder: (context, state) {
                      return   TextFieldWidget(
                        controller: cubit.mobileNumberCtr,
                        title: '',
                        labelText:  S.of(context).mobileNumber,
                        onChanged: (value) {
                          cubit.emitState();
                        },
                        keyboardType: TextInputType.number,
                        suffixWidget: cubit.mobileNumberCtr.text.isNotEmpty
                            ? InkWell(
                          onTap: () {
                            cubit.mobileNumberCtr.clear();
                            cubit.emitState();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 15, right: 15),
                            child: Image.asset(
                              AppIcons.clearIcon,
                              height: 2,
                              width: 5,
                            ),
                          ),
                        )
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                  spaceHeightWidget(15),
                  BlocBuilder<PersonalInfoCubit,
                      PersonalInfoState>(
                    builder: (context, state) {
                      return   TextFieldWidget(
                        controller: cubit.boiCtr,
                        title: '',
                        readOnly: true,
                        labelText:  S.of(context).boi,
                        onChanged: (value) {
                          cubit.emitState();
                        },
                        keyboardType: TextInputType.emailAddress,
                        suffixWidget: InkWell(
                            onTap: (){
                              cubit.editBoi(context);
                            },
                            child: Image.asset(AppIcons.calenderIcon))
                      );
                    },
                  ),
                  spaceHeightWidget(5),
                  Row(
                    children: [
                      Text(
                        "Age :",
                        style: textStyleWithPoppin(
                            fontSize: 11,
                            color: AppColor.naturalBlackColor,
                            fontWeight: FontWeight.w500),
                      ),
                      spaceWidthWidget(8),
                      Text(
                        "32 Years",
                        style: textStyleWithPoppin(
                            fontSize: 10,
                            color: AppColor.naturalBlackColor,
                            fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                  spaceHeightWidget(5),
                  BlocBuilder<PersonalInfoCubit,
                      PersonalInfoState>(
                    builder: (context, state) {
                      return   TextFieldWidget(
                        controller: cubit.religionCtr,
                        readOnly: true,
                        title: '',
                        labelText:  S.of(context).religion,
                        onChanged: (value) {
                          cubit.emitState();
                        },
                        keyboardType: TextInputType.emailAddress,
                          onTap: (){},
                        suffixWidget: const Icon(Icons.keyboard_arrow_down_rounded,color: AppColor.black,)
                      );
                    },
                  ),
                  spaceHeightWidget(15),
                  BlocBuilder<PersonalInfoCubit,
                      PersonalInfoState>(
                    builder: (context, state) {
                      return   TextFieldWidget(
                        controller: cubit.statusCtr,
                        readOnly: true,
                        title: '',
                        labelText:  S.of(context).grade,
                        onChanged: (value) {
                          cubit.emitState();
                        },
                        keyboardType: TextInputType.emailAddress,
                          onTap: (){},
                        suffixWidget: const Icon(Icons.keyboard_arrow_down_rounded,color: AppColor.black,)
                      );
                    },
                  ),
                  spaceHeightWidget(15),
                  BlocBuilder<PersonalInfoCubit,
                      PersonalInfoState>(
                    builder: (context, state) {
                      return   TextFieldWidget(
                        controller: cubit.castCtr,
                        title: '',
                        labelText:  S.of(context).caste,
                        onChanged: (value) {
                          cubit.emitState();
                        },
                        keyboardType: TextInputType.emailAddress,
                        suffixWidget: cubit.castCtr.text.isNotEmpty
                            ? InkWell(
                          onTap: () {
                            cubit.castCtr.clear();
                            cubit.emitState();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 15, right: 15),
                            child: Image.asset(
                              AppIcons.clearIcon,
                              height: 2,
                              width: 5,
                            ),
                          ),
                        )
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                  spaceHeightWidget(15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Gender",
                      style: textStyleWithPoppin(
                          fontSize: 14,
                          color: AppColor.black.withOpacity(0.8),
                          fontWeight: FontWeight.w500),
                    ),
                  ),

                  BlocBuilder<PersonalInfoCubit,
                      PersonalInfoState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(value: Gender.male,
                              activeColor: AppColor.primaryColor,groupValue: cubit.value, onChanged: (value){
                            cubit.changeValue(value!);
                          }),
                          Text(
                            "Male",
                            style: textStyleWithPoppin(
                                fontSize: 14,
                                color: AppColor.naturalBlackColor,
                                fontWeight: FontWeight.w500),
                          ),
                          spaceWidthWidget(3),
                          Radio(value: Gender.female,
                              activeColor: AppColor.primaryColor,
                              groupValue: cubit.value, onChanged: (value){
                            cubit.changeValue(value!);
                          }),
                          Text(
                            "Female",
                            style: textStyleWithPoppin(
                                fontSize: 14,
                                color: AppColor.naturalBlackColor,
                                fontWeight: FontWeight.w500),
                          ),
                          spaceWidthWidget(3),
                          Radio(value: Gender.transgender,
                              activeColor: AppColor.primaryColor,groupValue: cubit.value, onChanged: (value){
                            cubit.changeValue(value!);
                          }),
                          Text(
                            "Transgender",
                            style: textStyleWithPoppin(
                                fontSize: 14,
                                color: AppColor.naturalBlackColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      );
                    },
                  ),
                  spaceHeightWidget(25),
                  CommonButton(
                    onTap: () {
                     Navigator.pop(context);
                    },
                    title: S.of(context).save,
                    width: 150,
                    height: 38,
                    borderRadius: 25,
                    // style: const TextStyle(fontSize: 20, color: AppColor.white),
                    style: textStyleWithPoppin(color: AppColor.white, fontSize: 16),
                  ),
                  spaceHeightWidget(15),
                ],
              ),
            ))

          ],
        ),
      ),
    );
  }
}
