import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sangathan/AddEntry/VerifyPerson/cubit/verify_person_cubit.dart';
import 'package:sangathan/AddEntry/VerifyPerson/cubit/verify_person_state.dart';

import '../../../Dashboard/Screen/homePage/screens/zila_data_page/cubit/zila_data_cubit.dart';
import '../../../Values/app_colors.dart';
import '../../../Values/space_height_widget.dart';
import '../../../common/common_button.dart';
import '../../../common/otp_field_widget.dart';
import '../../../generated/l10n.dart';
import '../../../route/route_path.dart';

class SubmitDialog extends StatefulWidget {
   SubmitDialog(
      {Key? key,
      required this.mobileNo,
      required this.personId,
      this.levelId,
      this.levelName,
      this.unitId,
      this.isEdit = false,
     required this.subUnitId,
      required this.onTapSkip})
      : super(key: key);
  final String mobileNo;
  final int personId;
  final GestureTapCallback onTapSkip;
  final int? levelId;
  final int? unitId;
  final int? levelName;
  final bool isEdit;
   String subUnitId = "";
  @override
  State<SubmitDialog> createState() => _SubmitDialogState();
}

class _SubmitDialogState extends State<SubmitDialog> {
  @override
  void initState() {
    context.read<VerifyPersonCubit>().otpFieldController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final verifyPersonCubit = context.read<VerifyPersonCubit>();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocListener<VerifyPersonCubit, VerifyPersonState>(
          listener: (context, state) {
            if (state is SendOTPErrorState) {
              EasyLoading.showError(state.error);
            }

            if (state is SendOTPSuccessful) {
              EasyLoading.showSuccess(state.message);
              Navigator.pop(context);

              verifyPersonCubit.count = 60;
              if (verifyPersonCubit.timer?.isActive ?? false) {
                verifyPersonCubit.timer?.cancel();
              }
              verifyPersonCubit.startTimer();
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: ((context) {
                    return BlocConsumer<VerifyPersonCubit, VerifyPersonState>(
                      listener: ((context, state) {
                        if (state is ResendOTPErrorState) {
                          EasyLoading.showError(state.message);
                        }
                        if (state is VeifyOTPErrorState) {
                          EasyLoading.showError(state.message);
                        }
                        if (state is ResendOTPSuccessState) {
                          EasyLoading.showSuccess(state.message);
                          verifyPersonCubit.count = 60;
                          verifyPersonCubit.startTimer();
                        }
                        if (state is VeifyOTPSuccessState) {
                          EasyLoading.showSuccess(state.message);
                          if (widget.isEdit) {
                            Navigator.pop(context);
                            BlocProvider.of<ZilaDataCubit>(context,
                                    listen: false)
                                .getEntryData(data: {
                              "level": widget.levelId,
                              "sub_unit": widget.subUnitId,
                              "unit": widget.unitId,
                              "level_name": widget.levelName
                            });
                          } else {
                            Navigator.pop(context);
                            BlocProvider.of<ZilaDataCubit>(context,
                                    listen: false)
                                .getEntryData(data: {
                              "level": widget.levelId,
                              "unit": widget.unitId,
                              "sub_unit": widget.subUnitId,
                              "level_name": widget.levelName
                            });
                            Navigator.popUntil(context,
                                ModalRoute.withName(RoutePath.zilaDataPage));
                          }
                        }
                      }),
                      builder: (context, state) {
                        return AlertDialog(
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    alignment: Alignment.topRight,
                                    onPressed: (() {
                                      if (widget.isEdit) {
                                        Navigator.pop(context);
                                      } else {
                                        Navigator.pop(context);
                                        BlocProvider.of<ZilaDataCubit>(context,
                                                listen: false)
                                            .getEntryData(data: {
                                          "level": widget.levelId,
                                          "unit": widget.unitId,
                                          "sub_unit": widget.subUnitId,
                                          "level_name": widget.levelName
                                        });
                                        Navigator.popUntil(
                                            context,
                                            ModalRoute.withName(
                                                RoutePath.zilaDataPage));
                                      }
                                    }),
                                    icon: const Icon(Icons.close)),
                              ),
                              Text(
                                S.of(context).verifyWithOtp,
                                style: GoogleFonts.quicksand(
                                    color: AppColor.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              spaceHeightWidget(14),
                              Text(
                                'Enter OTP sent to ${widget.mobileNo}',
                                style: GoogleFonts.quicksand(
                                    color: AppColor.greyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              spaceHeightWidget(14),
                              CustomOtpTextField(
                                activeFillColor: AppColor.white,
                                inactiveFillColor: AppColor.white,
                                selectedFillColor: AppColor.white,
                                controller:
                                    verifyPersonCubit.otpFieldController,
                                fieldWidth: 35,
                                shape: PinCodeFieldShape.underline,
                                onChange: ((value) {
                                  verifyPersonCubit.otpText = value;
                                  print(' otp=${verifyPersonCubit.otpText}');
                                }),
                                onComplete: ((v) {
                                  verifyPersonCubit.otpText = v;
                                  print(
                                      'complete otp=${verifyPersonCubit.otpText}');
                                }),
                              ),
                              spaceHeightWidget(15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: verifyPersonCubit.count == 0
                                          ? (() async {
                                              print(
                                                  'prsonId=${widget.personId}');
                                              await verifyPersonCubit.reSendOTP(
                                                  personId: widget.personId);
                                            })
                                          : null,
                                      child: Text(
                                        S.of(context).resend,
                                        style: GoogleFonts.quicksand(
                                            fontSize: 12,
                                            color: AppColor.navyBlue,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Text(
                                    'OTP in 00:${verifyPersonCubit.count}',
                                    style: GoogleFonts.quicksand(
                                        color: AppColor.greyColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              spaceHeightWidget(32),
                              CommonButton(
                                onTap: () async {
                                  // Navigator.pop(context);
                                  // Navigator.pop(context);
                                  print('Otp Tap Verify');
                                  if (verifyPersonCubit.otpText.isNotEmpty &&
                                      verifyPersonCubit.otpText.length >= 6) {
                                    await verifyPersonCubit.verifyOTP(
                                        personId: widget.personId,
                                        otp: verifyPersonCubit.otpText);
                                  } else {
                                    EasyLoading.showError(
                                        S.of(context).enterOTP);
                                  }
                                  // if (cubit.timer?.isActive ?? false) {
                                  //   cubit.timer?.cancel();
                                  // }
                                },
                                title: S.of(context).verify,
                                height: 45,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 40),
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
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonButton(
                height: 45,
                onTap: (() async {
                  // final cubits = BlocProvider.of<AddEntryCubit>(context);

                  //Navigator.pop(context);
                  verifyPersonCubit.sendOTP(personId: widget.personId);
                }),
                title: S.of(context).verifyWithOtp,
                style: GoogleFonts.quicksand(
                    color: AppColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              spaceHeightWidget(15),
              CommonButton(
                backGroundcolor: AppColor.white,
                height: 45,
                onTap: widget.onTapSkip,
                // (() {
                //   // context.read<AddEntryCubit>();
                //   final cubit =
                //       BlocProvider.of<AddEntryCubit>(context, listen: false);
                //   BlocProvider.of<ZilaDataCubit>(context, listen: false)
                //       .getEntryData(data: {
                //     "level": cubit.levelId,
                //     "unit": cubit.unitId,
                //     "level_name": cubit.levelName
                //   });
                //   Navigator.popUntil(
                //       context, ModalRoute.withName(RoutePath.zilaDataPage));
                // }),
                title: widget.isEdit
                    ? S.of(context).later
                    : S.of(context).skipAddNewEntry,
                style: GoogleFonts.quicksand(
                    color: AppColor.buttonOrangeBackGroundColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
