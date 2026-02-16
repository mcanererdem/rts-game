import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/game_choice.dart';
import '../../../widgets/modern_game_icons.dart';

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
      child: GestureDetector(
        onTap: disabled ? null : onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()
            ..scale(disabled ? 0.9 : 1.0)
            ..rotateZ(disabled ? 0.0 : 0.0),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _getChoiceColor(context).withOpacity(0.8),
                  _getChoiceColor(context).withOpacity(0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: _getChoiceColor(context).withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: _getChoiceColor(context).withOpacity(0.2),
                  blurRadius: 25,
                  offset: const Offset(0, 15),
                ),
              ],
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedScale(
                        scale: disabled ? 0.8 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: _buildModernIcon(),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        choice.displayName,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: disabled 
                            ? Colors.white.withOpacity(0.4)
                            : Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernIcon() {
    switch (choice) {
      case GameChoice.rock:
        return ModernGameIcons.rockIcon;
      case GameChoice.paper:
        return ModernGameIcons.paperIcon;
      case GameChoice.scissors:
        return ModernGameIcons.scissorsIcon;
      case GameChoice.fire:
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFFF7043),
                const Color(0xFFE64A19),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF7043).withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.local_fire_department,
            color: Colors.white,
            size: 35,
          ),
        );
      case GameChoice.water:
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF4FC3F7),
                const Color(0xFF29B6F6),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4FC3F7).withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.water_drop,
            color: Colors.white,
            size: 35,
          ),
        );
    }
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
}
