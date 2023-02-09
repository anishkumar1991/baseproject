// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// void main() {
//   runApp(MaterialApp(home: Home()));
// }
//
// class Home extends StatefulWidget {
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   String fileurl = "https://fluttercampus.com/sample.pdf";
//
//   //you can save other file formats too.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: Text("Download File from URL"),
//           backgroundColor: Colors.deepPurpleAccent,
//         ),
//         body: Container(
//           margin: EdgeInsets.only(top: 50),
//           child: Column(
//             children: [
//               Text("File URL: $fileurl"),
//               Divider(),
//               ElevatedButton(
//                 onPressed: () async {
//                   Map<Permission, PermissionStatus> statuses = await [
//                     Permission.storage,
//                     //add more permission to request here.
//                   ].request();
//
//                   if (statuses[Permission.storage]!.isGranted) {
//                     var dir = await DownloadsPathProvider.downloadsDirectory;
//                     if (dir != null) {
//                       String savename = "file.pdf";
//                       String savePath = dir.path + "/$savename";
//                       print(savePath);
//                       //output:  /storage/emulated/0/Download/banner.png
//
//                       try {
//                         await Dio().download(fileurl, savePath,
//                             onReceiveProgress: (received, total) {
//                           if (total != -1) {
//                             print((received / total * 100).toStringAsFixed(0) +
//                                 "%");
//                             //you can build progressbar feature too
//                           }
//                         });
//                         print("File is saved to download folder.");
//                       } on DioError catch (e) {
//                         print(e.message);
//                       }
//                     }
//                   } else {
//                     print("No permission to read and write.");
//                   }
//                 },
//                 child: Text("Download File."),
//               )
//             ],
//           ),
//         ));
//   }
// }
