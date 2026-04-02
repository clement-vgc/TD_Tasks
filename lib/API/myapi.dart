import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/task.dart';
import '../models/todo.dart';


class MyAPI{
  Future<List<Task>> getTasks() async{
    await Future.delayed(Duration(seconds: 1));
    final dataString = await _loadAsset('data/tasks.json');
    final Map<String,dynamic> json = jsonDecode(dataString);
    if (json['tasks']!=null){
      final tasks = <Task>[];
      json['tasks'].forEach((element){
        tasks.add(Task.fromJson(element));
      });
      return tasks;
    }else{
      return [];
    }
  }
  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
  Future<List<Todo>> getTodos() async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos')
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Erreur lors du chargement des Todos : ${response.statusCode}');
    }
  }
}