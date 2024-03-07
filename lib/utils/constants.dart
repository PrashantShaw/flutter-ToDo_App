import 'package:todo_app/models/todo_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Constants {
  static const String hiveTodoDb = "todoBox";
  static const String todoHiveName = "todoBox";
}

final sampleTodoData = [
  TodoModel(id: uuid.v4(), task: "Wash the Cow"),
  TodoModel(id: uuid.v4(), task: "Learn flutter", isComplete: true),
];
