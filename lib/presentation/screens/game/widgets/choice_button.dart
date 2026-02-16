import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/game_choice.dart';

class ChoiceButton extends StatelessWidget {
  final GameChoice choice;
  final VoidCallback onPressed;
  final bool disabled;

  const ChoiceButton({
    super.key,
    required this.choice,
    required this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: AppConstants.buttonAnimationDuration),
      curve: Curves.easeInOut,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(80, 80),
          maximumSize: const Size(120, 120),
          shape: const CircleBorder(),
          elevation: disabled ? 0 : 4,
          backgroundColor: disabled 
            ? Theme.of(context).colorScheme.surface
            : _getChoiceColor(context),
        ),
        child: AnimatedScale(
          scale: disabled ? 0.9 : 1.0,
          duration: const Duration(milliseconds: AppConstants.buttonAnimationDuration),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                choice.emoji,
                style: const TextStyle(fontSize: 40),
              ),
              const SizedBox(height: AppConstants.xs),
              Text(
                choice.displayName,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: disabled 
                    ? Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                    : _getTextColor(context),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getChoiceColor(BuildContext context) {
    switch (choice) {
      case GameChoice.rock:
        return const Color(0xFF8D6E63); // Brown
      case GameChoice.paper:
        return const Color(0xFF64B5F6); // Light Blue
      case GameChoice.scissors:
        return const Color(0xFF81C784); // Light Green
      case GameChoice.fire:
        return const Color(0xFFFF7043); // Deep Orange
      case GameChoice.water:
        return const Color(0xFF4FC3F7); // Light Blue
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (choice) {
      case GameChoice.rock:
      case GameChoice.fire:
        return Colors.white;
      case GameChoice.paper:
      case GameChoice.scissors:
      case GameChoice.water:
        return Colors.black;
    }
  }
}
