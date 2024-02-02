import 'package:hive/hive.dart';

class TodoDatabase {
  List todoList = [];

  void createInitialData() {
    todoList = [
      {'task': 'Wash the Cow', 'isComplete': false},
      {'task': 'Learn flutter', 'isComplete': true},
    ];
  }

  void loadTodoList() {
    Box box = Hive.box("todoBox");
    List? todos = box.get("TODO_DATABASE");

    if (todos == null) {
      createInitialData();
    } else {
      todoList = todos;
    }
  }

  void updateTodoList() {
    Hive.box("todoBox").put("TODO_DATABASE", todoList);
  }
}
