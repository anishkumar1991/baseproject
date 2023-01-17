import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/spaceHeightWidget.dart';
import 'package:sangathan/Values/spaceWidthWidget.dart';

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
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceHeightWidget(10),
            appbar(),
            spaceHeightWidget(20),
            Row(
              children: [
                IconButton(
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
            spaceHeightWidget(10),
            Expanded(
              flex: 2,
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 33,
                      mainAxisSpacing: 16),
                  itemBuilder: ((context, index) {
                    return Container(
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
                    );
                  })),
            ),
            spaceHeightWidget(24),
            
          ],
        ),
      )),
    );
  }

  Widget appbar() {
    return Stack(
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
    );
  }
}
