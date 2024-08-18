import 'package:flutter/material.dart';
import 'package:to_do_app/utils/redd_button.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  final VoidCallback onSaved;
  final bool isDarkMode;
  final VoidCallback onCancelled;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSaved,
    required this.isDarkMode,
    required this.onCancelled,
    this.hintText = 'Please Enter Text Here',
  });

  static const double dialogSize = 150;

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: DialogBox.dialogSize,
        height: DialogBox.dialogSize + 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(
              height: 75,
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ReddButton(
                  isDarkMode: widget.isDarkMode,
                  onPressed: widget.onSaved,
                  buttonName: 'save',
                ),
                ReddButton(
                  isDarkMode: widget.isDarkMode,
                  onPressed: widget.onCancelled,
                  buttonName: 'cancel',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
