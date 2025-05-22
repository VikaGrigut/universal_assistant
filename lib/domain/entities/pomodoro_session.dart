import 'package:equatable/equatable.dart';
import 'package:universal_assistant/domain/entities/pomodoro_settings.dart';

import '../../core/enums/pomodoro_status.dart';

class PomodoroSession extends Equatable{
  const PomodoroSession({
    required this.taskId,
    required this.currentPomo,
    required this.timeToEnd,
    required this.status,
    required this.settings
});

  final int taskId;
  final int currentPomo;
  final DateTime timeToEnd;
  final PomodoroStatus status;
  final PomodoroSettings settings;

  @override
  List<Object?> get props => [
      taskId,
      currentPomo,
      timeToEnd,
      status,
      settings
  ];

}