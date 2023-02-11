import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Login/Cubit/login_cubit.dart';
import 'package:sangathan/Login/Cubit/login_state.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/Values/space_width_widget.dart';

import '../../../Utils/ConnectivityCheck/cubit/connectivity_cubit.dart';
import '../../../Utils/ConnectivityCheck/not_connected.dart';
import '../../../Values/app_colors.dart';
import '../../../Values/icons.dart';
import '../../../common/common_button.dart';
import '../../../common/otp_field_widget.dart';
import '../../../generated/l10n.dart';
import '../../../route/route_path.dart';
import '../../../splash_screen/cubit/user_profile_cubit.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({Key? key, required this.number}) : super(key: key);
  final String number;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  //OtpFieldController otpFieldController = OtpFieldController();
  TextEditingController otpFieldController = TextEditingController();
  String otpText = '';
  String? errorText;
  bool isLoading = false;

  @override
  void initState() {
    final cubit = context.read<LoginCubit>();
    cubit.count = 60;

    if (cubit.timer?.isActive ?? false) {
      cubit.timer?.cancel();
    }

    context.read<LoginCubit>().startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<InternetCubit, InternetState>(
          builder: (context, state) {
            if (state == InternetState.connected) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceHeightWidget(10),
                  Row(
                    children: [
                      spaceWidthWidget(6),
                      IconButton(
                        onPressed: (() {
                          Navigator.pop(context);
                        }),
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 28,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.13,
                      ),
                      Text(
                        S.of(context).otpVerification,
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                AppIcons.loginImage,
                                height: 200,
                              )),
                          spaceHeightWidget(10),

                          Text(
                            S.of(context).enterOTP,
                            style: GoogleFonts.poppins(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${S.of(context).digitCodeHasBeenSent}\n+91 ${widget.number}',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.greyColor),
                          ),
                          spaceHeightWidget(20),

                          ///OTP Text Field
                          CustomOtpTextField(
                            controller: otpFieldController,
                            onChange: ((value) {
                              otpText = value;
                              print('onChange=$otpText');
                            }),
                            onComplete: ((v) {
                              otpText = v;
                              print('onComplete=$otpText');
                            }),
                          ),

                          spaceHeightWidget(20),

                          /// SUBMIT OTP BUTTON
                          submitOtpButtom(),
                          spaceHeightWidget(20),

                          /// RESEND OTP BUTTON
                          reSendOtpButton(cubit),
                        ],
                      ),
                    ),
                  ))
                ],
              );
            } else {
              return const NotConnected();
            }
          },
        ),
      ),
    );
  }

  Widget submitOtpButtom() {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is UserLoginSuccessfullyState) {
          Navigator.pushReplacementNamed(context, RoutePath.dashBoardScreen);
        } else if (state is LoginFaieldState) {
          errorText = state.error;
          isLoading = false;
        } else if (state is SubmitOtpLoadingState) {
          isLoading = true;
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            errorText != null
                ? Text(
                    errorText!,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.redColor),
                  )
                : const SizedBox.shrink(),
            spaceHeightWidget(20),
            CommonButton(
              onTap: (() async {
                if (otpText.isNotEmpty && otpText.length >= 6) {
                  await context.read<LoginCubit>().submitOTP(otp: otpText);
                  Future.delayed(Duration.zero).then((value) async {
                    await context.read<UserProfileCubit>().getUserProfileData();
                  });
                } else {
                  EasyLoading.showError('Please Enter OTP');
                }
              }),
              isUseWidget: true,
              borderRadius: 10,
              padding: const EdgeInsets.all(10),
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? const SpinKitFadingCircle(
                          color: AppColor.white,
                          size: 27,
                        )
                      : const SizedBox.shrink(),
                  spaceWidthWidget(5),
                  Text(
                    isLoading ? S.of(context).verified : S.of(context).verify,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget reSendOtpButton(LoginCubit cubit) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        return Center(
          child: cubit.count == 0
              ? InkWell(
                  onTap: (() async {
                    await context.read<LoginCubit>().resendOTP();
                  }),
                  child: Text(S.of(context).resendOTP,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColor.buttonOrangeBackGroundColor)),
                )
              : Text(
                  Localizations.localeOf(context).toString() == "hi"
                      ? '${S.of(context).resendOTPCodeTo} ${cubit.count}'
                      : '${cubit.count} ${S.of(context).resendOTPCodeTo}',
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColor.buttonOrangeBackGroundColor)),
        );
      },
      listener: ((context, state) {
        if (state is OtpResendSuccessfullyState) {
          EasyLoading.showSuccess(state.model.message ?? '');
        }
      }),
    );
  }
}
