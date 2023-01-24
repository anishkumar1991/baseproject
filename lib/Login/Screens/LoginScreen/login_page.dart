import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Login/Cubit/login_cubit.dart';
import 'package:sangathan/Login/Cubit/login_state.dart';
import 'package:sangathan/Login/Network/model/login_model.dart';
import 'package:sangathan/Login/Screens/LoginScreen/textformfield.dart';
import 'package:sangathan/Utils/ConnectivityCheck/notConnected.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/common/common_button.dart';
import 'package:sangathan/route/route_path.dart';

import '../../../Utils/ConnectivityCheck/cubit/connectivity_cubit.dart';
import '../../../generated/l10n.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController mobileNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        height: 30,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            AppIcons.loginImage,
                            height: 200,
                          )),
                      const SizedBox(
                        height: 33,
                      ),
                      Text(
                        S.of(context).login,
                        style: GoogleFonts.poppins(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        S.of(context).enterYourMobileNumber,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.greyColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: TextFormFieldLogin(
                          controller: mobileNumController,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      BlocListener<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is UserLoggedState) {
                            LoginModel loginModel = state.model;
                            EasyLoading.showSuccess(loginModel.message ?? '');
                            Navigator.pushNamed(
                                context, RoutePath.verifyOtpScreen,
                                arguments: mobileNumController.text);
                          } else if (state is LoginLoadingState) {
                            EasyLoading.show();
                          } else if (state is LoginFaieldState) {
                            EasyLoading.showError(state.error);
                          }
                        },
                        child: CommonButton(
                          onTap: (() async {
                            await context.read<LoginCubit>().loginUser(
                                  mobileNumber: mobileNumController.text,
                                );
                            // Navigator.pushNamed(
                            //     context, RoutePath.verifyOtpScreen,
                            //     arguments: mobileNumController.text);
                          }),
                          padding: const EdgeInsets.all(12),
                          title: S.of(context).loginButtonText,
                          style: GoogleFonts.poppins(
                              color: AppColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: NotConnected());
              }
            },
          ),
        ),
      ),
    );
  }
}
