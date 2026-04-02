import 'package:sqflite/sqflite.dart';
import '../models/task.dart';

class TaskRepository {
  final Database database;

  TaskRepository(this.database);

  Future<void> insertTask(Task task) async {
    final taskMap = task.toMap();
    final result = await database.rawQuery('SELECT MAX(id) as maxId FROM task');
    final currentMaxId = result.first['maxId'] as int?;
    taskMap['id'] = (currentMaxId ?? 0) + 1;
    await database.insert(
      'task',
      taskMap,
    );
  }

  Future<List<Task>> getTasks() async {
    final List<Map<String, dynamic>> maps = await database.query('task');

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<void> updateTask(Task task) async {
    await database.update(
      'task',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    await database.delete(
      'task',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}