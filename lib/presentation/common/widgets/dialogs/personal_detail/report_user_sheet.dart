import 'package:flutter/material.dart';

import '../../../../../config/config.dart' show Strings;

class ReportUserSheet extends StatelessWidget {
  const ReportUserSheet({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _TitleReportUser(size: size),
        _CardReportUser(size: size),
        Container(
          margin:
              EdgeInsets.symmetric(horizontal: size.width * 0.20, vertical: 15),
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            ),
            child: const Text(
              'SEND REPORT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: Strings.fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TitleReportUser extends StatelessWidget {
  const _TitleReportUser({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.95,
      height: size.height * 0.10,
      child: const ListTile(
        title: Text(
          'PLEASE, SELECT A REASON',
          style: TextStyle(
            color: Color(0xFF686E8C),
            fontSize: 14,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          'Your report is private',
          style: TextStyle(
            color: Color(0xFF9CA4BF),
            fontSize: 12,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _CardReportUser extends StatelessWidget {
  const _CardReportUser({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF0FB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _RadioReportReason(
            value: 1,
            groupValue: 1,
            title: 'I\'m not interested in this person',
            onChanged: (value) {},
          ),
          const Divider(),
          _RadioReportReason(
            value: 2,
            groupValue: 1,
            title: 'Offensive or abusive',
            onChanged: (value) {},
          ),
          const Divider(),
          _RadioReportReason(
            value: 3,
            groupValue: 1,
            title: 'Underage',
            onChanged: (value) {},
          ),
          const Divider(),
          _RadioReportReason(
            value: 4,
            groupValue: 1,
            title: 'Fake profile',
            onChanged: (value) {},
          ),
          const Divider(),
          _RadioReportReason(
            value: 5,
            groupValue: 1,
            title: 'Inappropiate photos or behavior',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}

class _RadioReportReason extends StatelessWidget {
  const _RadioReportReason({
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onChanged,
  });

  final Object value;
  final Object groupValue;
  final String title;
  final ValueChanged<Object?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      controlAffinity: ListTileControlAffinity.trailing,
      value: true,
      groupValue: 1,
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF686E8C),
          fontSize: 14,
          fontFamily: Strings.fontFamily,
          // fontWeight: FontWeight.w600,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
