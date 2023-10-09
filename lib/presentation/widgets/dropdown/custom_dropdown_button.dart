import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final List<T> listValues;
  final T dropdownValue;
  final ValueChanged<T?>? onChanged;
  final Widget? hintText;

  const CustomDropdownButton({
    super.key,
    required this.listValues,
    required this.dropdownValue,
    required this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.90,
      child: DropdownButton<T>(
        value: dropdownValue,
        hint: hintText,
        items: listValues.map<DropdownMenuItem<T>>((T item) {
          return DropdownMenuItem<T>(
            alignment: Alignment.centerLeft,
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
        onChanged: onChanged,
        underline: Container(
          height: 2,
          width: double.infinity,
          color: Colors.black,
        ),
        isExpanded: true,
        alignment: Alignment.centerRight,
      ),
    );
  }
}
