import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../Values/app_colors.dart';

class SelectedBooth extends StatelessWidget {
  final String? leadingText;
  final String? title;
  final String? subTitle;
  final VoidCallback? onClose;
   SelectedBooth({Key? key,this.title,this.leadingText,this.onClose,this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 3,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
      return  Card(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none
        ),
        child: ListTile(
          horizontalTitleGap: 10,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none
          ),
          dense: true,
          contentPadding: EdgeInsets.only(left: 10,right: 10),
          leading: Container(
            margin: EdgeInsets.only(top: 1),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: AppColor.orange
            ),
            child: Text(
              leadingText ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: AppColor.white, fontSize: 12),
            ),
          ),
          title: Text(
            title ?? '',
            style: GoogleFonts.poppins(
                color: AppColor.black700,
                fontWeight: FontWeight.w400,
                fontSize: 12),
          ),
          subtitle: Text(
           subTitle ?? '',
            style: GoogleFonts.poppins(
                color: AppColor.black700,
                fontWeight: FontWeight.w400,
                fontSize: 12),
          ),
          trailing: SizedBox(
            height: double.infinity,
            child: InkWell(
              onTap: onClose,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.red
                ),
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
      );
    });
  }
}
