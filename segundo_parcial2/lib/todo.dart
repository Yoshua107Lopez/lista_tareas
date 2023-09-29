class Todo {
  String title;
  String description;
  bool completed;

  Todo({
    required this.title,
    required this.description,
    this.completed = false,
  }) {
    throw UnimplementedError();
  }
}
