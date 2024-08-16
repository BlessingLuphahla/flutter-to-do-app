import 'package:flutter/material.dart';
import 'package:to_do_app/utils/dialog_box.dart';
import 'package:to_do_app/utils/to_do_tile.dart';
import 'package:to_do_app/data/to_do_database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    ButtonStyle buttonStyle() {
      return ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
          foregroundColor: WidgetStateColor.resolveWith((_) {
            return Colors.white;
          }),
          backgroundColor: WidgetStateColor.resolveWith((_) {
            return Colors.purple;
          }));
    }

    const sizedBoxHeight = SizedBox(
      height: 30,
    );

    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                style: buttonStyle(),
                child: const Text('Call Me'),
                onPressed: () {
                  launchUrl(Uri.parse('tel:+263788793302'),
                      mode: LaunchMode.externalApplication);
                }),
            sizedBoxHeight,
            ElevatedButton(
                style: buttonStyle(),
                child: const Text('Contact Me On Email'),
                onPressed: () {
                  launchUrl(
                      Uri.parse(
                          'mailto: luphahlablessingthamsanqa@gmail.com?subject=Business&body=Hey Dynamic Digital Design can you'),
                      mode: LaunchMode.externalApplication);
                }),
            sizedBoxHeight,
            ElevatedButton(
                style: buttonStyle(),
                child: const Text('Connect With Me On Whatsapp'),
                onPressed: () {
                  launchUrl(
                      Uri.parse('https://wa.me/263788793302?text=Hey REDD AXE'),
                      mode: LaunchMode.externalApplication);
                }),
            sizedBoxHeight,
            const Text(
              'contact the developer',
              style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: const Color.fromRGBO(24, 24, 80, 1),
        elevation: 0,
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text('REDD AXE'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (_, index) {
          return ToDoTile(
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
