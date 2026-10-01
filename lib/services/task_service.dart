import 'package:hive/hive.dart';

import '../boxes.dart';
import '../models/task.dart';

/// All CRUD operations on the Hive task box live here,
/// so the UI never talks to Hive directly.
class TaskService {
  static Box<Task> get _box => Boxes.tasks;

  /// CREATE - adds a new task with an auto-increment key.
  static Future<int> addTask({required String title, required DateTime date}) {
    return _box.add(Task(title: title.trim(), date: date));
  }

  /// READ - returns tasks sorted by date (earliest first).
  static List<Task> getTasks(Box<Task> box) {
    final tasks = box.values.toList();
    tasks.sort((a, b) => a.date.compareTo(b.date));
    return tasks;
  }

  /// UPDATE - edits the title/date of an existing task.
  static Future<void> updateTask(
    Task task, {
    required String title,
    required DateTime date,
  }) {
    task
      ..title = title.trim()
      ..date = date;
    return task.save();
  }

  /// UPDATE - marks a task as done / not done.
  static Future<void> toggleDone(Task task) {
    task.isDone = !task.isDone;
    return task.save();
  }

  /// DELETE - removes a task from the box.
  static Future<void> deleteTask(Task task) => task.delete();

  /// Puts a deleted task back under its old key (used by "Undo").
  static Future<void> restoreTask(dynamic key, Task task) {
    return _box.put(key, task);
  }
}
