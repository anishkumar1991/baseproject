import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/pravas_create/cubit/pravas_create_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/edit_date/widgets/header_widget_pravas_create.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/pravas_create/widgets/header_widget_pravas_create.dart';
import '../../../../../Values/app_colors.dart';
import '../../../../../Values/spaceHeightWidget.dart';
import '../../../../../common/common_button.dart';
import '../../../../../common/textfiled_widget.dart';
import '../../../../../route/route_path.dart';
import '../edit_date/edit_date_screen.dart';

class PrvasCreateScreen extends StatefulWidget {
  const PrvasCreateScreen({Key? key}) : super(key: key);

  @override
  State<PrvasCreateScreen> createState() => _PrvasCreateScreenState();
}

class _PrvasCreateScreenState extends State<PrvasCreateScreen> {
  TextEditingController prvasNameCtr = TextEditingController();
  TextEditingController pravasSubjectCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PravasCreateCubit>(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceHeightWidget(10),
            headerWidgetPravasCreate(),
            spaceHeightWidget(MediaQuery.of(context).size.height * 0.02),
            TextFieldWidget(
              controller: prvasNameCtr,
              title: '',
              labelText: 'प्रवास का नाम*',
              keyboardType: TextInputType.emailAddress,
            ),
            spaceHeightWidget(35),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<PravasCreateCubit, PravasCreateState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Text(
                          cubit.date,
                          style: const TextStyle(
                            color: AppColor.greyColor,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            cubit.startDateOfTour(context);
                          },
                          child: const Icon(
                              Icons.calendar_month_outlined,color:  AppColor.greyColor,),
                        )
                      ],
                    );
                  },
                ),
                spaceHeightWidget(4),
                 Divider(
                  height: 2,
                  thickness: 1.5,
                   color: AppColor.greyColor.withOpacity(0.5),
                )
              ],
            ),
            spaceHeightWidget(35),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<PravasCreateCubit, PravasCreateState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Text(
                          cubit.date1,
                          style: const TextStyle(
                            color: AppColor.greyColor,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            cubit.endOfTour(context);
                          },
                          child: const Icon(
                              Icons.calendar_month_outlined,color:  AppColor.greyColor),
                        )
                      ],
                    );
                  },
                ),
                spaceHeightWidget(4),
                 Divider(
                  height: 2,
                  thickness: 1.5,
                  color: AppColor.greyColor.withOpacity(0.5),
                )
              ],
            ),
            spaceHeightWidget(5),
            TextFieldWidget(
              controller: pravasSubjectCtr,
              title: '',
              labelText: 'प्रवास का विषय ',
              keyboardType: TextInputType.emailAddress,
            ),
            spaceHeightWidget(MediaQuery.of(context).size.height * 0.08),
            CommonButton(
              onTap: (){
               showConfirmDialog();
              },
              title: 'प्रवास बनाये',
              borderRadius: 10,
              height: 50,
              style: const TextStyle(fontSize: 15, color: AppColor.white),
            )
          ],
        ),
      ),
    );
  }

  Future showConfirmDialog(){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: Colors.transparent)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonButton(
                  onTap: (){
                    Navigator.pushNamed(context, RoutePath.createFunctionScreen);
                  },
                  title: 'प्रवास के अंतरगर्त कार्यक्रम बनाये',
                  borderRadius: 20,
                  height: 45,
                  style: const TextStyle(fontSize: 14, color: AppColor.white),
                ),
                spaceHeightWidget(20),
                CommonButton(
                  onTap: (){

                  },
                  title: 'बाद मे',
                  borderRadius: 20,
                  height: 45,
                  backGroundcolor: Colors.transparent,
                  bordercolor: AppColor.buttonOrangeBackGroundColor,
                  style: const TextStyle(fontSize: 14, color: AppColor.buttonOrangeBackGroundColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
