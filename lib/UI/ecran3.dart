import 'package:flutter/material.dart';
import '../API/myapi.dart';
import '../models/task.dart';
import 'detail.dart';

class Ecran3 extends StatelessWidget {
  const Ecran3({super.key});

  @override
  Widget build(BuildContext context) {
    final MyAPI api = MyAPI();

    return Scaffold(
      body: FutureBuilder<List<Task>>(
        future: api.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucune tâche trouvée."));
          }

          final tasks = snapshot.data!;

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(child: Text("${task.id}")),
                  title: Text(task.title),
                  subtitle: Text("Tags: ${task.tags.join(', ')}"),
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
          );
        },
      ),
    );
  }
}