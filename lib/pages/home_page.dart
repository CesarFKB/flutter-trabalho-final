import 'package:flutter/material.dart';
import 'package:trabalho_final/widgets/app_bar_home.dart';
import 'package:trabalho_final/widgets/create_task_dialog.dart';
import 'package:trabalho_final/widgets/delete_dialog.dart';
import 'package:trabalho_final/widgets/task_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _list = [];
  final _textController = TextEditingController();
  final List<int> _ids = [];
  final Map<int, TaskContainer> _tasks = {};
  int _id = 0, _indiceNaoUsado = -1;
  bool _reorderCompleta = false;

  _createTask() {
    setState(() {
      _list.add(_textController.text);
      _ids.add(_id);
      _tasks[_id] = TaskContainer(
        key: Key(_id.toString()),
        name: _textController.text,
        funcaoDelete: _deleteTask,
      );
      // funcaoDelete: _deleteTask);
      _id++;
    });
    _textController.clear();
  }

  _deleteTask(String idCompleto) {
    int id = int.parse(_pegarId(idCompleto));
    showDialog(
        context: context,
        builder: (context) {
          return DeleteDialog(onConfirm: (value) {
            if (value == true) {
              setState(() {
                _list.remove(_tasks[id]?.name);
                _ids.remove(id);
                _tasks.remove(id);
              });
            }
          });
        });
  }

  _pegarId(String key) {
    String id = "";
    RegExp exp = RegExp(r"\d|_");
    Iterable<RegExpMatch> matches = exp.allMatches(key);
    for (final m in matches) {
      id += m.group(0)!;
    }
    return id.split('_')[0];
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  _itemsList(int index) {
    return ReorderableDelayedDragStartListener(
      key: ValueKey(_ids[index]),
      index: index,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _tasks[_ids[index]],
      ),
    );
  }

  _reordableListViewBuilder() {
    return ReorderableListView(
      buildDefaultDragHandles: false,
      proxyDecorator: (child, index, animation) => _draggedDecorator(
        child,
        index,
        animation,
      ),
      children: [
        for (final item in _ids) _itemsList(_ids.indexOf(item)),
      ],
      onReorder: (oldIndex, newIndex) {
        _reorderCompleta = true;
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = _ids.removeAt(oldIndex);
          _ids.insert(newIndex, item);
          _tasks[_ids[newIndex]]?.isDisabled = false;
        });
      },
      onReorderStart: (index) {
        _indiceNaoUsado = index;
        _reorderCompleta = false;
        setState(() {
          _tasks[_ids[index]]?.isDisabled = true;
        });
      },
      onReorderEnd: (index) {
        if (_reorderCompleta == false) {
          setState(() {
            _tasks[_ids[_indiceNaoUsado]]?.isDisabled = false;
          });
        }
      },
    );
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
