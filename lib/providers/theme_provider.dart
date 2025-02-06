import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to manage the theme mode
final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

/// Helper function to toggle the theme
void toggleTheme(WidgetRef ref) {
  final currentTheme = ref.read(themeProvider);
  ref.read(themeProvider.notifier).state =
      currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
}