import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:sangathan/Utils/AppBar/appbar.dart';
import 'package:sangathan/Utils/ConnectivityCheck/notConnected.dart';
import 'package:sangathan/Values/Constants.dart';
import 'package:sangathan/Values/string.dart';
import '../../../Utils/Buttons/button.dart';
import '../../../Utils/ConnectivityCheck/cubit/connectivity_cubit.dart';
import '../../../Values/app_colors.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      appBar: APPBar.getAppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 14),
        child: BlocBuilder<InternetCubit, InternetState>(
          builder: (context, state) {
            if (state == InternetState.connected) {
              return ListView(
                children: [
                  Column(
                    children: [
                      //Verify Details Text
                      Padding(
                        padding: EdgeInsets.only(left: Constants.paddingLeft),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Verify details',
                              style: GoogleFonts.publicSans(
                                  fontSize: 24,
                                  color: AppColor().textColor,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                      //Enter OTP Text
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: Constants.paddingLeft),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Enter OTP sent on 9911882277',
                              style: GoogleFonts.quicksand(
                                  fontSize: 12,
                                  color: AppColor().textColor,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),

                      //OTP Text Field
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 141,
                            left: Constants.paddingLeft,
                            right: Constants.paddingRight),
                        child: OTPTextField(
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                            fieldWidth: 40,
                            onChanged: (value) {}),
                      ),

                      //Seconds counter
                      Padding(
                        padding:
                            EdgeInsets.only(top: 37, left: 146, right: 144),
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              Strings.resendotptimer,
                              style: GoogleFonts.quicksand(
                                  fontSize: 12,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),

                      //OTP failure and resend otp
                      Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //didn't send otp text
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 83, right: 10),
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Didn’t recieve OTP ?',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 12,
                                        color: AppColor().textColor,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),

                            //resend otp
                            Padding(
                              padding: const EdgeInsets.only(right: 82),
                              child: Container(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        textStyle: GoogleFonts.quicksand(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  Strings.resendotpsnackbar)));
                                    },
                                    child: Text('Resend OTP'),
                                  )),
                            )
                          ],
                        ),
                      ),

                      //next button
                      Padding(
                        padding: EdgeInsets.only(top: 25, left: 81, right: 81),
                        child: SizedBox(
                          width: Constants.buttonSizeBoxWidth,
                          height: Constants.buttonSizeBoxHeight,
                          child: BUTTON(onPress: () {}),

                          // ),
                        ),
                      ),
                    ],
                  ),
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
}
