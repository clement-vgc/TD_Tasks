import 'package:flutter/material.dart';
import '../models/task.dart';

class EcranDetail extends StatelessWidget {
  final Task task;

  const EcranDetail({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID: ${task.id}", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Text("Description:", style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(task.description),
            const SizedBox(height: 10),
            Text("Difficulté: ${task.difficuty}/10"),
            Text("Durée estimée: ${task.nbhours}h"),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8.0,
              children: task.tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}