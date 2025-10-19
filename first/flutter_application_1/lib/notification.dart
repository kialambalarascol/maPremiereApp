import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class Notif  {
final notificationPlugin = FlutterLocalNotificationsPlugin();
bool _isInitialized=false;

  Future <void> initNotif () async {
    if (_isInitialized) return;

    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(
      android:initSettingsAndroid
    );

    await notificationPlugin.initialize(initSettings);
     if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      final status = await Permission.notification.request();
      if (status != PermissionStatus.granted) {
        print('Notification permission denied');
      }
    }
  }

  _isInitialized = true;
  }

NotificationDetails notificationDetails(){
  return const NotificationDetails(
    android : AndroidNotificationDetails(
      "channelId", "premiere_notif",
      channelDescription: "test app Note",
      importance: Importance.max,
      priority: Priority.high,

      )
  );
}


Future <void> affichage ({
  int id =0,
  String? titre,
  String? body,


}) async {
  return notificationPlugin.show(id, titre, body, notificationDetails());
}

}