import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Login/Screens/SendOtp/common_button.dart';
import 'package:sangathan/Login/Screens/SendOtp/textformfield.dart';
import 'package:sangathan/Utils/ConnectivityCheck/notConnected.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import '../../../Utils/ConnectivityCheck/cubit/connectivity_cubit.dart';
import '../../../Values/size_config.dart';

class SendOtpScreen extends StatelessWidget {
  const SendOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().getCurrentOrientation(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<InternetCubit, InternetState>(
            builder: (context, state) {
              if (state == InternetState.connected) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Image.asset(AppIcons.loginImage,
                              height: 259, width: 262)),
                      const SizedBox(
                        height: 33,
                      ),
                      Text(
                        'लॉगिन करे',
                        style: GoogleFonts.poppins(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 33,
                      ),
                      Text(
                        'अपना मोबाइल नंबर दर्ज करें, हम आपको बाद में सत्यापित करने के लिए ओटीपी भेजेंगे',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.greyColor),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: TextFormFieldLogin(),
                      ),
                     const SizedBox(
                        height: 40,
                      ),
                      CommonButton(
                        title: 'लॉगिन',
                        style: GoogleFonts.poppins(
                            color: AppColor.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              } else {
                return const NotConnected();
              }
            },
          ),
        ),
      ),
    );
  }
}
