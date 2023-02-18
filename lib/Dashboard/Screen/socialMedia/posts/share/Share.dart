import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../cubit/FetchPostCubit.dart';

Future<void> share(BuildContext context, int index) async {
  final cubit = context.read<FetchPostsCubit>();
  String urlimage =
      cubit.tempModel!.posts[index].postData.images!.first.toString();
  var text1 = cubit.tempModel!.posts[index].title;
  var text2 = "https://mpsangathan.com/app";
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
