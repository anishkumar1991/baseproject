// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(context) {
    /// initializationSettings for iOS
    DarwinInitializationSettings initializationSettingsDarwin =
        const DarwinInitializationSettings();

    /// initializationSettings for Android
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  }

  static Future _getByteArrayFromUrl(String url) async {
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    return response.data;
  }

  static Future createAndDisplayNotification({
    required RemoteMessage? message,
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    try {
      debugPrint('message ----------$message');
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final int myId = int.parse(id.toString());
      if (message?.data["image"] != null) {
        final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
            await _getByteArrayFromUrl(message?.data["image"]));
        final BigPictureStyleInformation bigPictureStyleInformation =
            BigPictureStyleInformation(bigPicture,
                contentTitle: message?.data["title"],
                htmlFormatContentTitle: true,
                summaryText: message?.data["body"],
                htmlFormatSummaryText: true);
        final android = AndroidNotificationDetails(
            "sangathnapp", "sangathnappchannel",
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: bigPictureStyleInformation);
        const DarwinNotificationDetails darwinNotificationDetails =
            DarwinNotificationDetails();
        final platform = NotificationDetails(
          android: android,
          iOS: darwinNotificationDetails,
        );

        if (Platform.isAndroid) {
          await flutterLocalNotificationsPlugin.show(
            myId,
            message?.notification!.title,
            message?.notification!.body,
            platform,
            payload: message?.data.toString(),
          );
        } else if (Platform.isIOS) {
          await flutterLocalNotificationsPlugin.show(
            myId,
            message?.notification!.title,
            message?.notification!.body,
            platform,
            payload: message?.data.toString(),
          );
        }
      } else {
        const android = AndroidNotificationDetails(
          "sangathnapp",
          "sangathnappchannel",
          importance: Importance.max,
          priority: Priority.high,
        );
        const DarwinNotificationDetails darwinNotificationDetails =
            DarwinNotificationDetails();
        const platform = NotificationDetails(
          android: android,
          iOS: darwinNotificationDetails,
        );

        if (Platform.isAndroid) {
          await flutterLocalNotificationsPlugin.show(
            myId,
            message?.notification!.title,
            message?.notification!.body,
            platform,
            payload: message?.data.toString(),
          );
        } else if (Platform.isIOS) {
          await flutterLocalNotificationsPlugin.show(
            myId,
            message?.notification!.title,
            message?.notification!.body,
            platform,
            payload: message?.data.toString(),
          );
        }
      }

      debugPrint(
        "payload data------------------------------- :: ${message?.data.toString()}",
      );
    } on Exception catch (exc) {
      debugPrint("Here get exception for notification :${exc.toString()}");
    }
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    print('notification on tap payload: $payload');
  }
}
