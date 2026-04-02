class Task {
  int id;
  String title;
  List<String> tags;
  int nbhours;
  int difficuty;
  String description;

  Task({
    required this.id,
    required this.title,
    required this.tags,
    required this.nbhours,
    required this.difficuty,
    required this.description
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      tags: List<String>.from(json['tags']),
      nbhours: json['nbhours'] ?? 0,
      difficuty: json['difficuty'] ?? 0,
      description: json['description'] ?? '',
    );
  }

  static List<Task> generateTask(int i) {
    List<Task> tasks = [];
    for (int n = 1; n <= i; n++) {
      tasks.add(Task(
          id: n,
          title: "Tâche $n",
          tags: ['tag $n', 'tag ${n + 1}'],
          nbhours: n%10+1,
          difficuty: n%5+1,
          description: 'Description de la tâche $n'
      ));
    }
    return tasks;
  }

  Map<String, dynamic> toMap() {
  return {
  'id': id,
  'title': title,
  'description': description,
  'nbhours': nbhours,
  'difficuty': difficuty,
  };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
  return Task(
  id: map['id'],
  title: map['title'],
  description: map['description'],
  nbhours: map['nbhours'],
  difficuty: map['difficuty'],
  tags: ['Local'],
  );
  }
}