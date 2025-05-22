import 'package:equatable/equatable.dart';
import 'package:universal_assistant/domain/entities/pomodoro_settings.dart';
import 'do_not_disturb_settings_model.dart';


class PomodoroSettingsModel extends Equatable{
  const PomodoroSettingsModel({
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

  final DoNotDisturbSettingsModel doNotDisturbSettings;

  PomodoroSettings toEntity() => PomodoroSettings(
    numOfPomo: numOfPomo, 
    durationPomo: durationPomo, 
    shortBreak: shortBreak, 
    longBreak: longBreak, 
    doNotDisturbSettings: doNotDisturbSettings.toEntity()
  );
  
  PomodoroSettingsModel.fromEntity(PomodoroSettings pomodoroSettingsEntity):
        this(numOfPomo: pomodoroSettingsEntity.numOfPomo, 
    durationPomo: pomodoroSettingsEntity.durationPomo, 
    shortBreak: pomodoroSettingsEntity.shortBreak, 
    longBreak: pomodoroSettingsEntity.longBreak, 
    doNotDisturbSettings: DoNotDisturbSettingsModel.fromEntity(pomodoroSettingsEntity.doNotDisturbSettings)
  );

  Map<String, Object?> toJson() => {
      'numOfPomo': numOfPomo,
      'durationPomo': durationPomo,
      'shortBreak': shortBreak,
      'longBreak': longBreak
  };

  @override
  List<Object?> get props => [
      numOfPomo,
      durationPomo,
      shortBreak,
      longBreak,
      doNotDisturbSettings,
  ];
}