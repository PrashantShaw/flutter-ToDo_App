class TodoModel {
  late String id;
  late String task;
  late bool isComplete;

  TodoModel({
    required this.id,
    required this.task,
    this.isComplete = false,
  });
}
