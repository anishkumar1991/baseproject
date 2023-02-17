import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Values/app_colors.dart';
import '../../../common/common_button.dart';
import '../../../common/textfiled_widget.dart';
import '../../../generated/l10n.dart';
import '../../../route/route_path.dart';
import '../../Cubit/login_cubit.dart';
import '../../Cubit/login_state.dart';

class OnboardingDialogWidget extends StatefulWidget {
  const OnboardingDialogWidget({Key? key}) : super(key: key);

  @override
  State<OnboardingDialogWidget> createState() => _OnboardingDialogWidgetState();
}

class _OnboardingDialogWidgetState extends State<OnboardingDialogWidget> {
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Form(
              key: _formKey,
              child: TextFieldWidget(
                title: "",
                labelText: S.of(context).name,
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${S.of(context).please} ${S.of(context).name} ${S.of(context).enter}';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is UserOnboardingSuccessState) {
                  if (state.onboardingModel.success ?? false) {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutePath.dashBoardScreen,
                        (Route<dynamic> route) => false);
                  }
                }
              },
              builder: (context, state) {
                if (state is UserOnboardingLoadingState) {
                  return const SpinKitFadingCircle(
                    color: AppColor.primaryColor,
                    size: 27,
                  );
                }
                if (state is UserOnboardingErrorState) {
                  return Text(
                    S.of(context).oopsErrorMsg,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColor.black),
                  );
                }
                return CommonButton(
                  onTap: (() {
                    FocusScope.of(context).unfocus();
                    final FormState form = _formKey.currentState!;
                    if (form.validate()) {
                      Map<String, dynamic> passedData = {
                        "location_type": "CountryState",
                        "location_ids": [14],
                        "name": nameController.text
                      };
                      context.read<LoginCubit>().getProgramLevel(passedData);
                    }
                  }),
                  isUseWidget: true,
                  borderRadius: 10,
                  padding: const EdgeInsets.all(10),
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).submit,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.white),
                      )
                    ],
                  ),
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}
