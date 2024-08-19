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

  List searchResults = [];
  bool isSearching = false;

  void onSearch(String value) {
    setState(() {
      if (value.isEmpty) {
        isSearching = false;
        searchResults.clear();
      } else {
        isSearching = true;
        searchResults = db.toDoList.where((task) {
          String taskName = task[0].toString().toLowerCase();
          return taskName.contains(value.toLowerCase());
        }).toList();
      }
    });
  }

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

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      db.updateDatabase();
    });
  }

  void editTask(int index) {
    _editController.text = db.toDoList[index]
        [0]; // Load current task name into the edit controller

    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            isDarkMode: widget.isDarkMode,
            hintText: 'Edit Task',
            controller: _editController,
            onSaved: () {
              setState(() {
                db.toDoList[index][0] = _editController.text;
                db.updateDatabase();
                _editController.clear();
              });
              Navigator.of(context).pop();
            },
            onCancelled: () {
              Navigator.of(context).pop();
            },
          );
        });
  }

  void sortTasks(String criteria) {
    setState(() {
      if (criteria == 'Name') {
        db.toDoList.sort((a, b) => a[0].compareTo(b[0]));
      } else if (criteria == 'Status') {
        db.toDoList.sort((a, b) => a[1] ? 1 : -1); // Sort by completion status
      }
      db.updateDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    var listToDisplay = isSearching ? searchResults : db.toDoList;

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
        toolbarHeight: 90,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            const Text(
              'REDD AXE',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              width: 20,
            ),

            PopupMenuButton<String>(
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  value: 'Search',
                  child: Container(
                    width: 300, // Increased width for search bar
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Search bar inside the dropdown
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                            ),
                            onChanged: (value) => onSearch(value),
                          ),
                        ),
                        // Sort by dropdown inside the dropdown
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: DropdownButton<String>(
                            hint: const Text('Sort by'),
                            isExpanded: true, // Expand to fill available width
                            items: ['Name', 'Status'].map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                sortTasks(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Theme',
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text('Dark Mode'),
                        const Spacer(),
                        // Switch inside the dropdown
                        Switch(
                          value: widget.isDarkMode,
                          onChanged: (bool newValue) {
                            Navigator.pop(context); // Close the dropdown
                            widget.toggleTheme(
                                newValue); // Toggle theme immediately
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  onTap: () {
                    setState(() {
                      isSearching = false;
                      searchResults.clear();
                      listToDisplay = db.toDoList;
                    });
                  },
                  value: 'reset',
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Row(
                      children: [
                        Spacer(),
                        // Switch inside the dropdown
                        Icon(
                          Icons.restore,
                          size: 30,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Reset Search',
                          style: TextStyle(fontSize: 15),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
              // Adjust width of the dropdown menu
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Row(
                  children: [
                    Text(
                      'Options',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: listToDisplay.length,
        itemBuilder: (_, index) {
          return ToDoTile(
            isDarkMode: widget.isDarkMode,
            taskName: listToDisplay[index][0],
            taskCompleted: listToDisplay[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: () => deleteTask(index),
            editTask: () => editTask(index),
          );
        },
      ),
    );
  }
}
