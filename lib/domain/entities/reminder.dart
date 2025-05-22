import 'package:equatable/equatable.dart';

import '../../data/notification_service.dart';

class Reminder extends Equatable{
  const Reminder({
    required this.id,
    required this.message,
    required this.title,
    required this.dateOfNotification,
});

  final int id;
  static NotificationService notificationService = NotificationService();
  final String message;
  final String title;
  final DateTime dateOfNotification;

  @override
  List<Object?> get props => [
      id,
      message,
      title,
      dateOfNotification,
  ];

}