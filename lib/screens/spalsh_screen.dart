import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
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

    /// Define the animation (opacity from 0 to 1)
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    /// Start the animation
    _controller.forward();

    /// Navigate to the WelcomeScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Animated Image
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Opacity(
                  opacity: _animation.value, 
                  child: Transform.scale(
                    scale: _animation.value, 
                    child: RotationTransition(
                      turns: Tween(begin: -0.1, end: 0.0).animate(_controller), 
                      child: Image.asset(
                        'assets/images/logo.jpg', 
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Custom Animated Text
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Opacity(
                  opacity: _animation.value, 
                  child: Transform.scale(
                    scale: _animation.value, 
                    child: const Text(
                      'Quiz App',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}