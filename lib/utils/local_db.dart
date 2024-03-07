import 'package:hive/hive.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class TodoDatabase {
  List<TodoModel> todoList = [];

  void createInitialData() {
    todoList = sampleTodoData;
  }

  void loadTodoList() async {
    Box box = Hive.box(Constants.todoHiveName);
    // box.clear();
    List<TodoModel>? todos = await box.get(Constants.hiveTodoDb);
    print('&&&&&&&&&&&&&&&&&&&&&&&&& $todos');

    if (todos == null) {
      createInitialData();
    } else {
      todoList = todos;
    }
  }

  void updateTodoList(updatedList) {
    todoList = updatedList;
    Hive.box(Constants.todoHiveName).put(Constants.hiveTodoDb, todoList);
  }
}
