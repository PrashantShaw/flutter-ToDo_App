// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoItem extends StatelessWidget {
  final ColorScheme colorScheme;
  final String task;
  final bool isComplete;
  final void Function(bool?)? onStatusChanged;
  final void Function(BuildContext) onDelete;

  TodoItem({
    super.key,
    required this.colorScheme,
    required this.task,
    required this.isComplete,
    required this.onStatusChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          // padding: EdgeInsets.all(24),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(12.0)),
          child: Row(
            children: [
              Checkbox(
                value: isComplete,
                onChanged: onStatusChanged,
                activeColor: Colors.green,
              ),
              Text(
                task,
                style: TextStyle(
                  decoration: isComplete
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
