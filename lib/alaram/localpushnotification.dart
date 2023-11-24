import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotificationWidget {
  static final nofications = FlutterLocalNotificationsPlugin();
  static Future init({bool scheduled = false}) async {
    tzdata.initializeTimeZones();
    var initAndroidSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    final settings = InitializationSettings(android: initAndroidSettings);
    await nofications.initialize(settings);
  }

  static Future<void> showNotification({
    var id = 0,
    var title,
    var body,
    var payload,
    required DateTime settime,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, settime.hour, settime.minute);

    await nofications.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      await noficationsDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'custom payload', // You can customize the payload as needed
      matchDateTimeComponents:
          DateTimeComponents.time, // Match only the time components
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }
  // nofications.show(id, title, body, await noficationsDetails());

  static noficationsDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channel id 5', 'channel name',
          importance: Importance.max,
          //playSound: false,
          sound: RawResourceAndroidNotificationSound('alarm')),
    );
  }
}
