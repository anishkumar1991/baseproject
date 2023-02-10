import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sangathan/AddEntry/VerifyPerson/cubit/verify_person_cubit.dart';
import 'package:sangathan/AddEntry/VerifyPerson/cubit/verify_person_state.dart';
import 'package:sangathan/AddEntry/VerifyPerson/screen/verify_person_dialog.dart';
import 'package:sangathan/AddEntry/cubit/add_entry_cubit.dart';

import '../../../Dashboard/Screen/homePage/screens/zila_data_page/cubit/zila_data_cubit.dart';
import '../../../Values/app_colors.dart';
import '../../../Values/space_height_widget.dart';
import '../../../common/common_button.dart';
import '../../../common/otp_field_widget.dart';
import '../../../generated/l10n.dart';
import '../../../route/route_path.dart';

class SubmitDialog extends StatelessWidget {
  const SubmitDialog({Key? key, required this.mobileNo, required this.personId})
      : super(key: key);
  final String mobileNo;
  final int personId;
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
              verifyPersonCubit.count = 60;
              if (verifyPersonCubit.timer?.isActive ?? false) {
                verifyPersonCubit.timer?.cancel();
              }
              verifyPersonCubit.startTimer();
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: ((context) {
                    return BlocBuilder<VerifyPersonCubit, VerifyPersonState>(
                      builder: (context, state) {
                        return AlertDialog(
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                S.of(context).verifyWithOtp,
                                style: GoogleFonts.quicksand(
                                    color: AppColor.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              spaceHeightWidget(14),
                              Text(
                                'Enter OTP sent to $mobileNo',
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
                                otpText: verifyPersonCubit.otpText ?? '',
                                fieldWidth: 35,
                                shape: PinCodeFieldShape.underline,
                                onChange: ((p0) {}),
                                onComplete: ((p0) {}),
                              ),
                              spaceHeightWidget(15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: verifyPersonCubit.count == 0
                                          ? (() {
                                              verifyPersonCubit.startTimer();
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
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);

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
                  verifyPersonCubit.sendOTP(personId: personId);
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
                onTap: (() {
                  final cubit = context.read<AddEntryCubit>();
                  context.read<ZilaDataCubit>().getEntryData(data: {
                    "level": cubit.levelId,
                    "unit": cubit.unitId,
                    "level_name": cubit.levelName
                  });
                  Navigator.popUntil(
                      context, ModalRoute.withName(RoutePath.zilaDataPage));
                }),
                title: S.of(context).skipAddNewEntry,
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
