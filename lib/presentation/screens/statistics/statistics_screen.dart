import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/local/preferences_service.dart';
import '../../../data/models/user_stats.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  UserStats? _stats;
  List<Map<String, dynamic>> _matchHistory = [];

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  void _loadStats() {
    setState(() {
      _stats = PreferencesService.instance.getUserStats();
      _matchHistory = PreferencesService.instance.getMatchHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İstatistikler'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.lg),
        child: Column(
          children: [
            // Main Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Toplam Oyun',
                    value: '${_stats?.totalGames ?? 0}',
                    icon: Icons.sports_esports,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: AppConstants.md),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Galibiyet',
                    value: '${_stats?.wins ?? 0}',
                    icon: Icons.emoji_events,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppConstants.md),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Mağlubiyet',
                    value: '${_stats?.losses ?? 0}',
                    icon: Icons.sentiment_very_dissatisfied,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: AppConstants.md),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Berabere',
                    value: '${_stats?.draws ?? 0}',
                    icon: Icons.handshake,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppConstants.xl),
            
            // Win Rate
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KAZANMA ORANI',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.md),
                    LinearProgressIndicator(
                      value: _stats?.winRate ?? 0.0,
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    const SizedBox(height: AppConstants.sm),
                    Text(
                      '${((_stats?.winRate ?? 0.0) * 100).toInt()}%',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: AppConstants.lg),
            
            // Favorite Choice
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FAVORİ SEÇİM',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.md),
                    Row(
                      children: [
                        Text(
                          '📄',
                          style: const TextStyle(fontSize: 40),
                        ),
                        const SizedBox(width: AppConstants.md),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kağıt',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              'Kullanım: %45',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: AppConstants.lg),
            
            // Streak
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SERİ',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.local_fire_department, color: Colors.orange, size: 32),
                            const SizedBox(height: AppConstants.xs),
                            Text(
                              'Mevcut',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '5 🔥',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 32),
                            const SizedBox(height: AppConstants.xs),
                            Text(
                              'En Uzun',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '12 🏆',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: AppConstants.lg),
            
            // Recent Matches
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SON OYUNLAR',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.md),
                    _buildMatchHistory(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.md),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: AppConstants.sm),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchHistory() {
    final matches = [
      {'date': 'Bugün', 'score': '3-2', 'result': 'Kazandı', 'won': true},
      {'date': 'Dün', 'score': '1-3', 'result': 'Kaybetti', 'won': false},
      {'date': '2 gün önce', 'score': '5-3', 'result': 'Kazandı', 'won': true},
    ];

    return Column(
      children: matches.map((match) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                match['date'] as String,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                match['score'] as String,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                match['result'] as String,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: match['won'] as bool ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
