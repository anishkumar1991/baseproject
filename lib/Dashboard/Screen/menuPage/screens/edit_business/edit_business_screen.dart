import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/edit_business/cubit/edit_business_cubit.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/edit_business/widgets/header_widget_edit_business_screen.dart';

import '../../../../../Values/app_colors.dart';
import '../../../../../Values/icons.dart';
import '../../../../../Values/space_height_widget.dart';
import '../../../../../common/appstyle.dart';
import '../../../../../common/common_button.dart';
import '../../../../../common/textfiled_widget.dart';
import '../../../../../generated/l10n.dart';
import '../profile_screen/network/model/user_detail_model.dart';

class EditBusinessScreen extends StatefulWidget {
  int? index;
  List<ProfessionalDetails>? professionalDetails;
   EditBusinessScreen({Key? key,this.index,this.professionalDetails}) : super(key: key);

  @override
  State<EditBusinessScreen> createState() => _EditBusinessScreenState();
}

class _EditBusinessScreenState extends State<EditBusinessScreen> {

  @override
  void initState(){
    fillData();
    super.initState();
  }

  fillData({final cubit}){
    context.read<EditBusinessCubit>().positionCtr.text = widget.professionalDetails?[widget.index!].position ?? '';
    context.read<EditBusinessCubit>().startYearCtr.text = widget.professionalDetails?[widget.index!].startYear ?? '';
    context.read<EditBusinessCubit>().endYearCtr.text = widget.professionalDetails?[widget.index!].endYear ?? '';
    context.read<EditBusinessCubit>().businessNameCtr.text = widget.professionalDetails?[widget.index!].orgName ?? '';
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
                          onChanged: (value) {
                            cubit.emitState();
                          },
                          keyboardType: TextInputType.number,
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
                          onChanged: (value) {
                            cubit.emitState();
                          },
                          keyboardType: TextInputType.number,
                          suffixWidget: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColor.black,
                          ));
                    },
                  ),
                  spaceHeightWidget(MediaQuery.of(context).size.height * 0.12),
                  CommonButton(
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
                  ),
                  spaceHeightWidget(5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: AppColor.dividerColor,
                    ),
                  ),
                  spaceHeightWidget(5),
                  CommonButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: S.of(context).save,
                    width: 150,
                    height: 38,
                    borderRadius: 25,
                    style: textStyleWithPoppin(
                        color: AppColor.white, fontSize: 16),
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
            borderSide: BorderSide.none
          ),
          title:  Text(S.of(context).dialogTitle,style: textStyleWithPoppin(fontSize: 20,color: AppColor.black,fontWeight: FontWeight.w400)),
          content:  Text(S.of(context).dialogSubtitle,style: textStyleWithPoppin(fontSize: 14,color: AppColor.black,fontWeight: FontWeight.w400),),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:  Text((S.of(context).noThanks),
              )),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:  Text(S.of(context).delete),
            ),
          ],
        );
      },
    );
  }

}
