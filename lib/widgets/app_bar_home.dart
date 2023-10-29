import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  const AppBarHome({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_note),
          SizedBox(width: 10),
          Text('To-Do List'),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
      toolbarHeight: MediaQuery.of(context).size.height * 0.075,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(MediaQuery.of(context).size.height * 0.075);
}
