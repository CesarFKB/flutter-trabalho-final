import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final/widgets/app_bar_home.dart';
import 'package:trabalho_final/widgets/create_task_dialog.dart';
import 'package:trabalho_final/widgets/task_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _list = [];
  final _textController = TextEditingController();
  final List<int> _IDs = [];
  final Map<int, TaskContainer> _tasks = {};
  int _ID = 0;

  // _createTask() {
  //   setState(() {
  //     _list.add(_textController.text);
  //   });
  //   _textController.clear();
  // }

  _createTask() {
    setState(() {
      _list.add(_textController.text);
      _IDs.add(_ID);
      _tasks[_ID] = TaskContainer(
        name: _textController.text,
      );
      _ID++;
    });
    _textController.clear();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // _itemsList(int index) {
  //   return ReorderableDelayedDragStartListener(
  //     key: ValueKey(_list[index]),
  //     index: index,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: TaskContainer(
  //         name: _list[index],
  //       ),
  //     ),
  //   );
  // }

  _itemsList(int index) {
    return ReorderableDelayedDragStartListener(
      key: ValueKey(_IDs[index]),
      index: index,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _tasks[_IDs[index]],
      ),
    );
  }

  _reordableTest() {
    return ReorderableListView(
        buildDefaultDragHandles: false,
        proxyDecorator: (child, index, animation) => _draggedDecorator(
              child,
              index,
              animation,
            ),
        children: [
          for (final item in _IDs) _itemsList(_IDs.indexOf(item)),
        ],
        onReorder: (oldIndex, newIndex) {
          print("TESTE");
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = _IDs.removeAt(oldIndex);
            _IDs.insert(newIndex, item);
            _tasks[_IDs[newIndex]]?.setDisabled = false;
          });
        },
        onReorderStart: (index) {
          setState(() {
            _tasks[_IDs[index]]?.setDisabled = true;
          });
        });
  }

  _draggedDecorator(Widget child, int index, Animation<double> animation) {
    return Material(
        color: Colors.transparent,
        child: ScaleTransition(
            scale: animation.drive(
              Tween<double>(begin: 1, end: 1.1)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child));
  }

  _reordableListViewBuilder() {
    return ReorderableListView.builder(
      proxyDecorator: (child, index, animation) =>
          _draggedDecorator(child, index, animation),
      buildDefaultDragHandles: false,
      dragStartBehavior: DragStartBehavior.start,
      itemCount: _list.length,
      itemBuilder: (context, index) {
        return _itemsList(index);
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
                child: _reordableTest(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context) => CreateTaskDialog(
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
