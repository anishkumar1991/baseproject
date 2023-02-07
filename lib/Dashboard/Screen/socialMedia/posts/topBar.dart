import 'package:flutter/material.dart';

import '../../../../Values/app_colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: (() {
                    //  homePageScaffoldGlobalKey.currentState!.openDrawer();
                  }),
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.greyColor.withOpacity(0.1)),
                      // child: Image.asset(
                      //   AppIcons.notification,
                      //   height: 10,
                      //   color: AppColor.greyColor,
                      // ),
                      child: const Icon(
                        Icons.notifications,
                        color: AppColor.greyColor,
                        size: 20,
                      )),
                ),
              ),
            ),
            const Expanded(
              flex: 5,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Social Media',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '',

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
