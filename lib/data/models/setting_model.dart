import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:universal_assistant/data/models/app_settings_model.dart';
import 'package:universal_assistant/data/models/do_not_disturb_settings_model.dart';
import 'package:universal_assistant/data/models/pomodoro_settings_model.dart';
import 'package:universal_assistant/domain/entities/setting.dart';
import 'package:universal_assistant/domain/entities/tag.dart';

class SettingsModel extends Equatable {
  const SettingsModel({
    required this.appSettings,
    required this.doNotDisturbSettings,
    required this.pomodoroSettings,
  });

  final AppSettingsModel appSettings;
  final DoNotDisturbSettingsModel doNotDisturbSettings;
  final PomodoroSettingsModel pomodoroSettings;

  SettingsModel.fromJson(Map<String, Object?> json)
      : this(
        appSettings: AppSettingsModel.fromJson(jsonDecode(json['app'].toString())),
        doNotDisturbSettings: DoNotDisturbSettingsModel.fromJson(jsonDecode(json['doNotDisturb'].toString())),
        pomodoroSettings: PomodoroSettingsModel.fromEntity(jsonDecode(json['pomodoro'].toString()))
  );

  Settings toEntity() => Settings(
      appSettings: appSettings.toEntity(),
      doNotDisturbSettings: doNotDisturbSettings.toEntity(),
      pomodoroSettings: pomodoroSettings.toEntity());

  SettingsModel.fromEntity(Settings settingsEntity)
      : this(
        appSettings: AppSettingsModel.fromEntity(settingsEntity.appSettings),
        doNotDisturbSettings:  DoNotDisturbSettingsModel.fromEntity(settingsEntity.doNotDisturbSettings),
        pomodoroSettings: PomodoroSettingsModel.fromEntity(settingsEntity.pomodoroSettings)
  );

  Map<String, Object?> toJson() => {
        'app': jsonEncode(appSettings.toJson()),
        'doNotDisturb': jsonEncode(doNotDisturbSettings.toJson()),
        'pomodoro': jsonEncode(pomodoroSettings.toJson())
      };

  @override
  List<Object?> get props => [
        appSettings,
        doNotDisturbSettings,
        pomodoroSettings,
  ];
}
