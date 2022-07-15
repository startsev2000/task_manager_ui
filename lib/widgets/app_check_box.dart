import 'package:flutter/material.dart';

class AppCheckBox extends StatefulWidget {
  bool isChecked;
  final VoidCallback onPressed;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? borderColor;

  AppCheckBox({
    Key? key,
    required this.isChecked,
    required this.onPressed,
    this.selectedColor,
    this.unselectedColor,
    this.borderColor,
  }) : super(key: key);

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isChecked = !widget.isChecked;
          widget.onPressed();
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 30.0,
        width: 15.0,
        decoration: BoxDecoration(
          color:
              widget.isChecked ? widget.selectedColor : widget.unselectedColor,
          borderRadius: BorderRadius.circular(2.0),
          border: Border.all(
            color: widget.borderColor ?? Colors.grey,
          ),
        ),
      ),
    );
  }
}
