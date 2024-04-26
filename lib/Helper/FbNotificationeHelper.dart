import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

class FbNHelper {
  FbNHelper._();
  static final FbNHelper fbNHelper = FbNHelper._();
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> sendSimpleLocalNotification(
      {required String title,
      required String body,
      required String date}) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "channelId",
      "Simple Notification",
      priority: Priority.max,
      importance: Importance.max,
      icon: 'mipmap/ic_launcher',
    );
    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    try {
      await flutterLocalNotificationsPlugin
          .show(1, title, body, notificationDetails)
          .then((value) {
        Logger().t("Notification sent: ");
      }).catchError((error) {
        Logger().t("Error sending notification: $error");
      });
    } catch (error) {
      Logger().t("Exception while sending notification: $error");
    }
  }
}
