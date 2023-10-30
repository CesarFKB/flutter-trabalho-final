import 'package:flutter/material.dart';
import 'package:trabalho_final/widgets/custom_icon_button.dart';

class TaskContainer extends StatefulWidget {
  bool isDisabled;
  final String name;
  final Function(String) funcaoDelete;
  TaskContainer(
      {super.key,
      required this.name,
      this.isDisabled = false,
      required this.funcaoDelete});

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 5,
            offset: const Offset(3, 5),
          ),
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.0),
              Text(
                'Teste Inline',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        CustomIconButton(
          key: Key("${widget.key}_1"),
          isDisabled: widget.isDisabled,
          icon: Icons.done,
          funcao: (e) => print("Done"),
        ),
        const SizedBox(width: 16.0),
        CustomIconButton(
            key: Key("${widget.key}_2"),
            isDisabled: widget.isDisabled,
            icon: Icons.delete,
            funcao: widget.funcaoDelete),
      ]),
    );
  }
}
