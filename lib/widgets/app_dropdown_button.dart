import 'package:flutter/material.dart';

import 'app_text_field_border.dart';

class AppDropdownButton extends StatelessWidget {
  final List items;
  final void Function(String?) onChanged;

  const AppDropdownButton({
    Key? key,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: items[0],
      items: items
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(
                e,
                textAlign: TextAlign.left,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      isDense: true,
      elevation: 1,
      decoration: InputDecoration(
        enabledBorder: enabledTextFieldBorder,
        focusedBorder: enabledTextFieldBorder,
        fillColor: const Color(0xFFF0F2F1),
        filled: true,
      ),
      dropdownColor: Colors.white,
      icon: const Icon(
        Icons.dehaze,
        color: Colors.grey,
      ),
      isExpanded: true,
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}
