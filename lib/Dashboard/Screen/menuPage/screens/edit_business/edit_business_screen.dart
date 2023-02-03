import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/edit_business/cubit/edit_business_cubit.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/edit_business/widgets/header_widget_edit_business_screen.dart';

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

class EditBusinessScreen extends StatefulWidget {
  int? index;
  List<ProfessionalDetails>? professionalDetails;
  bool? isNew;
  EditBusinessScreen({Key? key,this.index,this.professionalDetails,this.isNew = false}) : super(key: key);

  @override
  State<EditBusinessScreen> createState() => _EditBusinessScreenState();
}

class _EditBusinessScreenState extends State<EditBusinessScreen> {

  ProfessionalDetails professionalDetails = ProfessionalDetails();

  @override
  void initState(){
    fillData();
    super.initState();
  }

  fillData({final cubit}){
    if(widget.isNew != true){
      context.read<EditBusinessCubit>().positionCtr.text = widget.professionalDetails?[widget.index!].position ?? '';
      context.read<EditBusinessCubit>().startYearCtr.text = widget.professionalDetails?[widget.index!].startYear ?? '';
      context.read<EditBusinessCubit>().endYearCtr.text = widget.professionalDetails?[widget.index!].endYear ?? '';
      context.read<EditBusinessCubit>().businessNameCtr.text = widget.professionalDetails?[widget.index!].orgName ?? '';
    }else{
      context.read<EditBusinessCubit>().clearData();
    }
  }
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditBusinessCubit>();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            spaceHeightWidget(10),
            headerWidgetEditBusiness(context),
            spaceHeightWidget(5),
            Expanded(child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  BlocBuilder<EditBusinessCubit, EditBusinessState>(
                    builder: (context, state) {
                      return TextFieldWidget(
                          controller: cubit.businessNameCtr,
                          title: '',
                          labelText: S.of(context).organization,
                          onChanged: (value) {
                            cubit.emitState();
                          },
                          keyboardType: TextInputType.emailAddress,
                          suffixWidget: cubit.businessNameCtr.text.isNotEmpty
                              ? InkWell(
                            onTap: () {
                              cubit.businessNameCtr.clear();
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
                  spaceHeightWidget(10),
                  BlocBuilder<EditBusinessCubit, EditBusinessState>(
                    builder: (context, state) {
                      return TextFieldWidget(
                          controller: cubit.positionCtr,
                          title: '',
                          labelText: S.of(context).position,
                          onChanged: (value) {
                            cubit.emitState();
                          },
                          keyboardType: TextInputType.emailAddress,
                          suffixWidget: cubit.businessNameCtr.text.isNotEmpty
                              ? InkWell(
                            onTap: () {
                              cubit.businessNameCtr.clear();
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
                  spaceHeightWidget(10),
                  BlocBuilder<EditBusinessCubit, EditBusinessState>(
                    builder: (context, state) {
                      return TextFieldWidget(
                          controller: cubit.startYearCtr,
                          title: '',
                          labelText: S.of(context).yearFrom,
                          readOnly: true,
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
                  BlocBuilder<EditBusinessCubit, EditBusinessState>(
                    builder: (context, state) {
                      return TextFieldWidget(
                          controller: cubit.endYearCtr,
                          title: '',
                          labelText: S.of(context).yearTo,
                          readOnly: true,
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
                        EasyLoading.showSuccess(S.of(context).businessUpdated,duration: const Duration(milliseconds: 500));
                      }
                    },
                    child:  CommonButton(
                      onTap: () {

                        if (cubit.checkIfEmpty()) {
                          EasyLoading.showError(S.of(context).pleaseEnterData,
                              duration: const Duration(milliseconds: 500));
                        } else {
                          filledList(cubit: cubit);
                          context.read<PersonalInfoCubit>().updatePersonalDetails(data: {
                            "professional_details" : widget.professionalDetails
                          });
                        }
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

  filledList({required EditBusinessCubit cubit}){

    if(widget.isNew == true){
      professionalDetails.orgName = cubit.businessNameCtr.text;
      professionalDetails.startYear = cubit.startYearCtr.text;
      professionalDetails.endYear = cubit.endYearCtr.text;
      professionalDetails.position = cubit.positionCtr.text;
      widget.professionalDetails?.add(professionalDetails);;
    }else{
      professionalDetails.orgName = cubit.businessNameCtr.text;
      professionalDetails.startYear = cubit.startYearCtr.text;
      professionalDetails.endYear = cubit.endYearCtr.text;
      professionalDetails.position = cubit.positionCtr.text;
      widget.professionalDetails?[widget.index!] = professionalDetails;
    }
  }

  removeList(){
    widget.professionalDetails?.removeAt(widget.index!);
  }

  Future showConfirmDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(23),
              borderSide: BorderSide.none
          ),
          title:  Text(S.of(context).dialogTitle,style: textStyleWithPoppin(fontSize: 20,color: AppColor.black,fontWeight: FontWeight.w400)),
          content:  Text(S.of(context).dialogSubtitle,style: textStyleWithPoppin(fontSize: 14,color: AppColor.black,fontWeight: FontWeight.w400),),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context),
                child:  Text((S.of(context).noThanks),
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
                  EasyLoading.showSuccess(S.of(context).businessDeleted,duration: const Duration(milliseconds: 500));
                }
              },
              child: TextButton(
                onPressed: (){
                  removeList();
                  context.read<PersonalInfoCubit>().updatePersonalDetails(data: {
                    "professional_details" : widget.professionalDetails
                  });
                },
                child:  Text(S.of(context).delete),
              ),
            ),

          ],
        );
      },
    );
  }

}
