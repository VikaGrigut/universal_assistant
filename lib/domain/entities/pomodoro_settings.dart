import 'package:equatable/equatable.dart';

import 'do_not_disturb_settings.dart';

class PomodoroSettings extends Equatable{
  const PomodoroSettings({
    required this.numOfPomo,
    required this.durationPomo,
    required this.shortBreak,
    required this.longBreak,
    required this.doNotDisturbSettings
});

  final int numOfPomo;
  final int durationPomo; // в минутах
  final int shortBreak;
  final int longBreak;
  final DoNotDisturbSettings doNotDisturbSettings;

  @override
  List<Object?> get props => [
      numOfPomo,
      durationPomo,
      shortBreak,
      longBreak,
      doNotDisturbSettings
  ];

}