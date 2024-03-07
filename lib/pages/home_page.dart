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

  // TodoDatabase localDB = TodoDatabase();

  // @override
  // void initState() {
  //   localDB.loadTodoList();
  //   super.initState();
  // }

  // void changeIsComplete(bool? state, int idx) {
  //   setState(() {
  //     var todoItem = localDB.todoList[idx];
  //     bool prevState = todoItem['isComplete'];
  //     todoItem['isComplete'] = !prevState;
  //   });
  //   localDB.updateTodoList();
  // }

  // void saveNewTask() {
  //   String task = taskInputController.text;

  //   if (task == '') return;

  //   Map newTask = {'task': task, 'isComplete': false};

  //   setState(() {
  //     localDB.todoList.add(newTask);
  //   });
  //   localDB.updateTodoList();

  //   Navigator.of(context).pop();
  //   taskInputController.clear();
  // }

  // void onTaskDelete(BuildContext buildCtx, int index) {
  //   setState(() {
  //     localDB.todoList.removeAt(index);
  //   });
  //   localDB.updateTodoList();
  // }

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
    final List<TodoModel> todoList = ref.watch(todoListProvider);

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: homeAppBar(),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          TodoModel todoItem = todoList[index];
          return TodoItem(
            colorScheme: colorScheme,
            task: todoItem.task,
            isComplete: todoItem.isComplete,
            onStatusChanged: (state) =>
                todoListActions.toggleStatus(todoItem.id),
            onDelete: (ctx) => todoListActions.removeTodo(todoItem.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showTaskInputDialog(context, todoListActions.addTodo),
        tooltip: "Add ToDo",
        foregroundColor: colorScheme.tertiary,
        child: Icon(Icons.add),
      ),
    );
  }
}
