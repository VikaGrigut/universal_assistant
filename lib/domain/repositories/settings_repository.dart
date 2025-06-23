import 'package:universal_assistant/domain/entities/pomodoro_settings.dart';

import '../entities/setting.dart';

abstract class SettingsRepository{
  Future<List<Settings>?> getSettings();

  Future<bool> savePomodoroSettings(PomodoroSettings data);

}