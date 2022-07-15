import 'package:flutter/material.dart';
import 'package:test_task_flutter/widgets/app_text_field_border.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? hintText;

  const AppTextField({Key? key, required this.textEditingController, this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        enabledBorder: enabledTextFieldBorder,
        focusedBorder: enabledTextFieldBorder,
        contentPadding: const EdgeInsets.all(20.0),
        fillColor: const Color(0xFFF0F2F1),
        filled: true,
      ),
    );
  }
}
