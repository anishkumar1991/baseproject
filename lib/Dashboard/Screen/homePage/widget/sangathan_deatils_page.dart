import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/spaceHeightWidget.dart';
import 'package:sangathan/Values/spaceWidthWidget.dart';
import 'package:sangathan/route/route_path.dart';

class SangathanDetailsPage extends StatelessWidget {
  SangathanDetailsPage({super.key});
  List data = [
    {'image': AppIcons.pradeshImage, 'text': 'Pradesh'},
    {'image': AppIcons.vibhagImage, 'text': 'Vibhag'},
    {'image': AppIcons.vidhansabhaImage, 'text': 'Vidhansabha'},
    {'image': AppIcons.zilaImage, 'text': 'Zila'},
    {'image': AppIcons.loksabhaImage, 'text': 'Loksabha'},
    {'image': AppIcons.mandalImage, 'text': 'Mandal'},
    {'image': AppIcons.shaktikendraImage, 'text': 'Shakti Kendra'},
    {'image': AppIcons.boothImage, 'text': 'Booth'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceHeightWidget(10),
            appbar(),
            spaceHeightWidget(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  IconButton(
                      splashRadius: 20,
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      icon: const Icon(Icons.arrow_back)),
                  Text(
                    'Sangthan',
                    style: GoogleFonts.quicksand(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            spaceHeightWidget(10),
            sangathanGridView(),
            spaceHeightWidget(24),
            Container(
              padding: const EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFFECECF8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create Shakti Kendra',
                    style: GoogleFonts.quicksand(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFE6E5FD),
                                Color(0xFFFFE3D3),
                              ])),
                      child: Image.asset(
                        AppIcons.shaktikendraImage,
                        height: 35,
                      ))
                ],
              ),
            ),
            spaceHeightWidget(20),
            sangathanReportCard(),
            spaceHeightWidget(60)
          ],
        ),
      )),
    );
  }

  Widget sangathanGridView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 33, mainAxisSpacing: 16),
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: (() {
                Navigator.pushNamed(context, RoutePath.addEntryScreen,
                    arguments: data[index]['text']);
              }),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFE6E5FD),
                          Color(0xFFFFE3D3),
                        ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      data[index]['image'],
                      height: 32,
                    ),
                    spaceHeightWidget(4),
                    FittedBox(
                      child: Text(
                        data[index]['text'],
                        style: GoogleFonts.quicksand(
                            fontSize: 10, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }

  Container sangathanReportCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.orange100,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sangathan Reports',
              style: GoogleFonts.quicksand(
                  color: AppColor.purpleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            spaceHeightWidget(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customColumnWidget(title: '543', subtitle: 'Lok Sabha'),
                customColumnWidget(title: '994', subtitle: 'Zila'),
                customColumnWidget(title: '4111', subtitle: 'Vidhan Sabha  '),
              ],
            ),
            spaceHeightWidget(28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customColumnWidget(title: '15710', subtitle: 'Mandal'),
                customColumnWidget(title: '44210', subtitle: 'Shaktikendra'),
                customColumnWidget(title: '10,50,558', subtitle: 'Booth'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column customColumnWidget({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.quicksand(
              color: AppColor.textBlackColor,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        spaceHeightWidget(4),
        Text(
          subtitle,
          style: GoogleFonts.quicksand(
              color: AppColor.greyColor,
              fontSize: 12,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  Widget appbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColor.buttonOrangeBackGroundColor,
                child: Text(
                  'A',
                  style: GoogleFonts.quicksand(
                      color: AppColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
              spaceWidthWidget(16),
              Text(
                'Namaskar Anirudh ji',
                style: GoogleFonts.quicksand(
                    color: AppColor.textBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Image.asset(
                AppIcons.customerService,
                height: 24,
              ),
            ],
          ),
          Positioned(
            left: 30,
            top: 10,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColor.white),
              child: Image.asset(
                AppIcons.drawerIcon,
                height: 7,
              ),
            ),
          )
        ],
      ),
    );
  }
}
