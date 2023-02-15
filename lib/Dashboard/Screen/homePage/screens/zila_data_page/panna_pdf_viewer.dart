import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../Values/app_colors.dart';
import '../../../../../Values/space_height_widget.dart';
import '../../../../../generated/l10n.dart';

class PannaPdfViewer extends StatelessWidget {
  final String? pdfLink;

  const PannaPdfViewer({Key? key, this.pdfLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Row(
            children: [
              IconButton(
                  splashRadius: 20,
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  icon: const Icon(Icons.arrow_back)),
              Text(
                S.of(context).panna,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColor.textBlackColor),
              )
            ],
          ),
          spaceHeightWidget(20),
          pdfLink == null
              ? Expanded(
                  child: Center(
                      child: Text(
                    S.of(context).noDataAvailable,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColor.black),
                  )),
                )
              : Expanded(
                  child: SfPdfViewer.network(pdfLink!,
                      canShowPaginationDialog: false)),
        ],
      )),
    );
  }
}
