import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../../../core/constants/app_constants.dart';
import '../../providers/theme_provider.dart';
import '../game/game_screen.dart';
import '../settings/settings_screen.dart';
import '../statistics/statistics_screen.dart';
import '../achievements/achievements_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showRoundSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tur Sayısı Seç'),
        content: Wrap(
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
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppConstants.appName),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
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
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(themeProvider.getBackgroundImage()),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.1),
                    ],
                  ),
                ),
                child: Padding(
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
                              const SizedBox(width: 10),
                              Text('📄', style: const TextStyle(fontSize: 64)),
                              const SizedBox(width: 10),
                              Text('✂️', style: const TextStyle(fontSize: 64)),
                            ],
                          ),
                          const SizedBox(height: AppConstants.sm),
                          Text(
                            AppConstants.appName,
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: AppConstants.xl * 2),
                      
                      // Buttons
                      _buildPrimaryButton(
                        context,
                        'Hızlı Oyun',
                        () => _showRoundSelectionDialog(context),
                      ),
                      
                      const SizedBox(height: AppConstants.md),
                      
                      _buildSecondaryButton(
                        context,
                        'Turnuva',
                        () {
                          // TODO: Implement tournament mode
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Turnuva modu yakında eklenecek')),
                          );
                        },
                      ),
                      
                      const SizedBox(height: AppConstants.md),
                      
                      _buildSecondaryButton(
                        context,
                        'Başarımlar',
                        () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AchievementsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
