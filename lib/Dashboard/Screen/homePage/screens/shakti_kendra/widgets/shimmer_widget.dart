import 'package:flutter/material.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../Values/app_colors.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.greyColor.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.dividerColor),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    ListTile(
                      horizontalTitleGap: 8,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.16),
                          gradient: const LinearGradient(
                              colors: [
                                AppColor.purple50,
                                AppColor.orange200,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                      ),
                      title: Container(
                        height: 10,
                        width: 30,
                        color: AppColor.white,
                      ),
                      subtitle: Container(
                        height: 10,
                        width: 30,
                        color: AppColor.white,
                      ),
                      trailing: Container(
                        height: 38,
                        width: 38,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.16),
                            color: AppColor.white),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 50,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.white),
                        ),
                        const Spacer(),
                        Container(
                          height: 38,
                          width: 38,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.16),
                              color:
                                  AppColor.dividerColor.withOpacity(0.5)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
