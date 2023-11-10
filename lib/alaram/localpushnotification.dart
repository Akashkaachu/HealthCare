import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationWidget {
  static final nofications = FlutterLocalNotificationsPlugin();
  static Future init({bool scheduled = false}) async {
    var initAndroidSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    final settings = InitializationSettings(android: initAndroidSettings);
    await nofications.initialize(settings);
  }

  static Future showNotification(
          {var id = 0, var title, var body, var payload}) async =>
      nofications.show(id, title, body, await noficationsDetails());

  static noficationsDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channel id 4', 'channel name',
          importance: Importance.max,
          //playSound: false,
          sound: RawResourceAndroidNotificationSound('alarm')),
    );
  }
}
