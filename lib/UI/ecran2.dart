import 'package:flutter/material.dart';
import '../models/task.dart';
import 'detail.dart';

class Ecran2 extends StatelessWidget {
  const Ecran2({super.key});

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Task.generateTask(50);

    return Scaffold(
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            color: Colors.white,
            elevation: 7,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(child: Text("${task.id}")),
              title: Text(
                task.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EcranDetail(task: task),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}