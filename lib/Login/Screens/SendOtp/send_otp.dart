import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Login/Screens/SendOtp/textformfield.dart';
import 'package:sangathan/Login/Screens/VerifyOtp/verify_otp.dart';
import 'package:sangathan/Utils/AppBar/appbar.dart';
import 'package:sangathan/Utils/ConnectivityCheck/notConnected.dart';
import 'package:sangathan/Values/Constants.dart';
import '../../../Utils/Buttons/button.dart';
import '../../../Utils/ConnectivityCheck/cubit/connectivity_cubit.dart';
import '../../../Values/app_colors.dart';
import '../../../Values/size_config.dart';

class SendOtpScreen extends StatelessWidget {
  const SendOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        SizeConfig().getCurrentOrientation(context);

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      appBar: APPBar.getAppBar(),
      body: BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) {
          if (state == InternetState.connected) {
            return ListView(
              children: [
                Column(
                  children: [
                    //login text
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Constants.paddingLeft, 14, 0, 0),
                      child: Row(
                        children: [
                          Text("Login",
                              style: GoogleFonts.publicSans(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor().textColor)),
                        ],
                      ),
                    ),

                    //mobile text
                    Padding(
                      padding: const EdgeInsets.fromLTRB(Constants.paddingLeft,
                          96, Constants.paddingRight, 149),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Mobile Number",
                                style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor().textColor)),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: const TextFormFieldLogin(),
                          ),
                        ],
                      ),
                    ),

                    //nextbutton
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Constants.buttonLeft, 0, Constants.buttonRight, 0),
                      child: SizedBox(
                        width: Constants.buttonSizeBoxWidth,
                        height: Constants.buttonSizeBoxHeight,
                        child: BUTTON(onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VerifyOtpScreen()),
                          );
                        }),
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
    );
  }
}
