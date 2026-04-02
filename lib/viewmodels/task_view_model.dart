import 'package:flutter/material.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> liste = [];
  final TaskRepository _repository;
  TaskViewModel(this._repository);

  Future<void> loadTasks() async {
    liste = await _repository.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _repository.insertTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task updatedTask) async {
    await _repository.updateTask(updatedTask);
    await loadTasks();
  }

  Future<void> deleteTask(Task task) async {
    await _repository.deleteTask(task.id);
    await loadTasks();
  }
}