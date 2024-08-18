import 'package:flutter/material.dart';
import 'package:to_do_app/utils/dialog_box.dart';
import 'package:to_do_app/utils/redd_drawer.dart';
import 'package:to_do_app/utils/to_do_tile.dart';
import 'package:to_do_app/data/to_do_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;

  const HomePage(
      {super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _toDoBox = Hive.box('ToDoBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_toDoBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.LoadData();
    }

    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _editController = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = value;
      db.updateDatabase();
    });
  }

  void saveNewTask() {
    setState(() {
      String newTask = _controller.text;
      if (newTask.isNotEmpty) {
        db.toDoList.add([newTask, false]);
        _controller.clear();
        db.updateDatabase();
      }
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            isDarkMode: widget.isDarkMode,
            hintText: 'Add new Task',
            controller: _controller,
            onSaved: saveNewTask,
            onCancelled: () {
              Navigator.of(context).pop();
            },
          );
        });

    return;
  }

  void deleteTask(index) {
    setState(() {
      db.toDoList.removeAt(index);
      db.updateDatabase();
    });
  }

  void editTask(index) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            isDarkMode: widget.isDarkMode,
            hintText: 'Edit Task',
            controller: _editController,
            onSaved: () => {
              setState(() {
                db.toDoList[index][0] = _editController.text;
                db.updateDatabase();
                _editController.clear();
                Navigator.of(context).pop();
              })
            },
            onCancelled: () {
              Navigator.of(context).pop();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ReddDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: widget.isDarkMode
            ? const Color.fromRGBO(24, 24, 80, 1)
            : Colors.white,
        elevation: 0,
        child: Icon(
          Icons.add,
          color: widget.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      appBar: AppBar(
        title: const Text('REDD AXE'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: widget.toggleTheme,
          ),
          SizedBox(
            width: 30,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (_, index) {
          return ToDoTile(
            isDarkMode: widget.isDarkMode,
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: () => deleteTask(index),
            editTask: () => editTask(index),
          );
        },
      ),
    );
  }
}
