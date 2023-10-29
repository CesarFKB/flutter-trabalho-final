import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final/widgets/app_bar_home.dart';
import 'package:trabalho_final/widgets/dialog_text.dart';
import 'package:trabalho_final/widgets/task_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _list = [];

  final _textController = TextEditingController();

  _onPressed(String val) {
    setState(() {
      _list.add(val);
    });
  }

  _createTask() {
    _onPressed(_textController.text);
    _textController.clear();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  _listViewBuilder() {
    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TaskContainer(text: _list[index]),
        );
      },
    );
  }

  _reordableListViewBuilder() {
    return ReorderableListView.builder(
      proxyDecorator: (child, index, animation) => child,
      buildDefaultDragHandles: false,
      dragStartBehavior: DragStartBehavior.start,
      itemCount: _list.length,
      itemBuilder: (context, index) {
        return ReorderableDragStartListener(
            key: ValueKey(_list[index]),
            index: index,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TaskContainer(text: _list[index]),
            ));
        // return Padding(
        //   key: ValueKey(_list[index]),
        //   padding: const EdgeInsets.all(8.0),
        //   child: TaskContainer(text: _list[index]),
        // );
      },
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = _list.removeAt(oldIndex);
          _list.insert(newIndex, item);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHome(
        context: context,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Center(
                child: _reordableListViewBuilder(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context) => DialogText(
                  funcao: _createTask,
                  controller: _textController,
                )),
        backgroundColor: Colors.deepPurple,
        tooltip: "add",
        child: const Icon(Icons.add),
      ),
    );
  }
}
