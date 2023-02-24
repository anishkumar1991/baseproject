import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/widget/pdf_download.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../Values/app_colors.dart';
import '../../../../../Values/space_height_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../notification_handler/local_notification_handler.dart';

class PannaPdfViewer extends StatefulWidget {
  final String? pdfLink;
  final int? pannaNumber;

  const PannaPdfViewer({Key? key, this.pdfLink, this.pannaNumber}) : super(key: key);

  @override
  State<PannaPdfViewer> createState() => _PannaPdfViewerState();
}

class _PannaPdfViewerState extends State<PannaPdfViewer> {
  bool isLoadingFailed = false;
  String? _localPath;
  bool? _permissionReady;
  TargetPlatform? platform;
  File file = File('');

  Future<bool> checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> prepareSaveDir() async {
    _localPath = (await findLocalPath())!;

    final savedDir = Directory(_localPath ?? "");
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/storage/emulated/0/Download";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return '${directory.path}${Platform.pathSeparator}Download';
    }
  }

  @override
  void initState() {
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
    super.initState();
  }

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
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: AppColor.textBlackColor),
              ),
              const Spacer(),
              widget.pdfLink == null || (widget.pdfLink?.isEmpty ?? true)
                  ? const SizedBox.shrink()
                  : IconButton(
                      splashRadius: 20,
                      onPressed: (() async {
                        await downloadFile();
                        /* downloadFile(
                            fileUrl: widget.pdfLink ?? '', context: context, pannaNumber: widget.pannaNumber ?? 0);*/
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
                            fileUrl: widget.pdfLink ?? '', context: context, pannaNumber: widget.pannaNumber ?? 0);
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
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: AppColor.black),
                  )),
                )
              : widget.pdfLink == null || (widget.pdfLink?.isEmpty ?? true)
                  ? Expanded(
                      child: Center(
                          child: Text(
                        S.of(context).noDataAvailable,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: AppColor.black),
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

  downloadFile() async {
    DateTime.now().toString();
    _permissionReady = await checkPermission();
    if (_permissionReady ?? false) {
      await prepareSaveDir();
      var pdfName = widget.pannaNumber;

      try {
        await Dio().download(widget.pdfLink ?? "", "$_localPath/$pdfName.pdf");

        LocalNotificationService.createAndDisplayNotificationDownload(
            "$pdfName.pdf", " $_localPath/$pdfName.pdf", "File Downloaded");
        print("Download done");
      } catch (e) {
        LocalNotificationService.createAndDisplayNotificationDownload(
            "$pdfName.pdf", "".toString(), "File Download Fail");
        print("Exception :: $e");
      }
    }
  }
}
