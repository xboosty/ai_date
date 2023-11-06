import 'package:flutter/material.dart';

import '../../../../../../config/config.dart' show UserEntity;
import '../../../../../common/widgets/widgets.dart'
    show ConfigurationInputField, DatePickerFormField;

class CardPersonalInfo extends StatefulWidget {
  const CardPersonalInfo({
    super.key,
    required this.size,
    this.user,
    this.nameCtrl,
    this.lastNameCtrl,
    this.emailCtrl,
    required this.dateCtrl,
    required this.onDateSelected,
    this.validator,
    required this.initialDate,
  });

  final Size size;
  final TextEditingController dateCtrl;
  final TextEditingController? nameCtrl;
  final TextEditingController? lastNameCtrl;
  final TextEditingController? emailCtrl;
  final Function(DateTime date) onDateSelected;
  final UserEntity? user;
  final FormFieldValidator<String>? validator;
  final DateTime initialDate;

  @override
  State<CardPersonalInfo> createState() => CardPersonalInfoState();
}

class CardPersonalInfoState extends State<CardPersonalInfo> {
  final FocusNode _focusNodeFirstName = FocusNode();
  final FocusNode _focusNodeLastName = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.size.width * 0.90,
        height: widget.size.height * 0.42,
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 30,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF0FB),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConfigurationInputField(
              controller: widget.nameCtrl,
              focusNode: _focusNodeFirstName,
              fontSize: 10,
              labelText: 'Name',
              colorLabel: const Color(0xFF6C2EBC),
              textInputAction: TextInputAction.done,
            ),
            ConfigurationInputField(
              controller: widget.lastNameCtrl,
              focusNode: _focusNodeLastName,
              fontSize: 10,
              labelText: 'Last Name',
              colorLabel: const Color(0xFF6C2EBC),
            ),
            ConfigurationInputField(
              controller: widget.emailCtrl,
              focusNode: _focusNodeEmail,
              fontSize: 10,
              labelText: 'Email',
              colorLabel: const Color(0xFF6C2EBC),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: widget.size.height * 0.01),
            DatePickerFormField(
              initialDate: widget.initialDate,
              labelText: 'Date of birth',
              controller: widget.dateCtrl,
              onDateSelected: widget.onDateSelected,
              validator: widget.validator,
            ),
          ],
        ),
      ),
    );
  }
}
