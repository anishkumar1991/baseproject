import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/pravas_module/pravas_create/widgets/header_widget_pravas_create.dart';
import 'package:sangathan/Values/icons.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../Values/space_height_widget.dart';
import '../../../../../../common/common_button.dart';
import '../../../../../../common/textfiled_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../route/route_path.dart';
import 'cubit/pravas_create_cubit.dart';

class PrvasCreateScreen extends StatefulWidget {
  const PrvasCreateScreen({Key? key}) : super(key: key);

  @override
  State<PrvasCreateScreen> createState() => _PrvasCreateScreenState();
}

class _PrvasCreateScreenState extends State<PrvasCreateScreen> {

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PravasCreateCubit>(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            spaceHeightWidget(10),
            headerWidgetPravasCreate(context),
            spaceHeightWidget(MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: BlocBuilder<PravasCreateCubit,PravasCreateState>(
                  builder: (context,state){
                    if(state is CreatePravasLoadingState){
                      EasyLoading.show();
                    }else if(state is CreatePravasFatchDataState){
                      cubit.createPravasModel = state.data!;
                      EasyLoading.showSuccess(state.data?.message ?? '');
                    }else if(state is CreatePravasErrorState){
                      EasyLoading.showToast(state.error ?? '');
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldWidget(
                          controller: cubit.prvasNameCtr,
                          title: '',
                          labelText: S.of(context).nameOfTour,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        spaceHeightWidget(35),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<PravasCreateCubit, PravasCreateState>(
                              builder: (context, state) {
                                if(state is StartDateOfTour){
                                  cubit.startDate = state.date;
                                }
                                return Row(
                                  children: [
                                    Text(
                                      cubit.startDate != ""
                                          ? cubit.startDate
                                          : S.of(context).dateToFrom,
                                      style: const TextStyle(
                                        color: AppColor.greyColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                        onTap: () async {
                                          print("hello");
                                          cubit.pravasStartDate(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(AppIcons.datePickerIcon),
                                          ),
                                        )
                                    )
                                  ],
                                );
                              },
                            ),
                            spaceHeightWidget(4),
                            Divider(
                              height: 2,
                              thickness: 1.5,
                              color: AppColor.greyColor.withOpacity(0.5),
                            )
                          ],
                        ),
                        spaceHeightWidget(35),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<PravasCreateCubit, PravasCreateState>(
                              builder: (context, state) {
                                if(state is EndDateOfTour){
                                  cubit.endDate = state.date;
                                }
                                return Row(
                                  children: [
                                    Text(
                                      cubit.startDate != ""
                                          ? cubit.endDate
                                          : S.of(context).dateTo,
                                      style: const TextStyle(
                                        color: AppColor.greyColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                        onTap: () async {
                                          print("hello");
                                          if(cubit.startDate == ''){
                                            EasyLoading.showToast(S.of(context).pravasStartDate,toastPosition: EasyLoadingToastPosition.top);
                                          }else{
                                            cubit.pravasEndDate(context);
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(AppIcons.datePickerIcon),
                                          ),
                                        )
                                    )
                                  ],
                                );
                              },
                            ),
                            spaceHeightWidget(4),
                            Divider(
                              height: 2,
                              thickness: 1.5,
                              color: AppColor.greyColor.withOpacity(0.5),
                            )
                          ],
                        ),
                        spaceHeightWidget(5),
                        TextFieldWidget(
                          controller: cubit.pravasSubjectCtr,
                          title: '',
                          labelText: S.of(context).descriptionOfTour,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        spaceHeightWidget(MediaQuery.of(context).size.height * 0.08),
                        CommonButton(
                          onTap: () async {

                            /// for now,user token is static

                            if(cubit.prvasNameCtr.text.isEmpty){
                              EasyLoading.showToast(S.of(context).pravasName,toastPosition: EasyLoadingToastPosition.top);
                            }else if(cubit.startDate == ''){
                              EasyLoading.showToast(S.of(context).pravasStartDate,toastPosition: EasyLoadingToastPosition.top);
                            }else if(cubit.endDate == ''){
                              EasyLoading.showToast(S.of(context).pravasEndDate,toastPosition: EasyLoadingToastPosition.top);
                            }else if(cubit.pravasSubjectCtr.text.isEmpty){
                              EasyLoading.showToast(S.of(context).pravasSubject,toastPosition: EasyLoadingToastPosition.top);
                            }else{
                              await cubit.PravasCreate().whenComplete(() => {
                                if(cubit.statusCode == 200){
                                  showConfirmDialog()
                                }
                              });
                            }
                          },
                          title: S.of(context).takeATour,
                          borderRadius: 10,
                          height: 50,
                          style: const TextStyle(fontSize: 15, color: AppColor.white),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future showConfirmDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.transparent)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonButton(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                        context, RoutePath.createFunctionScreen,
                    arguments: {
                          'isEdit' : false,
                          'isView' : false
                    });
                  },
                  title: S.of(context).makeTourSchedules,
                  borderRadius: 20,
                  height: 45,
                  style: const TextStyle(fontSize: 14, color: AppColor.white),
                ),
                spaceHeightWidget(20),
                CommonButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: S.of(context).later,
                  borderRadius: 20,
                  height: 45,
                  backGroundcolor: Colors.transparent,
                  bordercolor: AppColor.buttonOrangeBackGroundColor,
                  style: const TextStyle(
                      fontSize: 14,
                      color: AppColor.buttonOrangeBackGroundColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}