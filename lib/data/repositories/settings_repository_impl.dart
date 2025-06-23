import 'package:universal_assistant/data/models/pomodoro_settings_model.dart';
import 'package:universal_assistant/domain/entities/pomodoro_settings.dart';
import '../../domain/entities/setting.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/locale_db.dart';
import '../models/setting_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final LocaleDBProvider dbProvider = LocaleDBProvider.dbProvider;

  @override
  Future<List<Settings>?> getSettings() async {
    final db = await dbProvider.db;
    List<Map<String, Object?>> result = await db.query('Settings');
    List<Settings>? settings;
    if (result.isEmpty) {
      List<SettingsModel> settingsModel = List<SettingsModel>.from(
          result.map((element) => SettingsModel.fromJson(element)));
      settings = settingsModel.map((element) => element.toEntity()).toList();
    }
    return settings;
  }

  @override
  Future<bool> savePomodoroSettings(PomodoroSettings data) async {
    final db = await dbProvider.db;
    PomodoroSettingsModel dataModel = PomodoroSettingsModel.fromEntity(data);
    List<Map<String, Object?>> resultSettings = await db.query('Settings');
    if (resultSettings.isEmpty) {
      List<SettingsModel> settingsModel = List<SettingsModel>.from(
          resultSettings.map((element) => SettingsModel.fromJson(element)));
      //settings = settingsModel.map((element) => element.toEntity()).toList();
      final SettingsModel newSettings = SettingsModel(
        appSettings: settingsModel[0].appSettings,
        pomodoroSettings: dataModel,
      );
      final result = await db.update('Settings', newSettings.toJson());
      return result == 0 ? false : true;
    }
    return false;
  }

}
