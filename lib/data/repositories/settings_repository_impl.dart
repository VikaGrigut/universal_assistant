import 'package:hive/hive.dart';
import 'package:universal_assistant/data/models/pomodoro_settings_model.dart';
import 'package:universal_assistant/data/models/tag_model.dart';
import 'package:universal_assistant/domain/entities/app_settings.dart';
import 'package:universal_assistant/domain/entities/pomodoro_settings.dart';
import 'package:universal_assistant/domain/entities/tag.dart';
import '../../domain/entities/setting.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/locale_db.dart';
import '../models/app_settings_model.dart';
import '../models/setting_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final LocaleDBProvider dbProvider = LocaleDBProvider.dbProvider;

  @override
  Future<List<Settings>?> getSettings() async {
    final db = await dbProvider.settingDB;
    List<Map<String, Object?>> result = await db.query('Settings');
    List<Settings>? settings;
    if(result.isEmpty){
      List<SettingsModel> settingsModel = List<SettingsModel>.from(
        result.map((element) => SettingsModel.fromJson(element)));
      settings = settingsModel.map((element) => element.toEntity()).toList();
      //AppSettingsModel? appSettingsModel = _box.get('app_settings');
      //return settings;
    }
    return settings;
  }

  // @override
  // PomodoroSettings? getPomodoroSettings() {
  //   PomodoroSettingsModel? pomodoroSettingsModel =
  //       _box.get('pomodoro_settings');
  //   return pomodoroSettingsModel?.toEntity();
  // }
  //
  // @override
  // bool saveAppSettings(AppSettings data) {
  //   AppSettingsModel dataModel = AppSettingsModel.fromEntity(data);
  //   try {
  //     _box.put('app_settings', dataModel);
  //     return true;
  //   } catch (error) {
  //     return false;
  //   }
  // }
  //
  // @override
  // bool savePomodoroSettings(PomodoroSettings data) {
  //   PomodoroSettingsModel dataModel = PomodoroSettingsModel.fromEntity(data);
  //   try {
  //     _box.put('pomodoro_settings', dataModel);
  //     return true;
  //   } catch (error) {
  //     return false;
  //   }
  // }
  //
  // @override
  // List<Tag>? getAllSpheres() {
  //   List<dynamic> models = _box.get('spheres_list') ?? [];
  //   List<Tag> spheres =
  //       List<Tag>.from(models.map((element) => element.toEntity())).toList();
  //   return spheres;
  // }
  //
  // @override
  // bool addSphere(Tag sphere) {
  //   List<dynamic> spheres = _box.get('spheres_list') ?? [];
  //   TagModel model = TagModel.fromEntity(sphere);
  //   try {
  //     spheres.add(model);
  //     _box.put('spheres_list', spheres);
  //     return true;
  //   } catch (error) {
  //     print(error);
  //     return false;
  //   }
  // }
  //
  // @override
  // bool saveSphere(List<Tag> spheres) {
  //   List<TagModel> models = List<TagModel>.from(
  //       spheres.map((element) => TagModel.fromEntity(element))).toList();
  //   //List<SphereModel> spheres = _box.get('spheres_list');
  //   try {
  //     _box.put('spheres_list', models);
  //     return true;
  //   } catch (error) {
  //     print(error);
  //     return false;
  //   }
  // }
}
