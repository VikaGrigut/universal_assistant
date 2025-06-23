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
    required this.pomodoroSettings,
  });

  final AppSettingsModel appSettings;
  final PomodoroSettingsModel pomodoroSettings;

  SettingsModel.fromJson(Map<String, Object?> json)
      : this(
        appSettings: AppSettingsModel.fromJson(jsonDecode(json['app'].toString())),
        pomodoroSettings: PomodoroSettingsModel.fromEntity(jsonDecode(json['pomodoro'].toString()))
  );

  Settings toEntity() => Settings(
      appSettings: appSettings.toEntity(),
      pomodoroSettings: pomodoroSettings.toEntity());

  SettingsModel.fromEntity(Settings settingsEntity)
      : this(
        appSettings: AppSettingsModel.fromEntity(settingsEntity.appSettings),
        pomodoroSettings: PomodoroSettingsModel.fromEntity(settingsEntity.pomodoroSettings)
  );

  Map<String, Object?> toJson() => {
        'app': jsonEncode(appSettings.toJson()),
        'pomodoro': jsonEncode(pomodoroSettings.toJson())
      };

  @override
  List<Object?> get props => [
        appSettings,
        pomodoroSettings,
  ];
}
