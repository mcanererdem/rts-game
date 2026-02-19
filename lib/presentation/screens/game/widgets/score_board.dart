import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/game_match.dart';

class ScoreBoard extends StatelessWidget {
  final GameMatch match;

  const ScoreBoard({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.md),
        child: Column(
          children: [
            // Score Display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '👤',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: AppConstants.sm),
                Text(
                  '${match.playerScore}',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: AppConstants.lg),
                Text(
                  ':',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(width: AppConstants.lg),
                Text(
                  '${match.aiScore}',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: AppConstants.sm),
                Text(
                  '🤖',
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
            
            const SizedBox(height: AppConstants.sm),
            
            // Progress Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProgressDots(context, isPlayer: true),
                const SizedBox(width: AppConstants.lg),
                _buildProgressDots(context, isPlayer: false),
              ],
            ),
            
            const SizedBox(height: AppConstants.sm),
            
            // Round Counter
            Text(
              'Tur ${match.currentRound}/${match.totalRounds}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressDots(BuildContext context, {required bool isPlayer}) {
    final score = isPlayer ? match.playerScore : match.aiScore;
    final winsNeeded = (match.totalRounds / 2).ceil();
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(winsNeeded, (index) {
        return Container(
          margin: const EdgeInsets.only(right: 2),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < score 
              ? (isPlayer ? Colors.green : Colors.red)
              : Colors.grey.withOpacity(0.3),
          ),
        );
      }),
    );
  }
}
