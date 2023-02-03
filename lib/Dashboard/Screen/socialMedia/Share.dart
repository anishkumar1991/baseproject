import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/cubit/FetchPostCubit.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<void> share(BuildContext context, int index) async {
  final cubit = context.read<FetchPostsCubit>();
  String urlimage = cubit.tempModel!.posts[index].postData.images!.first
      .toString();
  final text = "${cubit.tempModel!.posts[index].title.toString()} \n\n";
  final url = Uri.parse(urlimage);
  final response = await http.get(url);
  final bytes = response.bodyBytes;
  final temp = await getTemporaryDirectory();
  final path = '${temp.path}/image.jpg';
  File(path).writeAsBytesSync(bytes);
  XFile file = XFile(path);
  await Share.shareXFiles(text: text, [file]);
}