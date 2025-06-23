import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:universal_assistant/core/enums/languages.dart';
import 'package:universal_assistant/data/models/app_settings_model.dart';
import 'package:universal_assistant/data/models/do_not_disturb_settings_model.dart';
import 'package:universal_assistant/data/models/pomodoro_settings_model.dart';
import 'package:universal_assistant/data/models/setting_model.dart';

class LocaleDBProvider {
  static Database? _db;
  LocaleDBProvider._constructor();
  static final LocaleDBProvider dbProvider = LocaleDBProvider._constructor();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDB();
    return _db!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), "assistant.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Tasks ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
          "name TEXT,"
          "allDay INTEGER,"
          "repetition INTEGER,"
          "periodicity TEXT,"
          "date TEXT,"
          "priority TEXT,"
          "tags TEXT,"
          "reminder TEXT,"
          "info TEXT,"
          "isPomodoro INTEGER,"
          "isCompleted INTEGER)");
      await db.execute("CREATE TABLE Events ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
          "name TEXT,"
          "allDay INTEGER,"
          "repetition INTEGER,"
          "periodicity TEXT,"
          "dateStart TEXT,"
          "dateEnd TEXT,"
          "tags TEXT,"
          "reminders TEXT,"
          "info TEXT)");
      await db.execute("CREATE TABLE Settings ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
          "app TEXT,"
          "pomodoro TEXT)");
      await db.execute("CREATE TABLE Tags ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
          "name TEXT);");

      final code =
          WidgetsBinding.instance.platformDispatcher.locale.languageCode;
      await db.insert(
        'Settings',
        SettingsModel(
          appSettings: AppSettingsModel(
              theme: 'light',
              language: code == 'ru'
                  ? Languages.ru
                  : code == 'be'
                      ? Languages.be
                      : Languages.en),
          pomodoroSettings: const PomodoroSettingsModel(
            numOfPomo: 4,
            durationPomo: 25,
            shortBreak: 5,
            longBreak: 15,
            doNotDisturbSettings: DoNotDisturbSettingsModel(
              pinningScreen: false,
              silentMode: false,
              timeInterval: 0,
            ),
          ),
        ).toJson(),
      );
    });
  }
}
