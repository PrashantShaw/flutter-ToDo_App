import 'package:hive/hive.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:uuid/uuid.dart';

class TodosApi {
  // private attributes
  static const _uuid = Uuid();
  static final Box _box = Hive.box(Constants.todoHiveName);
  static late List<TodoModel> _todoList;

  // get all todos
  static Future<List<TodoModel>> fetchTodos() async {
    List<dynamic>? todos = await _box.get(Constants.hiveTodoDb);

    if (todos == null) {
      _todoList = sampleTodoData;
      await _box.put(Constants.hiveTodoDb, _todoList);
    } else {
      _todoList = todos.cast<TodoModel>();
    }
    return _todoList;
  }

  // add a todo
  static Future<List<TodoModel>> addTodo(String task) async {
    TodoModel newTodo = TodoModel(id: _uuid.v4(), task: task);
    await _box.put(Constants.hiveTodoDb, [..._todoList, newTodo]);

    List<TodoModel> updatedList = [..._todoList, newTodo];
    _todoList = updatedList;
    return updatedList;
  }

  // remove a todo
  static Future<List<TodoModel>> removeTodo(String id) async {
    List<TodoModel> updatedList =
        _todoList.where((todo) => todo.id != id).toList();
    await _box.put(Constants.hiveTodoDb, updatedList);

    _todoList = updatedList;
    return _todoList;
  }

  // toggle todo state
  static Future<List<TodoModel>> toggleStatus(String id) async {
    List<TodoModel> updatedList = _todoList
        .map((todo) => todo.id == id
            ? TodoModel(
                id: todo.id, task: todo.task, isComplete: !todo.isComplete)
            : todo)
        .toList();
    await _box.put(Constants.hiveTodoDb, updatedList);

    _todoList = updatedList;
    return _todoList;
  }
}
