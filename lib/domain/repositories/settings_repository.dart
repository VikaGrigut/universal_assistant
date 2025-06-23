import 'package:universal_assistant/domain/entities/app_settings.dart';
import 'package:universal_assistant/domain/entities/pomodoro_settings.dart';
import 'package:universal_assistant/domain/entities/tag.dart';

import '../entities/setting.dart';

abstract class SettingsRepository{
  Future<List<Settings>?> getSettings();

  // PomodoroSettings? getPomodoroSettings();
  //
  // bool saveAppSettings(AppSettings data);
  //
  Future<bool> savePomodoroSettings(PomodoroSettings data);
  //
  // bool addSphere(Tag sphere);
  //
  // bool saveSphere(List<Tag> spheres);
  //
  // List<Tag>? getAllSpheres();
}