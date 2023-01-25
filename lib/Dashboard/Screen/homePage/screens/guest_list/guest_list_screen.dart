import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/guest_list/widgets/header_widget_guest_list.dart';

import '../../../../../Values/app_colors.dart';
import '../../../../../Values/space_height_widget.dart';
import '../../../../../Values/space_width_widget.dart';
import '../../../../../common/appstyle.dart';
import '../../../../../common/common_button.dart';
import '../../../../../common/textfiled_widget.dart';
import '../../../../../generated/l10n.dart';
import 'cubit/guest_cubit.dart';

class GuestListScreen extends StatelessWidget {
  const GuestListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<GuestCubit>(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               spaceHeightWidget(10),
               headerWidgetGuestList(context),
               spaceHeightWidget(MediaQuery.of(context).size.height * 0.02),
               TextFieldWidget(
                 controller: cubit.nameCtr,
                 title: '',
                 labelText: S.of(context).name,
                 keyboardType: TextInputType.emailAddress,
               ),
               TextFieldWidget(
                 controller: cubit.phoneNumber,
                 title: '',
                 labelText: S.of(context).phoneNumber,
                 keyboardType: TextInputType.emailAddress,
               ),
               TextFieldWidget(
                 controller: cubit.position,
                 title: '',
                 labelText: S.of(context).position,
                 keyboardType: TextInputType.emailAddress,
               ),
               spaceHeightWidget(30),
               CommonButton(
                 onTap: () {

                 },
                 title: S.of(context).add,
                 height: 50,
                 borderRadius: 7,
                 style: TextStyle(fontSize: 20, color: AppColor.white),
               ),
               spaceHeightWidget(20),
               ListView.builder(
                   shrinkWrap: true,
                   itemCount: 7,
                   physics: const NeverScrollableScrollPhysics(),
                   padding: EdgeInsets.zero,
                   itemBuilder: (context,index){
                 return Padding(
                   padding: const EdgeInsets.all(5.0),
                   child: Container(
                     padding: const EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       color: AppColor.greyWithOpacity01,
                       borderRadius: BorderRadius.circular(10)
                     ),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           height: 20,
                           width: 20,
                           decoration: BoxDecoration(
                             border: Border.all(color: AppColor.blue.withOpacity(0.2)),
                             borderRadius: BorderRadius.circular(5),
                             color: AppColor.white,
                           ),
                           child: Center(child: Text("${index + 1}.")),
                         ),
                         spaceWidthWidget(10),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             RichText(
                               text: TextSpan(
                                 style: DefaultTextStyle.of(context).style,
                                 children:  <TextSpan>[
                                   TextSpan(text: 'प्रवीण प्रणव', style: textStyleWithPoppin(color: AppColor.black,fontSize: 14)),
                                   const TextSpan(text: '  '),
                                   TextSpan(text: '( महासचिव )',style: textStyleWithPoppin(color: AppColor.greyColor,fontSize: 12)),
                                 ],
                               ),
                             ),
                             spaceHeightWidget(5),
                             Text("9783748362",style: textStyleWithPoppin(color: AppColor.greyColor,fontSize: 10),)
                           ],
                         ),
                         Spacer(),
                         Container(
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8),
                             color: AppColor.blue.withOpacity(0.15)
                           ),
                           height: 40,
                           width: 40,
                           child: Icon(Icons.edit_outlined,color: AppColor.blue,size: 22,),
                         )
                       ],
                     ),
                   ),
                 );
               })
             ],
          ),
        ),
      ),
    );
  }
}
