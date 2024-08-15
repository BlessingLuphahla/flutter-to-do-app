import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/utils/redd_button.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final VoidCallback deleteTask;
  final VoidCallback editTask;

  const ToDoTile({
    super.key,
    required this.taskCompleted,
    required this.taskName,
    required this.onChanged,
    required this.deleteTask,
    required this.editTask,
  });

  static const double tilePadding = 18.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
            left: tilePadding, right: tilePadding, top: tilePadding),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(20),
                icon: Icons.edit,
                backgroundColor: Colors.blueAccent,
                onPressed: (context) {
                  editTask();
                },
              ),
              SlidableAction(
                borderRadius: BorderRadius.circular(20),
                icon: Icons.delete,
                backgroundColor: Colors.red,
                onPressed: (context) {
                  deleteTask();
                },
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    activeColor: Colors.deepPurpleAccent,
                    checkColor: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () {
                      const double dialogSize = 500;

                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: SizedBox(
                                width: dialogSize,
                                height: dialogSize + 50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      softWrap: true,
                                      taskName,
                                      style: TextStyle(
                                        decoration: taskCompleted
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ReddButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      buttonName: 'cancel',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Text(
                      softWrap: true,
                      taskName.length < 38
                          ? taskName.trim()
                          : '${taskName.trim().substring(0, 38)}...',
                      style: TextStyle(
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
