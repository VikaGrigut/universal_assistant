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
    //print('✅ Notifications initialized');
    // final status = await Permission.notification.status;
    // if (!status.isGranted) {
    //   final result = await Permission.notification.request();
    //   print('🔔 Permission result: $result');
    //}
    //   await plugin
    //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    //     ?.requestPermission();
    //
    // // Для iOS, если хочешь быть уверенным, можно еще добавить:
    // await plugin
    //     .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
    //     ?.requestPermissions(
    //       alert: true,
    //       badge: true,
    //       sound: true,
    //     );
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
    // DateTime date = DateTime(
    //   2025,
    //   02,
    //   05,
    //   16,
    //   05
    // );
    //Map<String,String> meow = {'id':'1','text':'wow'};
    //final time = DateTime.now().add(const Duration(minutes: 1));
    await plugin.zonedSchedule(
        reminder.id,
        reminder.title,
        reminder.message,
        // 1,
        // 'title',
        // 'message',
        tz.TZDateTime.from(reminder.dateOfNotification, tz.local),
        details,
        payload: 'instant',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
    print(
        'Уведомление установлено:\n${reminder.dateOfNotification.toString()}');
  }

  Future<void> deleteNotification(int notificationId) async{
    await plugin.cancel(notificationId);
  }
}
