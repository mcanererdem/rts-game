import 'dart:math';
import '../../data/models/game_choice.dart';

class AIOpponent {
  final Random _random = Random();

  GameChoice makeChoice({
    bool includeRareChoices = false,
    List<GameChoice>? history,
  }) {
    // MVP: Tamamen rastgele
    final choices = [
      GameChoice.rock,
      GameChoice.paper,
      GameChoice.scissors,
    ];

    // %5 ihtimalle nadir seçenek (gelecek)
    if (includeRareChoices && _random.nextInt(100) < 5) {
      return _random.nextBool() ? GameChoice.fire : GameChoice.water;
    }

    return choices[_random.nextInt(choices.length)];
  }

  // Gelecek: Daha akıllı stratejiler
  // - Oyuncu örüntülerini analiz et
  // - Zorluk seviyesine göre ayarla
  
  GameChoice makeSmartChoice(List<GameChoice> playerHistory) {
    // Basit pattern detection - gelecekte geliştirilebilir
    if (playerHistory.length < 3) {
      return makeChoice();
    }

    // Son 3 seçimi analiz et
    final recentChoices = playerHistory.take(3).toList();
    final rockCount = recentChoices.where((choice) => choice == GameChoice.rock).length;
    final paperCount = recentChoices.where((choice) => choice == GameChoice.paper).length;
    final scissorsCount = recentChoices.where((choice) => choice == GameChoice.scissors).length;

    // En çok kullanılan seçeneği yen
    GameChoice counterChoice;
    if (rockCount >= paperCount && rockCount >= scissorsCount) {
      counterChoice = GameChoice.paper; // Kağıt taşı yener
    } else if (paperCount >= scissorsCount) {
      counterChoice = GameChoice.scissors; // Makas kağıdı yener
    } else {
      counterChoice = GameChoice.rock; // Taş makası yener
    }

    // %70 ihtimalle akıllı seçim, %30 rastgele
    return _random.nextInt(100) < 70 ? counterChoice : makeChoice();
  }
}
