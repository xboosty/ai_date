import 'package:ai_date/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ButtonCircularProgress extends StatefulWidget {
  const ButtonCircularProgress({
    super.key,
    required this.pageviewController,
    required this.pagesLength,
    this.onNextPage,
  });

  final PageController pageviewController;
  final int pagesLength;
  final ValueChanged<double>? onNextPage;

  @override
  State<ButtonCircularProgress> createState() => _ButtonCircularProgressState();
}

class _ButtonCircularProgressState extends State<ButtonCircularProgress> {
  late double percent = 0;
  double currentPage = 0;

  void _onPressButtonPage() {
    FocusScope.of(context).unfocus();
    widget.onNextPage!(widget.pageviewController.page ?? -1);

    setState(() {
      if (widget.pageviewController.page != currentPage) {
        percent = percent + (1 / widget.pagesLength);
        currentPage = widget.pageviewController.page ?? -1;
      }
    });
  }

  @override
  void initState() {
    percent = 1 / widget.pagesLength;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicatorButton(
      onPressed: () => _onPressButtonPage(),
      percent: percent,
      backgroundColor: const Color.fromARGB(255, 204, 66, 24),
    );
  }
}
