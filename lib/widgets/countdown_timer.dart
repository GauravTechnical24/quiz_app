import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/timer_provider.dart';

class CountdownTimer extends ConsumerWidget {
  const CountdownTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeLeft = ref.watch(timerProvider);
    return Text(
      "Time Left: $timeLeft",
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}