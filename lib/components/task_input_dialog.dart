// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app/components/action_button.dart';

class TaskInputDialog extends StatelessWidget {
  final TextEditingController taskInputController;
  final VoidCallback saveNewTask;
  final VoidCallback onCancel;

  const TaskInputDialog({
    super.key,
    required this.taskInputController,
    required this.saveNewTask,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Enter Task"),
      content: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: taskInputController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  // labelText: "Add some task here",
                  hintText: "Add a new task here"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionButton(
                  name: "Save",
                  onPressed: saveNewTask,
                ),
                ActionButton(
                  name: "Cancel",
                  onPressed: onCancel,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
