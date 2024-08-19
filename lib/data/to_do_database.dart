import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  final _toDoBox = Hive.box('ToDoBox');

  // run this function if its first time ever opening this app

  void createInitialData() {
    toDoList = [
      ["Slide A Task For More Options", false],
      ["Check task to cross it out like this", true],
      ["click on the task for more information", false],
    ];
  }

  void updateDatabase() {
    _toDoBox.put('TODOLIST', toDoList);
  }

  void LoadData() {
    toDoList = _toDoBox.get('TODOLIST');
  }
}
