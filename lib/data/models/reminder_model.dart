import 'package:equatable/equatable.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';

class ReminderModel extends Equatable{
  const ReminderModel({
    required this.id,
    required this.message,
    required this.title,
    required this.dateOfNotification,
});

  final int id;
  final String message;
  final String title;
  final DateTime dateOfNotification;

  ReminderModel.fromJson(Map<String, Object?> json)
    :id = int.parse(json['id'].toString()),
    message = json['message'].toString(),
    title = json['title'].toString(),
    dateOfNotification = DateTime.parse(json['dateOfNotification'].toString());

  Reminder toEntity() => Reminder(
      id: id,
      message: message,
      title: title,
      dateOfNotification: dateOfNotification,
  );

  ReminderModel.fromEntity(Reminder reminderEntity)
    :this(id: reminderEntity.id,
      message: reminderEntity.message,
      title:  reminderEntity.title,
      dateOfNotification: reminderEntity.dateOfNotification,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'message': message,
    'title': title,
    'dateOfNotification': dateOfNotification.toString(),
  };

  @override
  List<Object?> get props => [
      id,
      message,
      title,
      dateOfNotification,
  ];

}