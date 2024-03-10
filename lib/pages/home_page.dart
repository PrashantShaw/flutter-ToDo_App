// ignore_for_file: prefer_const_constructors

// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/components/app_bar.dart';
import 'package:todo_app/components/task_input_dialog.dart';
import 'package:todo_app/components/todo_item.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/todolist_provider.dart';
// import 'package:todo_app/utils/local_db.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final TextEditingController taskInputController = TextEditingController();

  void saveNewTask(BuildContext context, Function addTask) {
    addTask(taskInputController.text);
    closeInputDialog(context);
  }

  void closeInputDialog(BuildContext context) {
    Navigator.of(context).pop();
    taskInputController.clear();
  }

  Future<void> showTaskInputDialog(
    BuildContext context,
    Function addTask,
  ) async {
    await showDialog(
      context: context,
      builder: (context) {
        return TaskInputDialog(
          taskInputController: taskInputController,
          saveNewTask: () => saveNewTask(context, addTask),
          onCancel: () => closeInputDialog(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TodoList todoListActions = ref.read(todoListProvider.notifier);
    final AsyncValue<List<TodoModel>> asyncTodoList =
        ref.watch(todoListProvider);

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: homeAppBar(),
      body: widgetToRender(asyncTodoList, todoListActions),
      floatingActionButton: addTodoFloatingBtn(context, todoListActions),
    );
  }

  Widget widgetToRender(
      AsyncValue<List<TodoModel>> asyncTodoList, TodoList todoListActions) {
    Widget toRender = asyncTodoList.when(
      data: (todoList) => todoListWrapper(todoList, todoListActions),
      error: (error, stack) =>
          Text('Oops, something unexpected happened $error'),
      loading: () => CircularProgressIndicator(),
    );

    return toRender;
  }

  FloatingActionButton addTodoFloatingBtn(
      BuildContext context, TodoList todoListActions) {
    return FloatingActionButton(
      onPressed: () => showTaskInputDialog(context, todoListActions.addTodo),
      tooltip: "Add ToDo",
      foregroundColor: Theme.of(context).colorScheme.tertiary,
      child: Icon(Icons.add),
    );
  }

  ListView todoListWrapper(List<TodoModel> todoList, TodoList todoListActions) {
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        TodoModel todoItem = todoList[index];
        return TodoItem(
          colorScheme: Theme.of(context).colorScheme,
          task: todoItem.task,
          isComplete: todoItem.isComplete,
          onStatusChanged: (state) =>
              todoListActions.toggleTodoState(todoItem.id),
          onDelete: (ctx) => todoListActions.removeTodo(todoItem.id),
        );
      },
    );
  }
}
