class UserStats {
  final int totalGames;
  final int wins;
  final int losses;
  final int draws;
  final int currentStreak;
  final int longestStreak;
  final int rockCount;
  final int paperCount;
  final int scissorsCount;
  final int fireCount;
  final int waterCount;
  final DateTime? lastPlayedDate;

  UserStats({
    required this.totalGames,
    required this.wins,
    required this.losses,
    required this.draws,
    required this.currentStreak,
    required this.longestStreak,
    required this.rockCount,
    required this.paperCount,
    required this.scissorsCount,
    required this.fireCount,
    required this.waterCount,
    this.lastPlayedDate,
  });

  double get winRate => totalGames > 0 ? wins / totalGames : 0.0;
  
  String get favoriteChoice {
    if (rockCount >= paperCount && rockCount >= scissorsCount) return 'Taş';
    if (paperCount >= scissorsCount) return 'Kağıt';
    return 'Makas';
  }

  int get totalChoices => rockCount + paperCount + scissorsCount + fireCount + waterCount;
  
  double get rockPercentage => totalChoices > 0 ? rockCount / totalChoices : 0.0;
  double get paperPercentage => totalChoices > 0 ? paperCount / totalChoices : 0.0;
  double get scissorsPercentage => totalChoices > 0 ? scissorsCount / totalChoices : 0.0;

  UserStats copyWith({
    int? totalGames,
    int? wins,
    int? losses,
    int? draws,
    int? currentStreak,
    int? longestStreak,
    int? rockCount,
    int? paperCount,
    int? scissorsCount,
    int? fireCount,
    int? waterCount,
    DateTime? lastPlayedDate,
  }) {
    return UserStats(
      totalGames: totalGames ?? this.totalGames,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      draws: draws ?? this.draws,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      rockCount: rockCount ?? this.rockCount,
      paperCount: paperCount ?? this.paperCount,
      scissorsCount: scissorsCount ?? this.scissorsCount,
      fireCount: fireCount ?? this.fireCount,
      waterCount: waterCount ?? this.waterCount,
      lastPlayedDate: lastPlayedDate ?? this.lastPlayedDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalGames': totalGames,
      'wins': wins,
      'losses': losses,
      'draws': draws,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'rockCount': rockCount,
      'paperCount': paperCount,
      'scissorsCount': scissorsCount,
      'fireCount': fireCount,
      'waterCount': waterCount,
      'lastPlayedDate': lastPlayedDate?.toIso8601String(),
    };
  }

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      totalGames: json['totalGames'] ?? 0,
      wins: json['wins'] ?? 0,
      losses: json['losses'] ?? 0,
      draws: json['draws'] ?? 0,
      currentStreak: json['currentStreak'] ?? 0,
      longestStreak: json['longestStreak'] ?? 0,
      rockCount: json['rockCount'] ?? 0,
      paperCount: json['paperCount'] ?? 0,
      scissorsCount: json['scissorsCount'] ?? 0,
      fireCount: json['fireCount'] ?? 0,
      waterCount: json['waterCount'] ?? 0,
      lastPlayedDate: json['lastPlayedDate'] != null 
          ? DateTime.parse(json['lastPlayedDate']) 
          : null,
    );
  }
}
