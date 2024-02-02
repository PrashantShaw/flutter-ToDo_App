// ignore_for_file: prefer_const_constructors

// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/components/app_bar.dart';
import 'package:todo_app/components/task_input_dialog.dart';
import 'package:todo_app/components/todo_item.dart';
import 'package:todo_app/utils/local_db.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController taskInputController = TextEditingController();

  TodoDatabase localDB = TodoDatabase();

  @override
  void initState() {
    localDB.loadTodoList();
    super.initState();
  }

  void changeIsComplete(bool? state, int idx) {
    setState(() {
      var todoItem = localDB.todoList[idx];
      bool prevState = todoItem['isComplete'];
      todoItem['isComplete'] = !prevState;
    });
    localDB.updateTodoList();
  }

  void saveNewTask() {
    String task = taskInputController.text;

    if (task == '') return;

    Map newTask = {'task': task, 'isComplete': false};

    setState(() {
      localDB.todoList.add(newTask);
    });
    localDB.updateTodoList();

    Navigator.of(context).pop();
    taskInputController.clear();
  }

  void onCancel() {
    Navigator.of(context).pop();
    taskInputController.clear();
  }

  Future<void> showTaskInputDialog() async {
    // String todoListStringified = jsonEncode(localDB.todoList);
    // List todoListParsed = jsonDecode(todoListStringified);

    await showDialog(
      context: context,
      builder: (context) {
        return TaskInputDialog(
          taskInputController: taskInputController,
          saveNewTask: saveNewTask,
          onCancel: onCancel,
        );
      },
    );
  }

  void onTaskDelete(BuildContext buildCtx, int index) {
    setState(() {
      localDB.todoList.removeAt(index);
    });
    localDB.updateTodoList();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: homeAppBar(colorScheme, context),
      body: ListView.builder(
        itemCount: localDB.todoList.length,
        itemBuilder: (context, index) {
          var todoItem = localDB.todoList[index];
          return TodoItem(
            colorScheme: colorScheme,
            task: todoItem['task'],
            isComplete: todoItem['isComplete'],
            onChanged: (state) => changeIsComplete(state, index),
            onDelete: (buildCtx) => onTaskDelete(buildCtx, index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showTaskInputDialog,
        tooltip: "Add ToDo",
        foregroundColor: colorScheme.tertiary,
        child: Icon(Icons.add),
      ),
    );
  }
}
