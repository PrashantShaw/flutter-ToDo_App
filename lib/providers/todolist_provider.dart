import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/utils/local_db.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class TodoList extends Notifier<List<TodoModel>> {
  // static final TodoDatabase _hiveDB = TodoDatabase();
  @override
  List<TodoModel> build() {
    // _hiveDB.loadTodoList();
    // final initialData = _hiveDB.todoList;
    // print('INitail Data:: $initialData');
    // return initialData;
    return sampleTodoData;
  }

  void addTodo(String task) {
    if (task == '') return;

    TodoModel newTodo = TodoModel(id: uuid.v4(), task: task);
    List<TodoModel> updatedList = [...state, newTodo];
    // _hiveDB.updateTodoList(updatedList);
    state = updatedList;
  }

  void removeTodo(String id) {
    List<TodoModel> updatedList = state.where((todo) => todo.id != id).toList();
    // _hiveDB.updateTodoList(updatedList);
    state = updatedList;
  }

  void toggleStatus(String id) {
    List<TodoModel> updatedList = state
        .map((todo) => todo.id == id
            ? TodoModel(
                id: todo.id, task: todo.task, isComplete: !todo.isComplete)
            : todo)
        .toList();

    // _hiveDB.updateTodoList(updatedList);
    state = updatedList;
  }
}

final todoListProvider =
    NotifierProvider<TodoList, List<TodoModel>>(() => TodoList());
