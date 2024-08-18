import 'package:flutter/material.dart';

class ReddButton extends StatefulWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final bool isDarkMode;

  static const double buttonSize = 60;

  const ReddButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    required this.isDarkMode,
  });

  @override
  State<ReddButton> createState() => _ReddButtonState();
}

class _ReddButtonState extends State<ReddButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor: widget.isDarkMode? Colors.black:Colors.white,
      onPressed: widget.onPressed,
      color: widget.isDarkMode? Colors.white:Colors.black,
      animationDuration: Durations.long2,
      elevation: 0,
      height: ReddButton.buttonSize,
      padding:
          const EdgeInsets.only(right: ReddButton.buttonSize / 2, left: ReddButton.buttonSize / 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Text(widget.buttonName),
    );
  }
}
