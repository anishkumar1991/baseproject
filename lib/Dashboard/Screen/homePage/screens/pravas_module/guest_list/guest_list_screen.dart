import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/pravas_module/guest_list/widgets/header_widget_guest_list.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/pravas_module/guest_list/widgets/shimmer.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../Values/space_height_widget.dart';
import '../../../../../../Values/space_width_widget.dart';
import '../../../../../../common/appstyle.dart';
import '../../../../../../common/common_button.dart';
import '../../../../../../common/textfiled_widget.dart';
import '../../../../../../generated/l10n.dart';
import 'cubit/guest_cubit.dart';

class GuestListScreen extends StatefulWidget {
  const GuestListScreen({Key? key}) : super(key: key);

  @override
  State<GuestListScreen> createState() => _GuestListScreenState();
}

class _GuestListScreenState extends State<GuestListScreen> {
  apiCall() async {
    await context.read<GuestCubit>().GetGuestList();
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<GuestCubit>(context);
    return Scaffold(
      body: BlocBuilder<GuestCubit, GuestState>(
        builder: (context, state) {
          /// create guest state
          if (state is CreateGuestLoadingState) {
            EasyLoading.show();
          } else if (state is CreateGuestFatchDataState) {
            cubit.createPravasAndFunctionModel = state.data!;
            EasyLoading.dismiss();
            EasyLoading.showSuccess(state.data?.message ?? '');
            cubit.phoneNumber.clear();
            cubit.position.clear();
            cubit.nameCtr.clear();
            context.read<GuestCubit>().GetGuestList();
          } else if (state is CreateGuestErrorState) {
            EasyLoading.showToast(state.error ?? '');
          }

          /// get guest list state
          else if (state is GetGuestLoadingState) {
            return const ShimmerList();
          } else if (state is GetGuestFatchDataState) {
            cubit.guestList = state.data!;
          } else if (state is GetGuestErrorState) {
            EasyLoading.showToast(state.error ?? '');
          }

          ///edit attendees
          else if(state is EditAttendeesLoadingState){
            cubit.isEdit = !cubit.isEdit;
          }else if(state is UpdateGuestLoadingState){
            EasyLoading.show();
          }else if(state is UpdateGuestFatchDataState){
            EasyLoading.showSuccess(state.data?.message ?? '');
            cubit.isEdit = false;
            cubit.GetGuestList();
          }else if(state is UpdateGuestErrorState){
            EasyLoading.showToast(state.error ?? '');
          }
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                spaceHeightWidget(10),
                headerWidgetGuestList(context,cubit.isEdit),
                spaceHeightWidget(MediaQuery.of(context).size.height * 0.02),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldWidget(
                        controller: cubit.nameCtr,
                        title: '',
                        labelText: S.of(context).name,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFieldWidget(
                        controller: cubit.phoneNumber,
                        title: '',
                        labelText: S.of(context).phoneNumber,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFieldWidget(
                        controller: cubit.position,
                        title: '',
                        labelText: S.of(context).position,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      spaceHeightWidget(30),
                      CommonButton(
                        onTap: () {
                          if(cubit.isEdit){
                            cubit.GuestUpdate(data: {
                              "karyakram_id":"1",
                              "attendee_id": cubit.attendeesIdForEdit,
                              "name": cubit.nameCtr.text,
                              "phone": cubit.phoneNumber.text,
                              "designation": cubit.position.text
                            });
                          }else{
                            cubit.GuestCreate(data: {
                              "karyakram_id": "11",
                              "name": cubit.nameCtr.text,
                              "phone": cubit.phoneNumber.text,
                              "designation": cubit.position.text
                            });
                          }
                        },
                        title: cubit.isEdit == true ? S.of(context).edit : S.of(context).add,
                        height: 50,
                        borderRadius: 7,
                        style: const TextStyle(
                            fontSize: 20, color: AppColor.white),
                      ),
                      spaceHeightWidget(20),
                      !cubit.isEdit
                          ? Expanded(
                            child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.guestList.data?.length,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: AppColor.greyWithOpacity01,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.blue
                                                  .withOpacity(0.2)),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColor.white,
                                        ),
                                        child: Center(
                                            child: Text("${index + 1}.")),
                                      ),
                                      spaceWidthWidget(10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: RichText(
                                              text: TextSpan(
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: cubit.guestList
                                                          .data?[index].name,
                                                      style:
                                                          textStyleWithPoppin(
                                                              color: AppColor
                                                                  .black,
                                                              fontSize: 14)),
                                                  const TextSpan(text: '  '),
                                                  TextSpan(
                                                    text:
                                                        '( ${cubit.guestList.data?[index].designation} )',
                                                    style: textStyleWithPoppin(
                                                        color:
                                                            AppColor.greyColor,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          spaceHeightWidget(5),
                                          Text(
                                            cubit.guestList.data?[index].phone
                                                    .toString() ??
                                                '',
                                            style: textStyleWithPoppin(
                                                color: AppColor.greyColor,
                                                fontSize: 10),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          cubit.editGuest(
                                              attendeesId: cubit
                                                  .guestList.data?[index].iId,
                                              phone: cubit
                                                  .guestList.data?[index].phone,
                                              designation: cubit.guestList
                                                  .data?[index].designation,
                                              name: cubit
                                                  .guestList.data?[index].name);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: AppColor.blue
                                                  .withOpacity(0.15)),
                                          height: 40,
                                          width: 40,
                                          child: const Icon(
                                            Icons.edit_outlined,
                                            color: AppColor.blue,
                                            size: 22,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
