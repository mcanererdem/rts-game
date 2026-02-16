import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_stats.dart';

enum AppThemeMode { light, dark, colorful }

class PreferencesService {
  static PreferencesService? _instance;
  static PreferencesService get instance => _instance ??= PreferencesService._();

  PreferencesService._();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Settings
  AppThemeMode get themeMode {
    final themeIndex = _prefs.getInt('theme_mode') ?? 0;
    return AppThemeMode.values[themeIndex];
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    await _prefs.setInt('theme_mode', mode.index);
  }

  bool get soundEnabled => _prefs.getBool('sound_enabled') ?? true;
  Future<void> setSoundEnabled(bool enabled) async {
    await _prefs.setBool('sound_enabled', enabled);
  }

  bool get hapticsEnabled => _prefs.getBool('haptics_enabled') ?? true;
  Future<void> setHapticsEnabled(bool enabled) async {
    await _prefs.setBool('haptics_enabled', enabled);
  }

  int get defaultRounds => _prefs.getInt('default_rounds') ?? 3;
  Future<void> setDefaultRounds(int rounds) async {
    await _prefs.setInt('default_rounds', rounds);
  }

  // User Stats
  UserStats getUserStats() {
    return UserStats(
      totalGames: _prefs.getInt('total_games') ?? 0,
      wins: _prefs.getInt('wins') ?? 0,
      losses: _prefs.getInt('losses') ?? 0,
      draws: _prefs.getInt('draws') ?? 0,
      currentStreak: _prefs.getInt('current_streak') ?? 0,
      longestStreak: _prefs.getInt('longest_streak') ?? 0,
      rockCount: _prefs.getInt('rock_count') ?? 0,
      paperCount: _prefs.getInt('paper_count') ?? 0,
      scissorsCount: _prefs.getInt('scissors_count') ?? 0,
      lastPlayedDate: DateTime.fromMillisecondsSinceEpoch(
        _prefs.getInt('last_played_date') ?? DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<void> updateUserStats(UserStats stats) async {
    await _prefs.setInt('total_games', stats.totalGames);
    await _prefs.setInt('wins', stats.wins);
    await _prefs.setInt('losses', stats.losses);
    await _prefs.setInt('draws', stats.draws);
    await _prefs.setInt('current_streak', stats.currentStreak);
    await _prefs.setInt('longest_streak', stats.longestStreak);
    await _prefs.setInt('rock_count', stats.rockCount);
    await _prefs.setInt('paper_count', stats.paperCount);
    await _prefs.setInt('scissors_count', stats.scissorsCount);
    await _prefs.setInt('last_played_date', stats.lastPlayedDate?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch);
  }

  // Achievements
  List<String> getUnlockedAchievements() {
    return _prefs.getStringList('unlocked_achievements') ?? [];
  }

  Future<void> unlockAchievement(String achievementId) async {
    final unlocked = getUnlockedAchievements();
    if (!unlocked.contains(achievementId)) {
      unlocked.add(achievementId);
      await _prefs.setStringList('unlocked_achievements', unlocked);
    }
  }

  // Match History (simplified)
  Future<void> saveMatchResult(String result, int playerScore, int aiScore) async {
    final matches = _prefs.getStringList('match_history') ?? [];
    final matchData = '${DateTime.now().millisecondsSinceEpoch},$result,$playerScore,$aiScore';
    matches.add(matchData);
    
    // Keep only last 50 matches
    if (matches.length > 50) {
      matches.removeRange(0, matches.length - 50);
    }
    
    await _prefs.setStringList('match_history', matches);
  }

  List<Map<String, dynamic>> getMatchHistory() {
    final matches = _prefs.getStringList('match_history') ?? [];
    return matches.map((match) {
      final parts = match.split(',');
      return {
        'timestamp': int.parse(parts[0]),
        'result': parts[1],
        'playerScore': int.parse(parts[2]),
        'aiScore': int.parse(parts[3]),
      };
    }).toList();
  }

  // Reset all data
  Future<void> resetAllData() async {
    await _prefs.clear();
  }
}
