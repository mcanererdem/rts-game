import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_stats.dart';
import '../../presentation/providers/theme_provider.dart';

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

  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int getInt(String key) {
    return _prefs.getInt(key) ?? 0;
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
      fireCount: _prefs.getInt('fire_count') ?? 0,
      waterCount: _prefs.getInt('water_count') ?? 0,
      lastPlayedDate: _prefs.getString('last_played_date') != null
          ? DateTime.parse(_prefs.getString('last_played_date')!)
          : null,
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
    await _prefs.setInt('fire_count', stats.fireCount);
    await _prefs.setInt('water_count', stats.waterCount);
    await _prefs.setString('last_played_date', stats.lastPlayedDate?.toIso8601String() ?? '');
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
