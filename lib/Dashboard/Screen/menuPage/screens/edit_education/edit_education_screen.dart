import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/edit_education/widgets/header_widget_edit_education_screen.dart';

import '../../../../../AddEntry/network/model/category_model.dart';
import '../../../../../Values/app_colors.dart';
import '../../../../../Values/icons.dart';
import '../../../../../Values/space_height_widget.dart';
import '../../../../../common/appstyle.dart';
import '../../../../../common/common_button.dart';
import '../../../../../common/custom_year_picker.dart';
import '../../../../../common/textfiled_widget.dart';
import '../../../../../generated/l10n.dart';
import '../personal_info/cubit/personal_info_cubit.dart';
import '../profile_screen/cubit/profile_cubit.dart';
import '../profile_screen/network/model/user_detail_model.dart';
import 'cubit/edit_education__cubit.dart';

class EditEducationScreen extends StatefulWidget {
  int? index;
  List<EducationalDetails>? educationalDetails;
  bool? isNew;

  EditEducationScreen({Key? key, this.index, this.educationalDetails,this.isNew = false})
      : super(key: key);

  @override
  State<EditEducationScreen> createState() => _EditEducationScreenState();
}

class _EditEducationScreenState extends State<EditEducationScreen> {

  EducationalDetails educationalDetails = EducationalDetails();

  @override
  void initState() {
    fillData();
    super.initState();
  }

  fillData({final cubit}) {
    if(widget.isNew != true){
      context.read<EditEducationCubit>().levelCtr.text =
          widget.educationalDetails?[widget.index!].level ?? '';
      context.read<EditEducationCubit>().startYearCtr.text =
          widget.educationalDetails?[widget.index!].startYear ?? '';
      context.read<EditEducationCubit>().endYearCtr.text =
          widget.educationalDetails?[widget.index!].endYear ?? '';
      context.read<EditEducationCubit>().collageCtr.text =
          widget.educationalDetails?[widget.index!].institute ?? '';
    }else{
      context.read<EditEducationCubit>().clearData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditEducationCubit>();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            spaceHeightWidget(10),
            headerWidgetEditEducation(context),
            spaceHeightWidget(5),
            Expanded(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  BlocBuilder<EditEducationCubit, EditEducationState>(
                    builder: (context, state) {
                      return TextFieldWidget(
                          controller: cubit.levelCtr,
                          title: '',
                          readOnly: true,
                          labelText: S.of(context).level,
                          onChanged: (value) {
                            cubit.emitState();
                          },
                          keyboardType: TextInputType.emailAddress,
                          onTap: () {
                            _modelBottomSheet(
                                controller: cubit.levelCtr,
                                text: S.of(context).education,
                                context: context,
                                dropDownList:
                                    dropDownValue?.data?.personEducation);
                          },
                          suffixWidget: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColor.black,
                          ));
                    },
                  ),
                  spaceHeightWidget(10),
                  BlocBuilder<EditEducationCubit, EditEducationState>(
                    builder: (context, state) {
                      return TextFieldWidget(
                          controller: cubit.startYearCtr,
                          title: '',
                          readOnly: true,
                          labelText: S.of(context).yearFrom,
                          onChanged: (value) {
                            cubit.emitState();
                          },
                          keyboardType: TextInputType.number,
                          onTap: (){
                            CustomYearPicker.startYearPicker(context: context, cubit: cubit);
                          },
                          suffixWidget: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColor.black,
                          ));
                    },
                  ),
                  spaceHeightWidget(10),
                  BlocBuilder<EditEducationCubit, EditEducationState>(
                    builder: (context, state) {
                      return TextFieldWidget(
                          controller: cubit.endYearCtr,
                          title: '',
                          readOnly: true,
                          labelText: S.of(context).yearTo,
                          onChanged: (value) {
                            cubit.emitState();
                          },
                          keyboardType: TextInputType.number,
                          onTap: (){

                            if(cubit.startYearCtr.text.isEmpty){
                              EasyLoading.showError(S.of(context).somethingWentWrong,duration: const Duration(seconds: 1));
                            }else{
                              CustomYearPicker.endYearPicker(context: context, cubit: cubit);
                            }
                          },
                          suffixWidget: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColor.black,
                          ));
                    },
                  ),
                  spaceHeightWidget(10),
                  BlocBuilder<EditEducationCubit, EditEducationState>(
                    builder: (context, state) {
                      return TextFieldWidget(
                          controller: cubit.collageCtr,
                          title: '',
                          labelText: S.of(context).clgName,
                          onChanged: (value) {
                            cubit.emitState();
                          },
                          keyboardType: TextInputType.emailAddress,
                          suffixWidget: cubit.collageCtr.text.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    cubit.collageCtr.clear();
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
                              : const SizedBox.shrink());
                    },
                  ),
                  spaceHeightWidget(MediaQuery.of(context).size.height * 0.12),
                  widget.isNew != true ? CommonButton(
                    onTap: () {
                      showConfirmDialog();
                    },
                    title: S.of(context).delete,
                    width: 150,
                    height: 20,
                    borderRadius: 25,
                    backGroundcolor: Colors.transparent,
                    bordercolor: Colors.transparent,
                    style: textStyleWithPoppin(
                        color: AppColor.greyColor.withOpacity(0.3),
                        fontSize: 14),
                  ) : SizedBox.shrink(),
                  spaceHeightWidget(5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: AppColor.dividerColor,
                    ),
                  ),
                  spaceHeightWidget(5),
                  BlocListener<PersonalInfoCubit, PersonalInfoState>(
                    listener: (context, state) {
                      if (state is PersonalInfoErrorState) {
                        EasyLoading.dismiss();
                        EasyLoading.showError(state.error);
                      } else if (state is LoadingState) {
                        EasyLoading.show();
                      } else if (state is UpdateDataState) {
                        context.read<ProfileCubit>().getUserDetails();
                        Navigator.pop(context);
                        EasyLoading.dismiss();
                        EasyLoading.showSuccess(S.of(context).educationUpdated,duration: const Duration(milliseconds: 500));
                      }
                    },
                    child:  CommonButton(
                      onTap: () {
                        filledList(cubit: cubit);
                        context.read<PersonalInfoCubit>().updatePersonalDetails(data: {
                          "educational_details" : widget.educationalDetails
                        });
                      },
                      title: S.of(context).save,
                      width: 150,
                      height: 38,
                      borderRadius: 25,
                      style: textStyleWithPoppin(
                          color: AppColor.white, fontSize: 16),
                    ),
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

  Future showConfirmDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(23),
              borderSide: BorderSide.none),
          title: Text(S.of(context).dialogTitle,
              style: textStyleWithPoppin(
                  fontSize: 20,
                  color: AppColor.black,
                  fontWeight: FontWeight.w400)),
          content: Text(
            S.of(context).dialogSubtitle1,
            style: textStyleWithPoppin(
                fontSize: 14,
                color: AppColor.black,
                fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  (S.of(context).noThanks),
                )),
            BlocListener<PersonalInfoCubit, PersonalInfoState>(
              listener: (context, state) {
                if (state is PersonalInfoErrorState) {
                  EasyLoading.dismiss();
                  EasyLoading.showError(state.error);
                } else if (state is LoadingState) {
                  EasyLoading.show();
                } else if (state is UpdateDataState) {
                  context.read<ProfileCubit>().getUserDetails();
                  Navigator.pop(context);
                  EasyLoading.dismiss();
                  EasyLoading.showSuccess(S.of(context).educationDeleted,duration: const Duration(milliseconds: 500));
                }
              },
              child:   TextButton(
                onPressed: (){
                  removeList();
                  context.read<PersonalInfoCubit>().updatePersonalDetails(data: {
                    "educational_details" : widget.educationalDetails
                  });
                },
                child: Text(S.of(context).delete),
              ),
            ),
          ],
        );
      },
    );
  }

  void _modelBottomSheet(
      {required BuildContext context,
      List<DropdownData>? dropDownList,
      required String text,
      required TextEditingController controller}) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        builder: (builder) {
          List<DropdownData>? list = dropDownList;
          return Container(
            color: Colors.transparent,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28.0),
                        topRight: Radius.circular(28.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceHeightWidget(10),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 5,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColor.borderColor),
                        ),
                      ),
                      spaceHeightWidget(30),
                      Text(
                        text ?? '',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: AppColor.borderColor, fontSize: 16),
                      ),
                      spaceHeightWidget(30),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: list?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.text = list?[index].name ?? '';
                                      Navigator.pop(context);
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        list?[index].name ?? '',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                            color: AppColor.black,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  spaceHeightWidget(15),
                                  const Divider(
                                    color: AppColor.borderColor,
                                  ),
                                  spaceHeightWidget(15),
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                )),
          );
        });
  }

  filledList({required EditEducationCubit cubit}){
    if(widget.isNew == true){
      educationalDetails.level = cubit.levelCtr.text;
      educationalDetails.startYear = cubit.startYearCtr.text;
      educationalDetails.endYear = cubit.endYearCtr.text;
      educationalDetails.institute = cubit.collageCtr.text;
      widget.educationalDetails?.add(educationalDetails);
    }else{
      educationalDetails.level = cubit.levelCtr.text;
      educationalDetails.startYear = cubit.startYearCtr.text;
      educationalDetails.endYear = cubit.endYearCtr.text;
      educationalDetails.institute = cubit.collageCtr.text;
      widget.educationalDetails?[widget.index!] = educationalDetails;
    }
  }

  removeList(){
    widget.educationalDetails?.removeAt(widget.index!);
  }

}
