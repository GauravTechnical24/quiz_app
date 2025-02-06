import 'package:flutter/material.dart';
import 'package:quize_app/utils/sound_effects.dart';

class AnswerButton extends StatefulWidget {
  final String option;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isCorrect;

  const AnswerButton({
    required this.option,
    required this.onTap,
    required this.isSelected,
    required this.isCorrect,
    super.key,
  });

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    /// Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    /// Define the scale animation
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant AnswerButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// Trigger the animation only when the option becomes selected
    if (!oldWidget.isSelected && widget.isSelected) {
      _controller.forward();
    } else if (oldWidget.isSelected && !widget.isSelected) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        /// Play sound based on correctness
        await SoundEffects.soundTwo();

        /// Call the onTap callback
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _scaleAnimation, 
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.isSelected ? Colors.red : Colors.transparent,
            border: Border.all(
              color: widget.isSelected ? Colors.transparent : Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.option,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: widget.isSelected
                  ? Colors.white 
                  : (Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white), 
            ),
          ),
        ),
      ),
    );
  }
}
