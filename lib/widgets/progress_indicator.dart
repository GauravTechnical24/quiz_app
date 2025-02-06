import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int current;
  final int total;

  const ProgressIndicatorWidget({required this.current, required this.total, super.key});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: current / total,
      backgroundColor: Colors.grey,
      color: Colors.blue,
    );
  }
}