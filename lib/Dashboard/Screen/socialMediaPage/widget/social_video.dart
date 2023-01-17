import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/spaceHeightWidget.dart';

class SocialVideo extends StatelessWidget {
  const SocialVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            4,
            (index) => Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(children: [
                      Image.asset(
                        AppIcons.videoBackImage,
                        height: 170,
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          margin: const EdgeInsets.all(38),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: AppColor.white, width: 3)),
                          child: const Icon(
                            Icons.play_arrow,
                            color: AppColor.white,
                            size: 34,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AutoSizeText(
                                "BJP govt in UP means control over 'mafia....",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Tw Cen MT',
                                    fontSize: 14,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              spaceHeightWidget(3),
                              const Text(
                                "2.3M views",
                                style: TextStyle(
                                    fontFamily: 'Tw Cen MT',
                                    fontSize: 12,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                )),
      ),
    );
  }
}
