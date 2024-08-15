import 'package:flutter/material.dart';
import 'package:to_do_app/utils/redd_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  final VoidCallback onSaved;
  final VoidCallback onCancelled;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSaved,
    required this.onCancelled,
    this.hintText = 'Please Enter Text Here',
  });

  static const double dialogSize = 150;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: dialogSize,
        height: dialogSize + 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: hintText,
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
                  onPressed: onSaved,
                  buttonName: 'save',
                ),
                ReddButton(
                  onPressed: onCancelled,
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
