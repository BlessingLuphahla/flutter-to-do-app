import 'package:flutter/material.dart';

class ReddButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;

  static const double buttonSize = 60;

  const ReddButton(
      {super.key, required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.black,
      animationDuration: Durations.long2,
      elevation: 0,
      height: buttonSize,
      padding: const EdgeInsets.only(right: buttonSize / 2, left: buttonSize / 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Text(buttonName),
    );
  }
}
