import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class CharacterPanel extends StatelessWidget {
  final String name;
  final int score;
  final int maxScore;
  final bool isWinning;
  final bool isPlayer;

  const CharacterPanel({
    super.key,
    required this.name,
    required this.score,
    required this.maxScore,
    required this.isWinning,
    required this.isPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.md),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: (isWinning ? Colors.green : Colors.white).withOpacity(isWinning ? 0.6 : 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: (isWinning ? Colors.green : Colors.black).withOpacity(isWinning ? 0.25 : 0.15),
            blurRadius: isWinning ? 18 : 10,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: Icon(
              isPlayer ? Icons.person : Icons.smart_toy,
              size: 60,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.xs),
          Text(
            '$score',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.xs),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(maxScore, (index) {
              final filled = index < score;
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: filled ? Colors.white : Colors.white24,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
