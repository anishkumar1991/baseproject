import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/create_function_page/widgets/header_widget_create_function.dart';
import 'package:sangathan/Values/app_colors.dart';

import 'package:sangathan/Values/space_width_widget.dart';
import 'package:sangathan/Values/icons.dart';

import '../../../../../Values/space_height_widget.dart';
import '../../../../../common/common_button.dart';
import '../../../../../common/textfiled_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../route/route_path.dart';
import 'create_function_cubit/create_function_cubit.dart';
import 'data/fake_data_list.dart';

class CreateFunctionScreen extends StatefulWidget {
  bool? isEdit;
  bool? isView;

  CreateFunctionScreen({Key? key, this.isEdit = false, this.isView = false})
      : super(key: key);

  @override
  State<CreateFunctionScreen> createState() => _CreateFunctionScreenState();
}

class _CreateFunctionScreenState extends State<CreateFunctionScreen> {

  void initState(){
    context.read<CreateFunctionCubit>().emitState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateFunctionCubit>();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            spaceHeightWidget(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: headerWidgetCreateFunction(context),
            ),
            spaceHeightWidget(MediaQuery.of(context).size.height * 0.02),
            Expanded(child: SingleChildScrollView(
              child: BlocBuilder<CreateFunctionCubit, CreateFunctionState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            TextFieldWidget(
                                controller: cubit.functionNameText,
                                title: '',
                                labelText: S.of(context).functionName,
                                onChanged: (value) {
                                  cubit.emitState();
                                },
                                keyboardType: TextInputType.emailAddress,
                                suffixWidget:
                                    cubit.functionNameText.text.isNotEmpty
                                        ? InkWell(
                                            onTap: () {
                                              cubit.functionNameText.clear();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16.0,
                                                  left: 15,
                                                  right: 15),
                                              child: Image.asset(
                                                AppIcons.clearIcon,
                                                height: 2,
                                                width: 5,
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink()),
                            spaceHeightWidget(
                                MediaQuery.of(context).size.height * 0.02),
                            TextFieldWidget(
                              controller: cubit.functionDateTimeText,
                              onChanged: (value) {
                                cubit.emitState();
                              },
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutePath.pravasEditTimeScreen);
                              },
                              readOnly: true,
                              suffixWidget:
                                  cubit.functionDateTimeText.text.isNotEmpty
                                      ? InkWell(
                                          onTap: () {
                                            cubit.functionDateTimeText.clear();
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
                              title: '',
                              hintText: S.of(context).dateAndTime,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            spaceHeightWidget(
                                MediaQuery.of(context).size.height * 0.02),
                            BlocBuilder<CreateFunctionCubit,
                                CreateFunctionState>(
                              builder: (context, state) {
                                return TextFieldWidget(
                                  controller: cubit.functionTypeText,
                                  title: '',
                                  hintText: S.of(context).functionType,
                                  readOnly: true,
                                  onTap: () {
                                    _modalBottomSheetMenuForFunctionType(
                                        context);
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  suffixWidget: SizedBox(
                                    width: 60,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          Icons.info_outline_rounded,
                                          color: AppColor.blue,
                                          size: 22,
                                        ),
                                        spaceWidthWidget(8),
                                        const Icon(
                                            Icons.keyboard_arrow_down_rounded)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            spaceHeightWidget(
                                MediaQuery.of(context).size.height * 0.02),
                            TextFieldWidget(
                              controller: cubit.functionLevelText,
                              title: '',
                              hintText: S.of(context).functionLayer,
                              readOnly: true,
                              onTap: () {
                                _modalBottomSheetMenuForFunctionLevel(context);
                              },
                              keyboardType: TextInputType.emailAddress,
                              suffixWidget:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                            ),
                            spaceHeightWidget(
                                MediaQuery.of(context).size.height * 0.02),
                            TextFieldWidget(
                              controller: cubit.lokSabhaText,
                              title: '',
                              hintText: S.of(context).lokSabha,
                              readOnly: true,
                              keyboardType: TextInputType.emailAddress,
                              suffixWidget:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                            ),
                            spaceHeightWidget(
                                MediaQuery.of(context).size.height * 0.02),
                            BlocBuilder<CreateFunctionCubit,
                                CreateFunctionState>(
                              builder: (context, state) {
                                return TextFieldWidget(
                                  controller: cubit.placeText,
                                  title: '',
                                  readOnly: true,
                                  onTap: () {
                                    _modalBottomSheetMenuForPlace(context,
                                        selectedValue: cubit.placeText.text);
                                  },
                                  hintText: S.of(context).functionAdd,
                                  keyboardType: TextInputType.emailAddress,
                                  suffixWidget: const Icon(
                                      Icons.info_outline_rounded,
                                      color: AppColor.blue),
                                );
                              },
                            ),
                            spaceHeightWidget(
                                MediaQuery.of(context).size.height * 0.02),
                            TextFieldWidget(
                              controller: cubit.subjectText,
                              title: '',
                              labelText: S.of(context).subject,
                              onChanged: (value) {
                                cubit.emitState();
                              },
                              keyboardType: TextInputType.emailAddress,
                              suffixWidget: cubit.subjectText.text.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        cubit.subjectText.clear();
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
                            ),
                            spaceHeightWidget(
                                MediaQuery.of(context).size.height * 0.02),
                          ],
                        ),
                      ),
                      spaceHeightWidget(
                          MediaQuery.of(context).size.height * 0.04),
                      Container(
                        color: AppColor.lightGreenColor,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              S.of(context).addGuestDetail,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: AppColor.naturalBlackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            spaceHeightWidget(19),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutePath.guestListScreen);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    S.of(context).addOptional,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        color: AppColor.blue, fontSize: 14),
                                  ),
                                  spaceWidthWidget(5),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: AppColor.blue,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      spaceHeightWidget(
                          MediaQuery.of(context).size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldWidget(
                              controller: cubit.commentText,
                              maxLines: 5,
                              onChanged: (value) {
                                cubit.emitState();
                              },
                              suffixWidget: cubit.commentText.text.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        cubit.commentText.clear();
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
                              title: '',
                              labelText: S.of(context).comment,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            spaceHeightWidget(
                                MediaQuery.of(context).size.height * 0.05),
                            Text(
                              S.of(context).photoMax,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: AppColor.naturalBlackColor,
                                  fontSize: 12),
                            ),
                            spaceHeightWidget(
                                MediaQuery.of(context).size.height * 0.01),
                            BlocBuilder<CreateFunctionCubit,
                                CreateFunctionState>(
                              builder: (context, state) {
                                return InkWell(
                                    onTap: () {
                                      cubit.selectImage1();
                                    },
                                    child: cubit.imageFile1 == null
                                        ? DottedBorder(
                                            color: AppColor.blue,
                                            strokeWidth: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.image,
                                                      color: AppColor.blue),
                                                  spaceWidthWidget(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05),
                                                  Text(
                                                    S.of(context).uploadPhoto,
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                        color: AppColor.blue,
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {},
                                            child: SizedBox(
                                              height: 100,
                                              width: 130,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.file(
                                                      cubit.imageFile1!,
                                                      fit: BoxFit.cover)),
                                            ),
                                          ));
                              },
                            ),
                            spaceHeightWidget(
                                MediaQuery.of(context).size.height * 0.02),
                            BlocBuilder<CreateFunctionCubit,
                                CreateFunctionState>(
                              builder: (context, state) {
                                return InkWell(
                                    onTap: () {
                                      cubit.selectImage2();
                                    },
                                    child: cubit.imageFile2 == null
                                        ? DottedBorder(
                                            color: AppColor.blue,
                                            strokeWidth: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.image,
                                                      color: AppColor.blue),
                                                  spaceWidthWidget(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05),
                                                  Text(
                                                    S.of(context).uploadPhoto,
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                        color: AppColor.blue,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {},
                                            child: SizedBox(
                                              height: 100,
                                              width: 130,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.file(
                                                      cubit.imageFile2!,
                                                      fit: BoxFit.cover)),
                                            ),
                                          ));
                              },
                            ),
                            spaceHeightWidget(
                                MediaQuery.of(context).size.height * 0.07),
                            BlocListener<CreateFunctionCubit,
                                CreateFunctionState>(listener: (context,state){
                              if (state is CreateFunctionLoadingState) {
                                EasyLoading.show();
                              } else if (state is CreateFunctionFatchDataState) {
                                cubit.createPravasAndFunctionModel = state.data!;
                                EasyLoading.dismiss();
                                EasyLoading.showSuccess(state.data?.message ?? '');
                              } else if (state is CreateFunctionErrorState) {
                                EasyLoading.dismiss();
                                EasyLoading.showToast(state.error ?? '');
                              }
                            },
                              child: widget.isEdit == true || widget.isView == true
                                  ? const SizedBox.shrink()
                                  : CommonButton(
                                onTap: () {

                                  /// for now,user token is static


                                  cubit.FunctionCreate(data: {
                                    "pravas_id": "3",
                                    "name": "ckjdshvhcs",
                                    "date": "02/02/2023",
                                    "agenda": "myagends",
                                    "is_add_attendees": true,
                                    "chief_guest": "home minister",
                                    "attendees": 20,
                                    "address": "ascascac",
                                    "remark": "ascasc",
                                    "photo_1":
                                    "https://firebasestorage.googleapis.com/v0/b/sangathan-b272e.appspot.com/o/sangathan%2F1666003951%2Fcontent%3A%2Fmedia%2Fexternal%2Fimages%2Fmedia%2F1000031240?alt=media&token=3408acaf-a591-499a-9280-ccc9f10c7d86",
                                    "photo_2":
                                    "https://firebasestorage.googleapis.com/v0/b/sangathan-b272e.appspot.com/o/sangathan%2F1666003951%2Fcontent%3A%2Fmedia%2Fexternal%2Fimages%2Fmedia%2F1000031240?alt=media&token=3408acaf-a591-499a-9280-ccc9f10c7d86"
                                  });
                                  // Navigator.pushReplacementNamed(context,
                                  //     RoutePath.stayAndProgramListScreen);
                                },
                                title: S.of(context).save,
                                height: 50,
                                borderRadius: 7,
                                style: const TextStyle(
                                    fontSize: 20, color: AppColor.white),
                              ),
                            ),

                            spaceHeightWidget(
                                MediaQuery.of(context).size.height * 0.02),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  void _modalBottomSheetMenuForFunctionType(BuildContext context) {
    final cubit = context.read<CreateFunctionCubit>();
    showModalBottomSheet(
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
                        S.of(context).typeOfFunction,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: AppColor.borderColor, fontSize: 16),
                      ),
                      spaceHeightWidget(50),
                      Expanded(
                        child: ListView.builder(
                          itemCount: functionTypeList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    cubit.setFunctionType(
                                        typeName: functionTypeList[index]);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    functionTypeList[index],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        color: AppColor.black, fontSize: 16),
                                  ),
                                ),
                                spaceHeightWidget(15),
                                const Divider(
                                  color: AppColor.borderColor,
                                ),
                                spaceHeightWidget(15),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
  }

  void _modalBottomSheetMenuForFunctionLevel(BuildContext context) {
    final cubit = context.read<CreateFunctionCubit>();
    showModalBottomSheet(
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
                        S.of(context).selectPravasLevel,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: AppColor.borderColor, fontSize: 16),
                      ),
                      spaceHeightWidget(50),
                      Expanded(
                        child: ListView.builder(
                          itemCount: functionLevelList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    cubit.setFunctionLevel(
                                        typeName: functionLevelList[index]);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    functionLevelList[index],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        color: AppColor.black, fontSize: 16),
                                  ),
                                ),
                                spaceHeightWidget(15),
                                const Divider(
                                  color: AppColor.borderColor,
                                ),
                                spaceHeightWidget(15),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
  }

  void _modalBottomSheetMenuForPlace(BuildContext context,
      {required String selectedValue}) {
    final cubit = context.read<CreateFunctionCubit>();
    List selectedPlace = [];
    if (selectedValue.isNotEmpty) {
      selectedPlace = selectedValue.split(',');
    }
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, private) {
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
                            S.of(context).selectLoksabha,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: AppColor.borderColor, fontSize: 16),
                          ),
                          spaceHeightWidget(30),
                          Expanded(
                            child: ListView.builder(
                              itemCount: functionPlaceList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (selectedPlace.contains(
                                            functionPlaceList[index])) {
                                          selectedPlace
                                              .remove(functionPlaceList[index]);
                                        } else {
                                          selectedPlace
                                              .add(functionPlaceList[index]);
                                        }

                                        private(() {});
                                      },
                                      child: Row(
                                        children: [
                                          selectedPlace.contains(
                                                  functionPlaceList[index])
                                              ? const Icon(
                                                  Icons.check_box_outlined,
                                                )
                                              : const Icon(
                                                  Icons.check_box_outline_blank,
                                                ),
                                          const SizedBox(width: 16),
                                          Text(
                                            functionPlaceList[index],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                color: AppColor.black,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    spaceHeightWidget(25),
                                  ],
                                );
                              },
                            ),
                          ),
                          spaceHeightWidget(50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color:
                                          AppColor.buttonOrangeBackGroundColor,
                                      fontSize: 14),
                                ),
                              ),
                              spaceWidthWidget(30),
                              CommonButton(
                                title: 'Done',
                                onTap: () {
                                  cubit.setFunctionPlace(
                                      selectedPlace: selectedPlace);
                                  Navigator.pop(context);
                                },
                                height: 50,
                                width: 100,
                                borderRadius: 25,
                                style: GoogleFonts.poppins(
                                    color: AppColor.white, fontSize: 14),
                              )
                            ],
                          ),
                          spaceHeightWidget(15),
                        ],
                      ),
                    )),
              );
            },
          );
        });
  }
}
