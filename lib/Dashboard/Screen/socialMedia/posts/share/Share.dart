import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Values/string.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../cubit/FetchPostCubit.dart';

Future<void> share(
    BuildContext context, int index, String urlimage, var text1) async {
  final cubit = context.read<PostsCubit>();

  var text2 = AppStrings.shareUrl;
  final text = "$text1\n\n$text2";
  final url = Uri.parse(urlimage);
  final response = await http.get(url);
  final bytes = response.bodyBytes;
  final temp = await getTemporaryDirectory();
  final path = '${temp.path}/image.jpg';
  File(path).writeAsBytesSync(bytes);
  XFile file = XFile(path);
  await Share.shareXFiles(text: text, [file]);
}
