import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import '../domain/entities/reminder.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings android =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings ios = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);

    const InitializationSettings initial =
        InitializationSettings(android: android, iOS: ios);

    await plugin.initialize(initial,
        onDidReceiveNotificationResponse: (NotificationResponse response) {});
  }

  Future<void> showInstanceNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
        'instant_channel', 'instant notification',
        channelDescription: 'Channel for notifications',
        importance: Importance.max,
        priority: Priority.high);

    const NotificationDetails spec = NotificationDetails(android: android);

    await plugin.show(0, 'Title', 'Body', spec, payload: 'instant');
  }

  Future<void> scheduledNotification(Reminder reminder) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
        'instant_channel', 'instant notification',
        channelDescription: 'Channel for notifications',
        importance: Importance.max,
        priority: Priority.high);

    const NotificationDetails details = NotificationDetails(android: android);

    await plugin.zonedSchedule(
        reminder.id,
        reminder.title,
        reminder.message,
        tz.TZDateTime.from(reminder.dateOfNotification, tz.local),
        details,
        payload: 'instant',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
    print(
        'Уведомление установлено:\n${reminder.dateOfNotification.toString()}');
  }

  Future<void> scheduleRecurringNotification({
  required int id,
  required String title,
  required String body,
  required DateTime scheduledDate,
  DateTime? endDate,
  required Duration interval,
}) async {
  if (endDate != null && scheduledDate.isAfter(endDate)) return;

  await plugin.zonedSchedule(
    id,
    title,
    body,
    tz.TZDateTime.from(scheduledDate, tz.local),
    const NotificationDetails(
      android: AndroidNotificationDetails('recurring_channel', 'Recurring',
          importance: Importance.max, priority: Priority.high),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: null, // отключаем регулярные повторы
  );


  Future.delayed(interval, () {
    scheduleRecurringNotification(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate.add(interval),
      endDate: endDate,
      interval: interval,
    );
  });
}

  Future<void> deleteNotification(int notificationId) async{
    await plugin.cancel(notificationId);
  }
}
