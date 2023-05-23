import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationaService {
  LocalNotificationaService();

  final BehaviorSubject<String> onNotificationClick = BehaviorSubject();
  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> intialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('ic_launcher');

    final InitializationSettings settings =
        InitializationSettings(android: androidInitializationSettings);

    await _localNotificationService.initialize(settings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetail =
        AndroidNotificationDetails('channel_id', 'channelName',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);

    return NotificationDetails(android: androidNotificationDetail);
  }

//=====================================================================
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  //----------------------------------------------------------------------
  Future<void> showScheduledNotificationWithPayload(
      {required int id,
      required String title,
      required String body,
      required int seconds,
      required String payload}) async {
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
            DateTime.now().add(Duration(seconds: seconds)), tz.local),
        details,
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

//===============================================================================
  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print(payload);
  }
}

void onDidReceiveNotificationResponse(NotificationResponse payload) async {
  print('payload $payload');
}
