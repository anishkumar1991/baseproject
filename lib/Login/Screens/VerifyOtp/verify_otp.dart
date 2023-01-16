import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sangathan/Login/Cubit/login_cubit.dart';
import 'package:sangathan/Login/Cubit/login_state.dart';
import 'package:sangathan/Login/Screens/SendOtp/common_button.dart';
import 'package:sangathan/Utils/ConnectivityCheck/notConnected.dart';
import 'package:sangathan/Values/Constants.dart';
import 'package:sangathan/Values/icons.dart';
import '../../../Utils/ConnectivityCheck/cubit/connectivity_cubit.dart';
import '../../../Values/app_colors.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({Key? key,required this.number}) : super(key: key);
  final String number;
  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  @override
  void initState() {
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
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
                            width: MediaQuery.of(context).size.width * 0.15,
                          ),
                          Text(
                            'ओटीपी सत्यापन',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            AppIcons.loginImage,
                            height: 200,
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'ओटीपी दर्ज करें',
                        style: GoogleFonts.poppins(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'एक 4 अंकों का कोड भेजा गया है\n+91 ${widget.number}',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.greyColor),
                      ),

                      //OTP Text Field
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 40,
                            left: Constants.paddingLeft,
                            right: Constants.paddingRight),
                        child: OTPTextField(
                            fieldStyle: FieldStyle.box,
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                            fieldWidth: 40,
                            style: GoogleFonts.inter(
                                fontSize: 25, fontWeight: FontWeight.w500),
                            onChanged: (value) {}),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CommonButton(
                        borderRadius: 10,
                        padding: const EdgeInsets.all(10),
                        title: 'सत्यापित करना',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return Center(
                            child: cubit.count == 0
                                ? InkWell(
                                    onTap: (() {}),
                                    child: Text('ओटीपी पुनः भेजें',
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor
                                                .buttonOrangeBackGroundColor)),
                                  )
                                : Text(
                                    '${cubit.count} में ओटीपी कोड दोबारा भेजें',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor
                                            .buttonOrangeBackGroundColor)),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const NotConnected();
            }
          },
        ),
      ),
    );
  }
}
