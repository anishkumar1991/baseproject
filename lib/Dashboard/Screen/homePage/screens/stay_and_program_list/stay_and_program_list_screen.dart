import 'package:flutter/material.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/stay_and_program_list/widgets/button.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/stay_and_program_list/widgets/cardListView.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/stay_and_program_list/widgets/header_widget_stay_program_list.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/common/appstyle.dart';


import '../../../../../Values/space_height_widget.dart';
import '../../../../../Values/space_width_widget.dart';
import '../../../../../common/common_button.dart';
import '../../../../../common/dot_widget.dart';
import '../../../../../route/route_path.dart';

class StayAndProgramListScreen extends StatelessWidget {
  const StayAndProgramListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            spaceHeightWidget(10),
            headerWidgetStayProgramList(context),
            spaceHeightWidget(MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCard(context: context),
                    spaceHeightWidget(MediaQuery.of(context).size.height * 0.025),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                          'कुल कार्यक्रम - 12',
                          textAlign: TextAlign.left,
                          style: textStyleWithPoppin(fontSize: 14,color: AppColor.black,fontWeight: FontWeight.w500)
                      ),
                    ),
                    spaceHeightWidget(MediaQuery.of(context).size.height * 0.015),
                    ListView.builder(
                        itemCount: 3,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return buildBottomContainer(context: context);
                        })

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: CommonButton(
              onTap: () {
                Navigator.pushNamed(context, RoutePath.createFunctionScreen);
              },
              title: 'प्रवास बनाये',
              width: 200,
              height: 50,
              borderRadius: 25,
              style: const TextStyle(fontSize: 20, color: AppColor.white),
            )),
      ),
    );
  }

  buildCard({required BuildContext context}){
    return  Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 15),
        child: Column(
          children: [
            buildTopRow(text: '20 - 23 Jan, 2023 ( 3 दिन ) ',isLeading: true),
            spaceHeightWidget(15),
            Align(
              alignment: Alignment.centerLeft,
              child: DotWidget(
                dashColor:
                AppColor.naturalBlackColor.withOpacity(0.1),
                dashWidth: 5,
                emptyWidth: 2,
                totalWidth: MediaQuery.of(context).size.width * 0.55,
              ),
            ),
            spaceHeightWidget(15),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: const Text(
                  'मुख्यमंत्री शिवराज सिंह चौहान ग्वालियर एवं मुरैना प्रवास पर',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: 15
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildTopRow({String? text,bool? isLeading}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(Icons.calendar_month_outlined,color: AppColor.darkBlue,size: 22,),
        spaceWidthWidget(6),
         Text(
          text ?? '',
           style: textStyleWithPoppin(color: AppColor.black.withOpacity(0.7),fontSize: 15)
        ),
        const Spacer(),
        isLeading == true ? const Icon(Icons.edit_outlined,color: AppColor.naturalBlackColor,size: 22) : const SizedBox.shrink(),
      ],
    );
  }

  buildBottomContainer({required BuildContext context}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.greyColor.withOpacity(0.5)),
            color: AppColor.pravasCradColor.withOpacity(0.3)
        ),
        child: Padding(
          // padding: EdgeInsets.symmetric(horizontal: 14.0,vertical: 15),
          padding: EdgeInsets.only(left: 14.0,top: 15,bottom: 15,right: 14),
          child: Column(
            children: [
              buildTopRow(isLeading: false,text: '20 Jan, 2023 ( 10:00 - 12:00 बजे )'),
              spaceHeightWidget(15),
              Align(
                alignment: Alignment.centerLeft,
                child: DotWidget(
                  dashColor:
                  AppColor.naturalBlackColor.withOpacity(0.1),
                  dashWidth: 5,
                  emptyWidth: 2,
                  totalWidth: MediaQuery.of(context).size.width * 0.75,
                ),
              ),
              spaceHeightWidget(15),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child:  Text(
                      'संभाग स्तरीय मुख्यमंत्री जनसेवा अभियान कार्यक्रम.',
                      textAlign: TextAlign.left,
                      style: textStyleWithPoppin(color: AppColor.black.withOpacity(0.7),fontSize: 14)
                  ),
                ),
              ),
              spaceHeightWidget(12),
              Align(
                alignment: Alignment.centerLeft,
                child: DotWidget(
                  dashColor:
                  AppColor.naturalBlackColor.withOpacity(0.1),
                  dashWidth: 5,
                  emptyWidth: 2,
                  totalWidth: MediaQuery.of(context).size.width * 0.75,
                ),
              ),
              spaceHeightWidget(12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset(AppIcons.marker,fit: BoxFit.cover,)),
                  spaceWidthWidget(5),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      'ग्वालियर एवं मुरैना',
                      textAlign: TextAlign.left,
                      style: textStyleWithPoppin(color: AppColor.black,fontSize: 14),

                    ),
                  ),
                  spaceWidthWidget(10),
                  Container(
                    margin: EdgeInsets.only(top: 3),
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: AppColor.white
                    ),
                    child: Text(
                      'प्रदेश स्तर',
                      textAlign: TextAlign.center,
                      style: textStyleWithPoppin(color: AppColor.black,fontSize: 12),
                    ),
                  )
                ],
              ),
              spaceHeightWidget(12),
              Align(
                alignment: Alignment.centerLeft,
                child: DotWidget(
                  dashColor:
                  AppColor.naturalBlackColor.withOpacity(0.1),
                  dashWidth: 5,
                  emptyWidth: 2,
                  totalWidth: MediaQuery.of(context).size.width * 0.75,
                ),
              ),
              spaceHeightWidget(12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'कार्यक्रम का प्रकार -',
                    textAlign: TextAlign.left,
                    style: textStyleWithPoppin(color: AppColor.greyColor,fontSize: 14),

                  ),
                  spaceWidthWidget(5),
                  Text(
                    'संगठनात्मक',
                    textAlign: TextAlign.left,
                    style: textStyleWithPoppin(color: AppColor.black,fontSize: 14),

                  ),
                ],
              ),
              spaceHeightWidget(12),
              Align(
                alignment: Alignment.centerLeft,
                child: DotWidget(
                  dashColor:
                  AppColor.naturalBlackColor.withOpacity(0.1),
                  dashWidth: 5,
                  emptyWidth: 2,
                  totalWidth: MediaQuery.of(context).size.width * 0.75,
                ),
              ),
              spaceHeightWidget(12),
              SizedBox(
                  height: 100,
                  child: CardListView(
                    onTap: (() {}),
                  )),
              spaceHeightWidget(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BuildButton(width: MediaQuery.of(context).size.width * 0.37,icon: Icons.mode_edit_outlined,text: 'एडिट',onTap: (){
                    Navigator.pushNamed(context, RoutePath.createFunctionScreen,
                    arguments: {
                      'isEdit' : true
                    });
                  },),
                  BuildButton(width: MediaQuery.of(context).size.width * 0.37,icon: Icons.visibility_outlined,text: 'देखें',onTap: (){
                    Navigator.pushNamed(context, RoutePath.createFunctionScreen,
                        arguments: {
                          'isView' : true
                        });
                  },)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
