import 'package:universal_assistant/domain/entities/task.dart';

import '../entities/reminder.dart';

abstract class TaskRepository{
  Future<Task?> getTask(int taskId);

  Future<List<Task>?> getAllTasks();

  Future<bool> addTask(Task task);

  Future<bool> updateTask(Task task);

  Future<bool> deleteTask(int taskId);

  Future<bool> changeReminder(int taskId, Reminder reminder);

  Future<bool> changeTask(Task changedTask);
}