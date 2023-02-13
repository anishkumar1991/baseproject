import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../Values/space_height_widget.dart';
import '../../../../../../Values/space_width_widget.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.greyColor.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: ListView.builder(
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
                    border: Border.all(color: AppColor.white),
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
                      ),),
                    spaceWidthWidget(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.blue.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(5),
                            color: AppColor.white,
                          ),),
                        spaceHeightWidget(5),
                        Container(
                          height: 15,
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.blue.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(5),
                            color: AppColor.white,
                          ),),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:AppColor.white
                      ),
                      height: 40,
                      width: 40,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
