// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String name;
  final void Function()? onPressed;
  const ActionButton({
    super.key,
    required this.name,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        name,
        style: TextStyle(color: colorScheme.tertiary),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colorScheme.primary),
          fixedSize: MaterialStatePropertyAll(Size.fromWidth(100))),
    );
  }
}
