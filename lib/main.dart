import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quize_app/screens/spalsh_screen.dart';
import 'package:quize_app/services/navigator_service.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: "Quiz App",
       navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(), 
      themeMode: themeMode, 
      home: const SplashScreen(),
    );
  }
}