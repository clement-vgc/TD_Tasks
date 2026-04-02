import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../viewmodels/task_view_model.dart';

class AddTask extends StatefulWidget {
  final Task? taskToEdit;
  const AddTask({super.key, this.taskToEdit});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _hoursController;
  late double _currentDifficulty;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.taskToEdit?.title ?? "");
    _descriptionController = TextEditingController(text: widget.taskToEdit?.description ?? "");
    _hoursController = TextEditingController(text: widget.taskToEdit?.nbhours.toString() ?? "");
    _currentDifficulty = widget.taskToEdit?.difficuty.toDouble() ?? 1.0;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.taskToEdit != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Édition' : 'Ajout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Titre (3-15)'),
                validator: (value) {
                  if (value == null || value.length < 3 || value.length > 15) {
                    return 'Entre 3 et 15 caractères';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => (value == null || value.isEmpty) ? 'Requis' : null,
              ),
              TextFormField(
                controller: _hoursController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Heures'),
                validator: (value) => (value == null || int.tryParse(value) == null) ? 'Nombre requis' : null,
              ),
              const SizedBox(height: 20),

              Text("Difficulté : ${_currentDifficulty.round()}"),

              Slider(
                value: _currentDifficulty,
                min: 1, max: 5, divisions: 4,
                label: _currentDifficulty.round().toString(),
                onChanged: (v) => setState(() => _currentDifficulty = v),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final task = Task(
                      id: isEditing ? widget.taskToEdit!.id : 0,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      tags: isEditing ? widget.taskToEdit!.tags : ['Nouveau'],
                      nbhours: int.parse(_hoursController.text),
                      difficuty: _currentDifficulty.round(),
                    );

                    if (isEditing) {
                      context.read<TaskViewModel>().updateTask(task);
                    } else {
                      context.read<TaskViewModel>().addTask(task);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(isEditing ? 'Modifier' : 'Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}