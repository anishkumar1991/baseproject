import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Values/app_colors.dart';
import '../Values/space_height_widget.dart';
import '../generated/l10n.dart';

class CustomYearPicker{
  static startYearPicker({required BuildContext context,required final cubit}){
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        builder: (builder) {
          return Container(
            color: Colors.transparent,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28.0),
                        topRight: Radius.circular(28.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceHeightWidget(10),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 5,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColor.borderColor),
                        ),
                      ),
                      spaceHeightWidget(30),
                      Text(
                        S.of(context).yearFrom,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: AppColor.borderColor, fontSize: 16),
                      ),
                      spaceHeightWidget(10),
                      Expanded(
                        child: GridView.count(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          crossAxisCount: 4,
                          children: [
                            ...List.generate(
                              100,
                                  (index) => InkWell(
                                onTap: () {
                                  cubit.startYearCtr.text = (DateTime.now().year - index).toString();
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Chip(
                                    label: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        (DateTime.now().year - index).toString(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
  }
  static endYearPicker({required BuildContext context,required final cubit}){
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        builder: (builder) {
          return Container(
            color: Colors.transparent,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28.0),
                        topRight: Radius.circular(28.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceHeightWidget(10),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 5,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColor.borderColor),
                        ),
                      ),
                      spaceHeightWidget(30),
                      Text(
                        S.of(context).yearTo,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: AppColor.borderColor, fontSize: 16),
                      ),
                      spaceHeightWidget(10),
                      Expanded(
                        child: GridView.count(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          crossAxisCount: 4,
                          children: [
                            ...List.generate(
                              (DateTime.now().year - int.parse(cubit.startYearCtr.text)),
                                  (index) => InkWell(
                                onTap: () {
                                  cubit.endYearCtr.text = (int.parse(cubit.startYearCtr.text) + index).toString();
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Chip(
                                    label: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        (int.parse(cubit.startYearCtr.text) + index).toString(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
  }
}