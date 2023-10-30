// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CreateTaskDialog extends StatefulWidget {
  final Function() funcao;
  final TextEditingController controller;
  const CreateTaskDialog(
      {super.key, required this.funcao, required this.controller});

  @override
  _CreateTaskDialogState createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  _textoTerminado() {
    widget.funcao();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.create),
          SizedBox(width: 20),
          Text('To-Do List'),
        ],
      ),
      content: TextField(
        autofocus: true,
        onSubmitted: (v) => _textoTerminado(),
        controller: widget.controller,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Voltar'),
        ),
        TextButton(
          onPressed: _textoTerminado,
          child: const Text('Criar'),
        ),
      ],
    );
  }
}
