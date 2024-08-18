import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/utils/redd_button.dart';

class ToDoTile extends StatefulWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final VoidCallback deleteTask;
  final VoidCallback editTask;
  final bool isDarkMode;

  const ToDoTile({
    super.key,
    required this.taskCompleted,
    required this.taskName,
    required this.onChanged,
    required this.deleteTask,
    required this.editTask,
    required this.isDarkMode,
  });

  static const double tilePadding = 18.0;

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: ToDoTile.tilePadding,
          right: ToDoTile.tilePadding,
          top: ToDoTile.tilePadding,
        ),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(20),
                icon: Icons.edit,
                backgroundColor: Colors.blueAccent,
                onPressed: (context) {
                  widget.editTask();
                },
              ),
              SlidableAction(
                borderRadius: BorderRadius.circular(20),
                icon: Icons.delete,
                backgroundColor: Colors.red,
                onPressed: (context) {
                  widget.deleteTask();
                },
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(12)),
              child: Expanded(
  child: Row(
    children: [
      Checkbox(
        value: widget.taskCompleted,
        onChanged: widget.onChanged,
        activeColor: Colors.deepPurpleAccent,
        checkColor: Colors.black,
      ),
      Flexible(
        child: GestureDetector(
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
                          widget.taskName,
                          softWrap: true,
                          style: TextStyle(
                            decoration: widget.taskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ReddButton(
                          isDarkMode: widget.isDarkMode,
                          onPressed: () => Navigator.of(context).pop(),
                          buttonName: 'cancel',
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              widget.taskName.length < 38
                  ? widget.taskName.trim()
                  : '${widget.taskName.trim().substring(0, 38)}...',
              style: TextStyle(
                color: Colors.white,
                decoration: widget.taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    ],
  ),
),

            ),
          ),
        ),
      ),
    );
  }
}
