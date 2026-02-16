enum GameChoice {
  rock,
  paper,
  scissors,
  fire,     // Gelecek
  water;    // Gelecek

  String get emoji {
    switch (this) {
      case GameChoice.rock: return '🗿';
      case GameChoice.paper: return '📄';
      case GameChoice.scissors: return '✂️';
      case GameChoice.fire: return '🔥';
      case GameChoice.water: return '💧';
    }
  }

  String get displayName {
    switch (this) {
      case GameChoice.rock: return 'Taş';
      case GameChoice.paper: return 'Kağıt';
      case GameChoice.scissors: return 'Makas';
      case GameChoice.fire: return 'Ateş';
      case GameChoice.water: return 'Su';
    }
  }

  bool get isRareChoice {
    return this == GameChoice.fire || this == GameChoice.water;
  }

  static List<GameChoice> get basicChoices => [GameChoice.rock, GameChoice.paper, GameChoice.scissors];
  
  static List<GameChoice> get allChoices => [...basicChoices, GameChoice.fire, GameChoice.water];
}
