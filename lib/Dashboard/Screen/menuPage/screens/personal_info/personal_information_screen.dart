import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/personal_info/widgets/header_widget_personal_info_screen.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/Values/space_width_widget.dart';

import '../../../../../AddEntry/network/model/category_model.dart';
import '../../../../../common/appstyle.dart';
import '../../../../../common/common_button.dart';
import '../../../../../common/textfiled_widget.dart';
import '../../../../../generated/l10n.dart';
import '../profile_screen/cubit/profile_cubit.dart';
import '../profile_screen/network/model/user_detail_model.dart';
import 'cubit/personal_info_cubit.dart';

class PersonalInformationScreen extends StatefulWidget {
  UserDetailModel userDetails;

  PersonalInformationScreen({Key? key, required this.userDetails})
      : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  void initState() {
    fillData();
    super.initState();
  }

  dynamic tempId = 0;

  fillData({final cubit}) {
    context.read<PersonalInfoCubit>().nameCtr.text =
        widget.userDetails.data?.name ?? '';
    context.read<PersonalInfoCubit>().userNameCtr.text =
        widget.userDetails.data?.username ?? '';
    context.read<PersonalInfoCubit>().mobileNumberCtr.text =
        widget.userDetails.data?.phoneNumber ?? '';
    context.read<PersonalInfoCubit>().boiCtr.text =
        widget.userDetails.data?.dob ?? '';
    context.read<PersonalInfoCubit>().religionCtr.text =
        widget.userDetails.data?.religion?.name ?? '';
    context.read<PersonalInfoCubit>().statusCtr.text =
        widget.userDetails.data?.category?.name ?? '';
    context.read<PersonalInfoCubit>().castCtr.text =
        widget.userDetails.data?.caste?.name ?? '';
    getGenderRadioButtonValue(widget.userDetails.data?.gender?.toLowerCase());
    context.read<PersonalInfoCubit>().getCasteDropDownValue(
        id: widget.userDetails.data?.category?.id.toString() ?? '0');
  }

  getGenderRadioButtonValue(String? type) {
    if (type == 'male') {
      context.read<PersonalInfoCubit>().value = Gender.male;
    } else if (type == 'female') {
      context.read<PersonalInfoCubit>().value = Gender.female;
    } else {
      context.read<PersonalInfoCubit>().value = Gender.transgender;
    }
  }

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
            BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
              builder: (context, state) {
                return cubit.imageFile == null
                    ? Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColor.greyColor.withOpacity(0.5)),
                            shape: BoxShape.circle),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(350),
                            child: widget.userDetails.data?.avatar != null && widget.userDetails.data?.avatar != '' ? Image.network(
                              widget.userDetails.data?.avatar ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return const Icon(Icons.person, size: 25);
                              },
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ) : Container(
                                color: AppColor.white,
                                height: 84,
                                width: 84,
                                child: Image.asset(AppIcons.sangathanLogo))),
                      )
                    : Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColor.greyColor.withOpacity(0.5)),
                            shape: BoxShape.circle),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(350),
                            child: Image.file(cubit.imageFile!,
                                fit: BoxFit.cover)),
                      );
              },
            ),
            spaceHeightWidget(15),
            GestureDetector(
              onTap: () {
                cubit.selectImage(context: context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppIcons.cameraIcon, height: 20, width: 20),
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
            Expanded(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
                    builder: (context, state) {
                      return TextFieldWidget(
                        controller: cubit.nameCtr,
                        title: '',
                        labelText: S.of(context).fullName,
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
                  BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
                    builder: (context, state) {
                      return TextFieldWidget(
                        controller: cubit.userNameCtr,
                        title: '',
                        labelText: S.of(context).userName,
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
                  BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
                    builder: (context, state) {
                      return TextFieldWidget(
                        controller: cubit.mobileNumberCtr,
                        title: '',
                        labelText: S.of(context).mobileNumber,
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
                  BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          TextFieldWidget(
                              controller: cubit.boiCtr,
                              title: '',
                              readOnly: true,
                              labelText: S.of(context).boi,
                              onChanged: (value) {
                                cubit.emitState();
                              },
                              keyboardType: TextInputType.emailAddress,
                              suffixWidget: InkWell(
                                  onTap: () {
                                    cubit.editBoi(context);
                                  },
                                  child: Image.asset(AppIcons.calenderIcon))),
                          spaceHeightWidget(5),
                         ( widget.userDetails.data?.dob != '' &&  widget.userDetails.data?.dob != null) ? Row(
                            children: [
                              Text(
                                "${S.of(context).age}:",
                                style: textStyleWithPoppin(
                                    fontSize: 11,
                                    color: AppColor.naturalBlackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              spaceWidthWidget(3),
                              Padding(
                                padding: const EdgeInsets.only(top: 1.0),
                                child: Text(
                                  "${daysBetween(from: DateFormat("yyyy-MM-dd").parse(widget.userDetails.data?.dob ?? ""), to: DateTime.now()).toString()} ${S.of(context).years}",
                                  style: textStyleWithPoppin(
                                      fontSize: 10,
                                      color: AppColor.naturalBlackColor,
                                      fontWeight: FontWeight.w200),
                                ),
                              ),
                            ],
                          ) : SizedBox.shrink(),
                        ],
                      );
                    },
                  ),
                  spaceHeightWidget(5),
                  BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
                    builder: (context, state) {
                      return TextFieldWidget(
                          controller: cubit.religionCtr,
                          readOnly: true,
                          title: '',
                          labelText: S.of(context).religion,
                          onChanged: (value) {
                            cubit.emitState();
                          },
                          keyboardType: TextInputType.emailAddress,
                          onTap: () async {
                            await showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                ),
                                builder: (builder) {
                                  return bottom(
                                      context: context,
                                      dropDownList:
                                          dropDownValue?.data?.religion,
                                      text: S.of(context).religion,
                                      id: cubit.religionId ?? 0,
                                      controller: cubit.religionCtr);
                                }).then((value) {
                              cubit.religionId = value;
                            });
                          },
                          suffixWidget: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColor.black,
                          ));
                    },
                  ),
                  spaceHeightWidget(15),
                  BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
                    builder: (context, state) {
                      return TextFieldWidget(
                          controller: cubit.statusCtr,
                          readOnly: true,
                          title: '',
                          labelText: S.of(context).grade,
                          onChanged: (value) {
                            cubit.emitState();
                          },
                          keyboardType: TextInputType.emailAddress,
                          onTap: () async {
                            await showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                ),
                                builder: (builder) {
                                  return bottom(
                                      context: context,
                                      dropDownList:
                                      dropDownValue?.data?.personCategory,
                                      text: S.of(context).category,
                                      id: cubit.gradeId ?? 0,
                                      controller: cubit.statusCtr);
                                }).then((value) {
                              cubit.gradeId = value;
                            });
                          },
                          suffixWidget: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColor.black,
                          ));
                    },
                  ),
                  spaceHeightWidget(15),
                  BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
                    builder: (context, state) {
                      return TextFieldWidget(
                        controller: cubit.castCtr,
                        title: '',
                        labelText: S.of(context).caste,
                        onChanged: (value) {
                          cubit.emitState();
                        },
                        readOnly: true,
                        keyboardType: TextInputType.emailAddress,
                        onTap: () {
                          showCastData(cubit: cubit);
                        },
                        suffixWidget: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColor.black,
                        ),
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
                  BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
                    builder: (context, state) {
                      return buildRadioButton(cubit: cubit);
                    },
                  ),
                  spaceHeightWidget(25),
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
                        EasyLoading.showSuccess("Profile Updated",
                            duration: const Duration(milliseconds: 500));
                      }
                    },
                    child: CommonButton(
                      onTap: () {
                        if (cubit.image != null) {
                          cubit.getNetworkUrlAndUpdateProfile(
                              id: widget.userDetails.data?.id);
                        } else {
                          print(cubit.religionId);
                          print(cubit.castId);
                          print(cubit.gradeId);
                          cubit.updatePersonalDetails(data: {
                            "name": cubit.nameCtr.text,
                            "username": cubit.userNameCtr.text,
                            "phone_number": cubit.mobileNumberCtr.text,
                            "dob": cubit.boiCtr.text,
                            "gender": cubit.value.name,
                            "religion_id": cubit.religionId,
                            "cast_id": cubit.castId,
                            "category_id": cubit.gradeId
                          });
                        }
                      },
                      title: S.of(context).save,
                      width: 150,
                      height: 38,
                      borderRadius: 25,
                      // style: const TextStyle(fontSize: 20, color: AppColor.white),
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

  int daysBetween({required DateTime from, required DateTime to}) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inDays / 365).round();
  }

  buildRadioButton({required PersonalInfoCubit cubit}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
            value: Gender.male,
            activeColor: AppColor.primaryColor,
            groupValue: cubit.value,
            onChanged: (value) {
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
        Radio(
            value: Gender.female,
            activeColor: AppColor.primaryColor,
            groupValue: cubit.value,
            onChanged: (value) {
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
        Radio(
            value: Gender.transgender,
            activeColor: AppColor.primaryColor,
            groupValue: cubit.value,
            onChanged: (value) {
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
  }

  bottom(
      {required BuildContext context,
      List<DropdownData>? dropDownList,
      required String text,
      required int id,
      required TextEditingController controller}) {
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
                  text,
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
                                if (text == S.of(context).category) {
                                  id = list?[index].id ?? 0;
                                  controller.text = list?[index].name ?? '';
                                  context
                                      .read<PersonalInfoCubit>()
                                      .getCasteDropDownValue(id: id.toString());
                                  Navigator.pop(context, id);
                                } else {
                                  id = list?[index].id ?? 0;
                                  controller.text = list?[index].name ?? '';
                                  Navigator.pop(context, id);
                                }
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  list?[index].name ?? '',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      color: AppColor.black, fontSize: 16),
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
  }

  showCastData({required PersonalInfoCubit cubit}) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        builder: (builder) {
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
                        S.of(context).caste,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: AppColor.borderColor, fontSize: 16),
                      ),
                      spaceHeightWidget(30),
                      Expanded(
                        child: cubit.castData?.data != null
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: cubit.castData?.data?.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          cubit.castId =
                                              cubit.castData?.data?[index].id ??
                                                  0;
                                          cubit.castCtr.text = cubit.castData
                                                  ?.data?[index].name ??
                                              '';
                                          Navigator.pop(context);
                                        },
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            cubit.castData?.data?[index].name ??
                                                '',
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
                                })
                            : Center(
                                child: Text(S.of(context).noDataAvailable)),
                      )
                    ],
                  ),
                )),
          );
        });
  }
}
