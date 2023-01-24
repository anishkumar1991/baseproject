import 'package:flutter/material.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/guest_list/widgets/header_widget_guest_list.dart';
import 'package:sangathan/Values/spaceWidthWidget.dart';

import '../../../../../Values/app_colors.dart';
import '../../../../../Values/spaceHeightWidget.dart';
import '../../../../../common/appstyle.dart';

class GuestListScreen extends StatelessWidget {
  const GuestListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               spaceHeightWidget(10),
               headerWidgetGuestList(context),
               spaceHeightWidget(MediaQuery.of(context).size.height * 0.02),
               ListView.builder(
                   shrinkWrap: true,
                   itemCount: 7,
                   physics: NeverScrollableScrollPhysics(),
                   padding: EdgeInsets.zero,
                   itemBuilder: (context,index){
                 return Padding(
                   padding: const EdgeInsets.all(5.0),
                   child: Container(
                     padding: EdgeInsets.all(10),
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
                                   TextSpan(text: '  '),
                                   TextSpan(text: '( महासचिव )',style: textStyleWithPoppin(color: AppColor.greyColor,fontSize: 12)),
                                 ],
                               ),
                             ),
                             Text("9783748362",style: textStyleWithPoppin(color: AppColor.greyColor,fontSize: 12),)
                           ],
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
