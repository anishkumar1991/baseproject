import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/pravas_module/edit_date/widgets/header_widget_pravas_create.dart';
import '../../../../../../Values/app_colors.dart';
import '../../../../../../Values/space_height_widget.dart';
import '../../../../../../common/common_button.dart';
import 'cubit/edit_date_cubit.dart';

class EditDateScreen extends StatefulWidget {
  const EditDateScreen({Key? key}) : super(key: key);

  @override
  State<EditDateScreen> createState() => _EditDateScreenState();
}

class _EditDateScreenState extends State<EditDateScreen> {
  TextEditingController prvasNameCtr = TextEditingController();
  TextEditingController pravasSubjectCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EditDateCubit>(context);
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
            headerWidgetEditDate(context: context),
            spaceHeightWidget(MediaQuery.of(context).size.height * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<EditDateCubit, EditDateState>(
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
                            cubit.editDate(context);
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
                BlocBuilder<EditDateCubit, EditDateState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Text(
                          cubit.time,
                          style: const TextStyle(
                            color: AppColor.greyColor,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            cubit.editTime(context);
                          },
                          child: const Icon(
                            Icons.timer_outlined,color:  AppColor.greyColor,),
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
            spaceHeightWidget(MediaQuery.of(context).size.height * 0.08),
            CommonButton(
              onTap: (){
                Navigator.pop(context);
              },
              title: 'आगे',
              borderRadius: 10,
              height: 50,
              style: const TextStyle(fontSize: 15, color: AppColor.white),
            )
          ],
        ),
      ),
    );
  }
}
