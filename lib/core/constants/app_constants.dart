class AppConstants {
  // App Info
  static const String appName = 'Taş Kağıt Makas';
  static const String appVersion = '1.0.0';
  
  // Game Settings
  static const List<int> quickRoundOptions = [1, 3, 5, 7];
  static const int defaultRounds = 3;
  static const int maxRounds = 99;
  static const int minRounds = 1;
  
  // Animation Durations (ms)
  static const int countdownDuration = 3000;
  static const int resultDisplayDuration = 2000;
  static const int buttonAnimationDuration = 100;
  static const int screenTransitionDuration = 300;
  static const int confettiDuration = 3000;
  
  // Rare Choice Settings
  static const double rareChoiceProbability = 0.05; // 5%
  static const int rareChoiceBonusPoints = 2;
  
  // Storage Keys
  static const String userStatsKey = 'user_stats';
  static const String achievementsKey = 'achievements';
  static const String settingsKey = 'settings';
  static const String matchHistoryKey = 'match_history';
  
  // Sound Files
  static const String countdownSound = 'countdown.mp3';
  static const String winSound = 'win.mp3';
  static const String loseSound = 'lose.mp3';
  static const String drawSound = 'draw.mp3';
  static const String clickSound = 'click.mp3';
  static const String achievementSound = 'achievement.mp3';
  
  // Haptic Patterns
  static const int lightVibrationDuration = 50;
  static const int mediumVibrationDuration = 100;
  static const int heavyVibrationDuration = 200;
  
  // UI Constants
  static const double buttonHeight = 56.0;
  static const double secondaryButtonHeight = 48.0;
  static const double iconButtonSize = 48.0;
  static const double borderRadius = 28.0;
  static const double secondaryBorderRadius = 24.0;
  
  // Spacing
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  
  // Breakpoints
  static const double smallScreen = 360.0;
  static const double mediumScreen = 600.0;
  static const double largeScreen = 840.0;
  
  // Achievement thresholds
  static const int firstWinThreshold = 1;
  static const int tenWinsThreshold = 10;
  static const int fiftyWinsThreshold = 50;
  static const int hundredWinsThreshold = 100;
  static const int masteryStreakThreshold = 13;
  
  // Privacy
  static const String privacyPolicyUrl = 'https://github.com/mcanererdem/rts-game/blob/main/PRIVACY_POLICY.md';
  static const String termsOfServiceUrl = 'https://github.com/mcanererdem/rts-game/blob/main/TERMS_OF_SERVICE.md';
  static const String supportEmail = 'support@rpsgame.com';
}
