import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/apis/todos_api.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoList extends AsyncNotifier<List<TodoModel>> {
  @override
  Future<List<TodoModel>> build() async {
    List<TodoModel> todos = await TodosApi.fetchTodos();
    return todos;
  }

  Future<void> addTodo(String task) async {
    try {
      state = const AsyncValue.loading();
      List<TodoModel> todos = await TodosApi.addTodo(task);
      state = AsyncValue.data(todos);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> toggleTodoState(String id) async {
    try {
      state = const AsyncValue.loading();
      List<TodoModel> todos = await TodosApi.toggleStatus(id);
      state = AsyncValue.data(todos);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> removeTodo(String id) async {
    try {
      state = const AsyncValue.loading();
      List<TodoModel> todos = await TodosApi.removeTodo(id);
      state = AsyncValue.data(todos);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final todoListProvider =
    AsyncNotifierProvider<TodoList, List<TodoModel>>(() => TodoList());
