import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String hintText;
  final Icon? hintIcon;
  final Color? fillColor;
  final Color? textColor;
  final bool isCentered;

  const AppButton({
    Key? key,
    this.onPressed,
    required this.hintText,
    this.hintIcon,
    this.fillColor,
    this.textColor,
    this.isCentered = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(
            color: Colors.transparent,
            width: 2.0,
          ),
        ),
        primary: fillColor ?? const Color(0xFFF0F2F1),
        padding: const EdgeInsets.all(20.0),
        elevation: 0.0,
      ),
      child: Row(
        mainAxisAlignment: isCentered
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            hintText,
            style: TextStyle(
              color: textColor ?? Colors.grey,
            ),
          ),
          hintIcon != null ? hintIcon! : Container(),
        ],
      ),
    );
  }
}
