import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// class NotificationWidget {
//   static final nofications = FlutterLocalNotificationsPlugin();
//   static Future init({bool scheduled = false}) async {
//     tzdata.initializeTimeZones();
//     var initAndroidSettings =
//         const AndroidInitializationSettings('mipmap/ic_launcher');
//     final settings = InitializationSettings(android: initAndroidSettings);
//     await nofications.initialize(settings);
//   }

//   static Future<void> showNotification({
//     var id = 0,
//     var title,
//     var body,
//     var payload,
//     required DateTime settime,
//   }) async {
//     final now = tz.TZDateTime.now(tz.local);
//     final scheduledDate = tz.TZDateTime(
//         tz.local, now.year, now.month, now.day, settime.hour, settime.minute);

//     await nofications.zonedSchedule(
//       id,
//       title,
//       body,
//       scheduledDate,
//       await noficationsDetails(),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       payload: 'custom payload', // You can customize the payload as needed
//       matchDateTimeComponents:
//           DateTimeComponents.time, // Match only the time components
//       androidScheduleMode: AndroidScheduleMode.alarmClock,
//     );
//   }
//   // nofications.show(id, title, body, await noficationsDetails());

//   static noficationsDetails() async {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails('channel id 5', 'channel name',
//           importance: Importance.max,
//           //playSound: false,
//           sound: RawResourceAndroidNotificationSound('alarm')),
//     );
//   }
// }

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId1',
          'channelName',
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduledNotificationDateTime}) async {
    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
