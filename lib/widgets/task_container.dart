import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  final String text;

  const TaskContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 1,
            offset: const Offset(4, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepPurple,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          const Row(
            children: [
              Icon(Icons.done, color: Colors.white),
              SizedBox(width: 10),
              Icon(Icons.delete, color: Colors.white),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
