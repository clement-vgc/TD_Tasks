class Todo {
  final int _id;
  final String _title;
  final bool _completed;

  Todo(this._id,this._title,this._completed);

  bool get completed => _completed;
  String get title => _title;
  int get id => _id;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      json['id'],
      json['title'],
      json['completed'],
    );
  }
}