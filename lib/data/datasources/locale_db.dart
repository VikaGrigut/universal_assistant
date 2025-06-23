import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:universal_assistant/core/enums/languages.dart';
import 'package:universal_assistant/data/models/app_settings_model.dart';
import 'package:universal_assistant/data/models/do_not_disturb_settings_model.dart';
import 'package:universal_assistant/data/models/pomodoro_settings_model.dart';
import 'package:universal_assistant/data/models/setting_model.dart';
import 'package:universal_assistant/presentation/home/cubit/home_cubit.dart';

class LocaleDBProvider {
  static Database? _db;
  static Database? _eventDB;
  static Database? _settingsDB;
  static Database? _tagsDB;
  LocaleDBProvider._constructor();
  static final LocaleDBProvider dbProvider = LocaleDBProvider._constructor();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDB();
    return _db!;
  }

  // Future<Database> get eventDB async{
  //   if(_eventDB != null){
  //     return _eventDB!;
  //   }
  //
  //   _eventDB = await initEventDB();
  //   return _eventDB!;
  // }
  //
  // Future<Database> get settingDB async{
  //   if(_settingsDB != null){
  //     return _settingsDB!;
  //   }
  //
  //   _settingsDB = await initSettingsDB();
  //   return _settingsDB!;
  // }
  //
  // Future<Database> get tagDB async{
  //   if(_tagsDB != null){
  //     return _tagsDB!;
  //   }
  //
  //   _tagsDB = await initTagsDB();
  //   return _tagsDB!;
  // }

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
      //context.select((HomeCubit cubit) => )
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

  // initEventDB() async {
  //   String path = join(await getDatabasesPath(), "assistant.db");
  //
  //   return await openDatabase(path, version: 1, onOpen: (db) {},
  //       onCreate: (Database db, int version) async {
  //     await db.execute("CREATE TABLE Events ("
  //         "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
  //         "name TEXT,"
  //         "allDay INTEGER,"
  //         "repetition INTEGER,"
  //         "periodicity TEXT,"
  //         "dateStart TEXT,"
  //         "dateEnd TEXT,"
  //         "tag TEXT,"
  //         "reminders TEXT,"
  //         "info TEXT)");
  //   });
  // }

  // initSettingsDB() async {
  //   String path = join(await getDatabasesPath(), "assistant.db");
  //
  //   return await openDatabase(path, version: 1, onOpen: (db) {},
  //       onCreate: (Database db, int version) async {
  //     await db.execute("CREATE TABLE Settings ("
  //         "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
  //         "app TEXT,"
  //         "doNotDisturb TEXT,"
  //         "pomodoro TEXT)");
  //   });
  // }
  //
  // initTagsDB() async {
  //   String path = join(await getDatabasesPath(), "assistant.db");
  //
  //   return await openDatabase(path, version: 1, onOpen: (db) {},
  //       onCreate: (Database db, int version) async {
  //     await db.execute("CREATE TABLE Tags ("
  //         "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
  //         "name TEXT)");
  //   });
  // }

  // Future<bool> deleteEventDb()async{
  //   final db = await dbProvider.eventDB;
  //   try{
  //     db.execute("CREATE TABLE Events ("
  //         "id INTEGER PRIMARY KEY NOT NULL, "
  //         "name TEXT,"
  //         "allDay INTEGER,"
  //         "repetition INTEGER,"
  //         "periodicity TEXT,"
  //         "dateStart TEXT,"
  //         "dateEnd TEXT,"
  //         "sphere TEXT,"
  //         "reminders TEXT,"
  //         "info TEXT)");
  //     print('cool');
  //     return true;
  //   }catch(error){
  //     return false;
  //   }
  // }
  //
  // Future<bool> deleteTaskDb()async{
  //   final db = await dbProvider.taskDB;
  //   try{
  //     db.execute("CREATE TABLE Tasks ("
  //         "id INTEGER PRIMARY KEY NOT NULL, "
  //         "name TEXT,"
  //         "allDay INTEGER,"
  //         "repetition INTEGER,"
  //         "periodicity TEXT,"
  //         "date TEXT,"
  //         "priority TEXT,"
  //         "sphere TEXT,"
  //         "reminder TEXT,"
  //         "info TEXT,"
  //         "isPomodoro INTEGER,"
  //         "isCompleted INTEGER)");
  //     print('cool');
  //     return true;
  //   }catch(error){
  //     return false;
  //   }
  // }
}
