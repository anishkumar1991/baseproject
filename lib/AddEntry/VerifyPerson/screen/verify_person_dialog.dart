import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sangathan/AddEntry/VerifyPerson/cubit/verify_person_cubit.dart';
import 'package:sangathan/AddEntry/VerifyPerson/cubit/verify_person_state.dart';
import 'package:sangathan/AddEntry/cubit/add_entry_cubit.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/common/otp_field_widget.dart';
import 'package:sangathan/generated/l10n.dart';

import '../../../Values/app_colors.dart';
import '../../../common/common_button.dart';

class VerifyPersonDialog extends StatefulWidget {
  const VerifyPersonDialog(
      {Key? key, required this.mobileNo, required this.personId})
      : super(key: key);
  final String mobileNo;
  final int personId;
  @override
  State<VerifyPersonDialog> createState() => _VerifyPersonDialogState();
}

class _VerifyPersonDialogState extends State<VerifyPersonDialog> {
  @override
  void initState() {
    context.read<VerifyPersonCubit>().otpFieldController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final verifyPersonCubit = context.read<VerifyPersonCubit>();
    return BlocListener<VerifyPersonCubit, VerifyPersonState>(
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
                            controller: verifyPersonCubit.otpFieldController,
                            otpText: verifyPersonCubit.otpText ?? '',
                            fieldWidth: 35,
                            shape: PinCodeFieldShape.underline,
                            onChange: ((p0) {}),
                            onComplete: ((p0) {}),
                          ),
                          spaceHeightWidget(20),
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
                                        decoration: TextDecoration.underline,
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
                              // if (cubit.timer?.isActive ?? false) {
                              //   cubit.timer?.cancel();
                              // }
                            },
                            title: S.of(context).verify,
                            height: 45,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
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
      child: CommonButton(
        height: 45,
        onTap: (() async {
          final cubits = BlocProvider.of<AddEntryCubit>(context);

          Navigator.pop(context);
          verifyPersonCubit.sendOTP(personId: cubits.personId ?? 0);
        }),
        title: S.of(context).verifyWithOtp,
        style: GoogleFonts.quicksand(
            color: AppColor.white, fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}
