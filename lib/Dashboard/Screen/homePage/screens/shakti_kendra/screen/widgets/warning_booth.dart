import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/space_height_widget.dart';

import '../../../../../../../Values/app_colors.dart';

class WarningBooth extends StatelessWidget {
  final String? leadingText;
  final String? title;
  final String? subTitle;
  final VoidCallback? onClose;

  const WarningBooth(
      {Key? key, this.onClose, this.subTitle, this.leadingText, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 3,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DottedBorder(
              color: AppColor.blue,
              strokeWidth: 1,
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.pravasCradColor.withOpacity(0.2),
                ),
                child: Column(
                  children: [
                    ListTile(
                      horizontalTitleGap: 10,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      dense: true,
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      leading: Container(
                        margin: EdgeInsets.only(top: 1),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: AppColor.orange),
                        child: Text(
                          leadingText ?? '102',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: AppColor.white, fontSize: 12),
                        ),
                      ),
                      title: Text(
                        title ?? 'Govt. Upper Primary School, 4-5',
                        style: GoogleFonts.poppins(
                            color: AppColor.black700,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                      subtitle: Text(
                        subTitle ?? 'NWD- 2',
                        style: GoogleFonts.poppins(
                            color: AppColor.black700,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                      trailing: SizedBox(
                        height: double.infinity,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: AppColor.red),
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.close,
                                color: AppColor.white,
                                size: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColor.naturalBlackColor.withOpacity(0.8),
                      indent: 15,
                      endIndent: 15,
                    ),
                    Text(
                      "Current Shakti Kendra- Test ABC Shakti kendra",
                      style: GoogleFonts.poppins(
                          color: AppColor.black700,
                          fontWeight: FontWeight.w400,
                          fontSize: 10),
                    ),
                    spaceHeightWidget(10)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
