import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

import '../main.dart';

Future<void> displayNotification(String match, DateTime dateTime) async {
  flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      match,
      'Match is Started',
      tz.TZDateTime.from(dateTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description'),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true);
}








// void scheduleAlarm(
//   DateTime scheduledNotificationDateTime,
// ) async {
//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//     'alarm_notif',
//     'alarm_notif',
//     // 'Channel for Alarm notification',
//     icon: 'codex_logo',
//     sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
//     largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
//   );

//   // var iOSPlatformChannelSpecifics = IOSNotificationDetails(
//   //     sound: 'a_long_cold_sting.wav',
//   //     presentAlert: true,
//   //     presentBadge: true,
//   //     presentSound: true);
//   // var platformChannelSpecifics = NotificationDetails(
//   //     androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

//   var flutterLocalNotificationsPlugin;
//   await flutterLocalNotificationsPlugin.schedule(0, 'Office', "alarmInfo.title",
//       scheduledNotificationDateTime, androidPlatformChannelSpecifics);
// }
