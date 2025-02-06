import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'quiz_screen.dart';
import '../providers/theme_provider.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    /// Initialize AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of the animation
    );
    /// Define the animation 
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    /// Start the animation after a short delay to ensure visibility
    Future.delayed(const Duration(milliseconds: 100), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Get the current theme mode from the provider
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App"),
        actions: [
          IconButton(
            onPressed: () {
              /// Toggle the theme using the provider
              toggleTheme(ref);
            },
            icon: Icon(
              themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
            ),
            tooltip: themeMode == ThemeMode.light
                ? "Switch to Dark Mode"
                : "Switch to Light Mode",
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: themeMode == ThemeMode.light
                ? [Colors.blue.shade300, Colors.purple.shade300]
                : [Colors.black87, Colors.grey.shade900],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Animated Title
              FadeTransition(
                opacity: _animation,
                child: Text(
                  "Quiz App",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: themeMode == ThemeMode.light
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              /// Animated Subtitle
              FadeTransition(
                opacity: _animation,
                child: Text(
                  "Test Your Knowledge!",
                  style: TextStyle(
                    fontSize: 20,
                    color: themeMode == ThemeMode.light
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              /// Animated Button
              FadeTransition(
                opacity: _animation,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const QuizScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: themeMode == ThemeMode.light
                        ? Colors.blue
                        : Colors.tealAccent,
                  ),
                  child: Text(
                    "Start Quiz",
                    style: TextStyle(
                      fontSize: 20,
                      color: themeMode == ThemeMode.light
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
