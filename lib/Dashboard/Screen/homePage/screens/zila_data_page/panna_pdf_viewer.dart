import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/widget/pdf_download.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../Values/app_colors.dart';
import '../../../../../Values/space_height_widget.dart';
import '../../../../../generated/l10n.dart';

class PannaPdfViewer extends StatefulWidget {
  final String? pdfLink;
  final int? pannaNumber;

  const PannaPdfViewer({Key? key, this.pdfLink, this.pannaNumber})
      : super(key: key);

  @override
  State<PannaPdfViewer> createState() => _PannaPdfViewerState();
}

class _PannaPdfViewerState extends State<PannaPdfViewer> {
  bool isLoadingFailed = false;
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
              ),
              const Spacer(),
              widget.pdfLink == null || (widget.pdfLink?.isEmpty ?? true)
                  ? const SizedBox.shrink()
                  : IconButton(
                      splashRadius: 20,
                      onPressed: (() {
                        downloadFile(
                            fileUrl: widget.pdfLink ?? '',
                            context: context,
                            pannaNumber: widget.pannaNumber ?? 0);
                      }),
                      icon: const Icon(
                        Icons.download,
                        size: 18,
                      )),
              widget.pdfLink == null || (widget.pdfLink?.isEmpty ?? true)
                  ? const SizedBox.shrink()
                  : IconButton(
                      splashRadius: 20,
                      onPressed: (() {
                        downloadAndShareFile(
                            fileUrl: widget.pdfLink ?? '',
                            context: context,
                            pannaNumber: widget.pannaNumber ?? 0);
                      }),
                      icon: const Icon(
                        Icons.share,
                        size: 18,
                      )),
            ],
          ),
          spaceHeightWidget(20),
          isLoadingFailed
              ? Expanded(
                  child: Center(
                      child: Text(
                    S.of(context).oopsErrorMsg,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColor.black),
                  )),
                )
              : widget.pdfLink == null || (widget.pdfLink?.isEmpty ?? true)
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
                      child: SfPdfViewer.network(
                      widget.pdfLink!,
                      canShowPaginationDialog: false,
                      onDocumentLoadFailed: (v) {
                        print(v.error);
                        print(v.description);
                        isLoadingFailed = true;
                        setState(() {});
                      },
                    )),
        ],
      )),
    );
  }
}
