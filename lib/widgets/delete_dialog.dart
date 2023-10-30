import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final Function(bool) onConfirm;

  const DeleteDialog({Key? key, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Task'),
      content: const Text('Are you sure you want to delete this task?'),
      actions: [
        TextButton(
          onPressed: () {
            onConfirm(false);
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm(true);
            Navigator.of(context).pop();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
