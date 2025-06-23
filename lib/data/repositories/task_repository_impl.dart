import 'dart:convert';

import 'package:universal_assistant/data/datasources/locale_db.dart';
import 'package:universal_assistant/data/models/reminder_model.dart';
import 'package:universal_assistant/data/models/task_model.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';
import 'package:universal_assistant/domain/entities/task.dart';
import 'package:universal_assistant/domain/repositories/task_repository.dart';

import '../models/tag_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocaleDBProvider dbProvider = LocaleDBProvider.dbProvider;

  @override
  Future<bool> changeReminder(int taskId, Reminder reminder) async {
    final db = await dbProvider.db;
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
    final db = await dbProvider.db;
    TaskModel taskModel = TaskModel.fromEntity(changedTask);
    final taskJson = taskModel.toJson();
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
    final db = await dbProvider.db;
    final result =
        await db.delete('Tasks', where: 'id = ?', whereArgs: [taskId]);
    return result == 0 ? false : true;
  }

  @override
  Future<List<Task>?> getAllTasks() async {
    final db = await dbProvider.db;
    List<Map<String, Object?>> result = await db.query('Tasks');
    List<Task>? listTasks;
    if (result.isEmpty) {
      return listTasks;
    } else {
      List<Map<String, Object?>> resultTags = await db.query('Tags');
      List<TagModel> modelsTags = List<TagModel>.from(
          resultTags.map((element) => TagModel.fromJson(element)));
      List<TaskModel> listModels = List<TaskModel>.from(
          result.map((element) => TaskModel.fromJson(element,modelsTags)));
      listTasks = listModels.map((element) => element.toEntity()).toList();
      return listTasks;
    }
  }

  @override
  Future<Task?> getTask(int taskId) async {
    final db = await dbProvider.db;
    final result =
        await db.query('Tasks', where: 'id = ?', whereArgs: [taskId]);
    Task? task;
    if (result.isEmpty) {
      return task;
    } else {
      List<Map<String, Object?>> resultTags = await db.query('Tags');
      List<TagModel> modelsTags = List<TagModel>.from(
          resultTags.map((element) => TagModel.fromJson(element)));
      TaskModel taskModel = TaskModel.fromJson(result.first, modelsTags);
      task = taskModel.toEntity();
      return task;
    }
  }

  @override
  Future<bool> updateTask(Task task) async {
    final db = await dbProvider.db;
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
    final db = await dbProvider.db;
    TaskModel taskModel = TaskModel.fromEntity(task);
    try {
      final result = await db.insert('Tasks', taskModel.toJson());
      return result == 0 ? false : true;
    } catch (error) {
      return false;
    }
  }
}
