import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../game/game_screen.dart';
import '../settings/settings_screen.dart';
import '../statistics/statistics_screen.dart';
import '../achievements/achievements_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StatisticsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.bar_chart),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Area
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🗿', style: const TextStyle(fontSize: 64)),
                    const SizedBox(width: AppConstants.sm),
                    Text('📄', style: const TextStyle(fontSize: 64)),
                    const SizedBox(width: AppConstants.sm),
                    Text('✂️', style: const TextStyle(fontSize: 64)),
                  ],
                ),
                const SizedBox(height: AppConstants.md),
                Text(
                  AppConstants.appName,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
            
            const SizedBox(height: AppConstants.xxl),
            
            // Quick Play Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const GameScreen(totalRounds: AppConstants.defaultRounds),
                    ),
                  );
                },
                child: const Text('HIZLI OYUN'),
              ),
            ),
            
            const SizedBox(height: AppConstants.md),
            
            // New Game Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  _showRoundSelectionDialog(context);
                },
                child: const Text('YENİ OYUN'),
              ),
            ),
            
            const SizedBox(height: AppConstants.xl),
            
            // Secondary Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSecondaryButton(
                  context,
                  icon: Icons.emoji_events,
                  label: 'Başarımlar',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AchievementsScreen(),
                      ),
                    );
                  },
                ),
                _buildSecondaryButton(
                  context,
                  icon: Icons.history,
                  label: 'Geçmiş',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const StatisticsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            
            const Spacer(),
            
            // Version
            Text(
              'Versiyon ${AppConstants.appVersion}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: AppConstants.xs),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  void _showRoundSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tur Seçimi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              spacing: AppConstants.sm,
              runSpacing: AppConstants.sm,
              children: AppConstants.quickRoundOptions.map((rounds) {
                return ChoiceChip(
                  label: Text('$rounds'),
                  selected: false,
                  onSelected: (selected) {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GameScreen(totalRounds: rounds),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: AppConstants.md),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Custom rounds input
                },
                child: const Text('Özel...'),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
        ],
      ),
    );
  }
}
