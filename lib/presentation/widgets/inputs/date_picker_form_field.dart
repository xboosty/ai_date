import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final Function(DateTime) onDateSelected;

  const DatePickerFormField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: 'Date',
        border: UnderlineInputBorder(
          // borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2023, 1, 1),
              lastDate: DateTime(2024, 12, 31),
            ).then((date) {
              if (date != null) {
                onDateSelected(date);
                controller.text = DateFormat.yMd().format(date);
              }
            });
          },
        ),
      ),
      controller: controller,
      keyboardType: TextInputType.datetime,
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2023, 1, 1),
          lastDate: DateTime(2024, 12, 31),
        ).then((date) {
          if (date != null) {
            onDateSelected(date);
            controller.text = DateFormat.yMd().format(date);
          }
        });
      },
    );
  }
}
