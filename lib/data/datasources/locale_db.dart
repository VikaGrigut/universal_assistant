import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocaleDBProvider{
  static Database? _taskDB;
  static Database? _eventDB;
  static Database? _settingsDB;
  static Database? _tagsDB;
  LocaleDBProvider._constructor();
  static final LocaleDBProvider dbProvider = LocaleDBProvider._constructor();

  Future<Database> get taskDB async{
    if(_taskDB != null){
      return _taskDB!;
    }

    _taskDB = await initTaskDB();
    return _taskDB!;
  }

  Future<Database> get eventDB async{
    if(_eventDB != null){
      return _eventDB!;
    }

    _eventDB = await initEventDB();
    return _eventDB!;
  }

  Future<Database> get settingDB async{
    if(_settingsDB != null){
      return _settingsDB!;
    }

    _settingsDB = await initSettingsDB();
    return _settingsDB!;
  }

  Future<Database> get tagDB async{
    if(_tagsDB != null){
      return _tagsDB!;
    }

    _tagsDB = await initTagsDB();
    return _tagsDB!;
  }

  initTaskDB() async{
    String path = join(await getDatabasesPath(), "tasks.db");
    DateTime now = DateTime.now();
    String m = now.toString();
    now = DateTime.parse(m);

    return await openDatabase(path, version: 1, onOpen: (db){}, onCreate: (Database db, int version) async{
      await db.execute("CREATE TABLE Tasks ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
          "name TEXT,"
          "allDay INTEGER,"
          "repetition INTEGER,"
          "periodicity TEXT,"
          "date TEXT,"
          "priority TEXT,"
          "tag TEXT,"
          "reminder TEXT,"
          "info TEXT,"
          "isPomodoro INTEGER,"
          "isCompleted INTEGER)");
    });
  }

  initEventDB() async{
    String path = join(await getDatabasesPath(), "events.db");

    return await openDatabase(path, version: 1, onOpen: (db){}, onCreate: (Database db, int version) async{
      await db.execute("CREATE TABLE Events ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
          "name TEXT,"
          "allDay INTEGER,"
          "repetition INTEGER,"
          "periodicity TEXT,"
          "dateStart TEXT,"
          "dateEnd TEXT,"
          "tag TEXT,"
          "reminders TEXT,"
          "info TEXT)");
    });
  }

  initSettingsDB() async{
    String path = join(await getDatabasesPath(), "settings.db");

    return await openDatabase(path, version: 1, onOpen: (db){}, onCreate: (Database db, int version) async{
      await db.execute("CREATE TABLE Settings ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
          "app TEXT,"
          "doNotDisturb TEXT,"
          "pomodoro TEXT)");
    });
  }

  initTagsDB() async{
    String path = join(await getDatabasesPath(), "tags.db");

    return await openDatabase(path, version: 1, onOpen: (db){}, onCreate: (Database db, int version) async{
      await db.execute("CREATE TABLE Tags ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
          "name TEXT)");
    });
  }

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