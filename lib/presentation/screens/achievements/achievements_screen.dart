import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final bool unlocked;
  final DateTime? unlockDate;
  final int? progress;
  final int? maxProgress;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.unlocked = false,
    this.unlockDate,
    this.progress,
    this.maxProgress,
  });
}

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  String _selectedFilter = 'all';

  final List<Achievement> _achievements = [
    // Unlocked achievements
    Achievement(
      id: 'first_game',
      title: 'İlk Adım',
      description: 'İlk oyununu tamamla',
      icon: '🎮',
      unlocked: true,
      unlockDate: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Achievement(
      id: 'first_win',
      title: 'İlk Zafer',
      description: 'İlk oyununu kazan',
      icon: '🏆',
      unlocked: true,
      unlockDate: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Achievement(
      id: 'ten_wins',
      title: 'Kazanan',
      description: '10 oyun kazan',
      icon: '🏆',
      unlocked: true,
      unlockDate: DateTime.now().subtract(const Duration(days: 2)),
    ),
    
    // In progress achievements
    Achievement(
      id: 'fifty_wins',
      title: 'Şampiyon',
      description: '50 oyun kazan',
      icon: '👑',
      unlocked: false,
      progress: 23,
      maxProgress: 50,
    ),
    Achievement(
      id: 'rock_master',
      title: 'Taş Ustası',
      description: '13 kere üst üste taş kazan',
      icon: '🗿',
      unlocked: false,
      progress: 7,
      maxProgress: 13,
    ),
    
    // Locked achievements
    Achievement(
      id: 'hundred_wins',
      title: 'Ustalaşma',
      description: '100 oyun kazan',
      icon: '⭐',
      unlocked: false,
    ),
    Achievement(
      id: 'paper_master',
      title: 'Kağıt Ustası',
      description: '13 kere üst üste kağıt kazan',
      icon: '📄',
      unlocked: false,
    ),
    Achievement(
      id: 'scissors_master',
      title: 'Makas Ustası',
      description: '13 kere üst üste makas kazan',
      icon: '✂️',
      unlocked: false,
    ),
    Achievement(
      id: 'balance_master',
      title: 'Denge Ustası',
      description: 'Bir seriyi her birinden eşit sayıda kullanarak kazan',
      icon: '⚖️',
      unlocked: false,
    ),
    Achievement(
      id: 'lucky',
      title: 'Şanslı',
      description: 'İlk atışta nadir seçenek çıkar (5 kez)',
      icon: '🍀',
      unlocked: false,
    ),
  ];

  List<Achievement> get _filteredAchievements {
    switch (_selectedFilter) {
      case 'unlocked':
        return _achievements.where((a) => a.unlocked).toList();
      case 'locked':
        return _achievements.where((a) => !a.unlocked).toList();
      default:
        return _achievements;
    }
  }

  int get _unlockedCount => _achievements.where((a) => a.unlocked).length;
  double get _progressPercentage => _unlockedCount / _achievements.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Başarımlar'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          // Progress Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'İlerleme: $_unlockedCount/${_achievements.length} (${(_progressPercentage * 100).toInt()}%)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppConstants.sm),
                LinearProgressIndicator(
                  value: _progressPercentage,
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          
          // Filter Chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.lg),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('Tümü'),
                  selected: _selectedFilter == 'all',
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = 'all';
                    });
                  },
                ),
                const SizedBox(width: AppConstants.sm),
                FilterChip(
                  label: const Text('Kilitsiz'),
                  selected: _selectedFilter == 'unlocked',
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = 'unlocked';
                    });
                  },
                ),
                const SizedBox(width: AppConstants.sm),
                FilterChip(
                  label: const Text('Kilitli'),
                  selected: _selectedFilter == 'locked',
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = 'locked';
                    });
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppConstants.md),
          
          // Achievements List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppConstants.lg),
              itemCount: _filteredAchievements.length,
              itemBuilder: (context, index) {
                final achievement = _filteredAchievements[index];
                return _buildAchievementCard(achievement);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(Achievement achievement) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.md),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.lg),
        child: Row(
          children: [
            // Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: achievement.unlocked 
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
                border: Border.all(
                  color: achievement.unlocked 
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  achievement.icon,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
            
            const SizedBox(width: AppConstants.md),
            
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: achievement.unlocked ? null : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: AppConstants.xs),
                  Text(
                    achievement.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: achievement.unlocked ? null : Colors.grey,
                    ),
                  ),
                  if (achievement.unlocked && achievement.unlockDate != null)
                    Padding(
                      padding: const EdgeInsets.only(top: AppConstants.xs),
                      child: Text(
                        'Kilidi açıldı: ${_formatDate(achievement.unlockDate!)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  if (!achievement.unlocked && achievement.progress != null && achievement.maxProgress != null)
                    Padding(
                      padding: const EdgeInsets.only(top: AppConstants.xs),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LinearProgressIndicator(
                            value: achievement.progress! / achievement.maxProgress!,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'İlerleme: ${achievement.progress}/${achievement.maxProgress}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            
            // Status Icon
            Icon(
              achievement.unlocked ? Icons.lock_open : Icons.lock,
              color: achievement.unlocked ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Bugün';
    } else if (difference.inDays == 1) {
      return 'Dün';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} gün önce';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} hafta önce';
    } else {
      return '${(difference.inDays / 30).floor()} ay önce';
    }
  }
}
