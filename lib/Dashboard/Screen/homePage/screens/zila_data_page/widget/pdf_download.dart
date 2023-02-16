import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../generated/l10n.dart';

Future<void> downloadAndShareFile({required String fileUrl,required BuildContext context,required int pannaNumber}) async {
  EasyLoading.show(status: S.of(context).preparing);
  final response = await http.get(Uri.parse(fileUrl));
  final bytes = response.bodyBytes;
  EasyLoading.dismiss();
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();
  print(statuses);

  // Get the directory for the app's documents directory
  final directory = await getApplicationDocumentsDirectory();

  // Create a new file in the directory
  final file = File('${directory.path}/$pannaNumber.pdf');

  // Write the bytes to the file
  await file.writeAsBytes(bytes);

  // Share the file
  await shareFile(file.path);
}

Future<void> shareFile(String filePath) async {
  final file = File(filePath);

  if (await file.exists()) {
    // Share the file
    await Share.shareFiles([file.path]);
  }
}
