import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sangathan/Values/string.dart';
import 'package:share_plus/share_plus.dart';

import '../cubits/ReelsCubit.dart';

Future<void> ReelDownloadshare(
    BuildContext context, int index, String sourceLink,String urlimage,String text1) async {
  final cubit = context.read<ReelsCubit>();

  String? savePath;

  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();

  if (statuses[Permission.storage]!.isGranted) {
    String? dir;
    if (Platform.isAndroid) {
      final externalStorageFolder = await getExternalStorageDirectory();
      if (externalStorageFolder != null) {
        dir = p.join(externalStorageFolder.path, "Downloads");
      }
    } else {
      final downloadFolder = await getDownloadsDirectory();
      if (downloadFolder != null) {
        dir = downloadFolder.path;
      }
    }
    if (dir != null) {
      String savename = "file.mp4";

      savePath = dir + "/$savename";
      print(savePath);
      //output:  /storage/emulated/0/Download/banner.png

      try {
        await Dio().download(sourceLink, savePath,
            onReceiveProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
            //you can build progressbar feature too
          }
        });
        print("File is saved to download folder.");
      } on DioError catch (e) {
        print(e.message);
      }
    }
  } else if (statuses[Permission.storage]!.isPermanentlyDenied) {
    Dialog(
      child: Text("Allow Storage Permission"),
    );
  } else {
    Widget build(BuildContext context) {
      String downloadingprogress = (1 * 100).toInt().toString();

      return AlertDialog(
        backgroundColor: Colors.black,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator.adaptive(),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Downloading: $downloadingprogress%",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ],
        ),
      );
    }

    print("permisison not granted");
  }


  var text2 = AppStrings.shareUrl;
  final text = "$text1\n\n$text2";
  final url = Uri.parse(urlimage);
  final response = await http.get(url);
  final bytes = response.bodyBytes;
  final temp = await getTemporaryDirectory();
  final path = savePath;
  File(path!).writeAsBytesSync(bytes);
  XFile file = XFile(path);
  await Share.shareXFiles(text: text, [file]);
}
