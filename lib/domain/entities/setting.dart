import 'package:equatable/equatable.dart';
import 'package:universal_assistant/domain/entities/pomodoro_settings.dart';

import 'app_settings.dart';
import 'do_not_disturb_settings.dart';

class Settings extends Equatable{

  const Settings({
    required this.appSettings,
    required this.doNotDisturbSettings,
    required this.pomodoroSettings,
  });

  final AppSettings appSettings;
  final DoNotDisturbSettings doNotDisturbSettings;
  final PomodoroSettings pomodoroSettings;

  @override
  List<Object?> get props => [
    appSettings,
    doNotDisturbSettings,
    pomodoroSettings,
  ];
}