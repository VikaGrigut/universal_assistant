import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:universal_assistant/data/datasources/locale_db.dart';
import 'package:universal_assistant/data/models/reminder_model.dart';
import 'package:universal_assistant/data/models/task_model.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';
import 'package:universal_assistant/domain/entities/task.dart';
import 'package:universal_assistant/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocaleDBProvider dbProvider = LocaleDBProvider.dbProvider;

  @override
  Future<bool> changeReminder(int taskId, Reminder reminder) async {
    final db = await dbProvider.taskDB;
    ReminderModel reminderModel = ReminderModel.fromEntity(reminder);
    final reminderJson = reminderModel.toJson();
    try {
      await db.update(
        'Tasks',
        {'reminder': jsonEncode(reminderJson)},
        where: 'id = ?',
        whereArgs: [taskId],
      );
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> changeTask(Task changedTask) async {
    final db = await dbProvider.taskDB;
    TaskModel taskModel = TaskModel.fromEntity(changedTask);
    final taskJson = taskModel.toJson();
    // ReminderModel reminderModel = ReminderModel.fromEntity(reminder);
    // final reminderJson = reminderModel.toJson();
    try {
      await db.update(
        'Tasks',
        taskJson,
        where: 'id = ?',
        whereArgs: [changedTask.id],
      );
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> deleteTask(int taskId) async {
    final db = await dbProvider.taskDB;
    final result =
        await db.delete('Tasks', where: 'id = ?', whereArgs: [taskId]);
    return result == 0 ? false : true;
  }

  @override
  Future<List<Task>?> getAllTasks() async {
    final db = await dbProvider.taskDB;
    List<Map<String, Object?>> result = await db.query('Tasks');
    List<Task>? listTasks;
    if (result.isEmpty) {
      return listTasks;
    } else {
      List<TaskModel> listModels = List<TaskModel>.from(
          result.map((element) => TaskModel.fromJson(element)));
      listTasks = listModels.map((element) => element.toEntity()).toList();
      return listTasks;
    }
  }

  @override
  Future<Task?> getTask(int taskId) async {
    final db = await dbProvider.taskDB;
    final result =
        await db.query('Tasks', where: 'id = ?', whereArgs: [taskId]);
    Task? task;
    if (result.isEmpty) {
      return task;
    } else {
      TaskModel taskModel = TaskModel.fromJson(result.first);
      task = taskModel.toEntity();
      return task;
    }
  }

  @override
  Future<bool> updateTask(Task task) async {
    final db = await dbProvider.taskDB;
    TaskModel taskModel = TaskModel.fromEntity(task);
    try {
      await db.update(
        'Tasks',
        taskModel.toJson(),
        where: 'id = ?',
        whereArgs: [taskModel.id],
      );
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> addTask(Task task) async {
    final db = await dbProvider.taskDB;
    TaskModel taskModel = TaskModel.fromEntity(task);
    try {
      final result = await db.insert('Tasks', taskModel.toJson());
      return result == 0 ? false : true;
    } catch (error) {
      return false;
    }
  }
}
