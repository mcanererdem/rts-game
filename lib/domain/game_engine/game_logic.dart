import '../../data/models/game_choice.dart';
import '../../data/models/game_round.dart';

class GameLogic {
  static GameResult determineWinner(
    GameChoice player,
    GameChoice opponent,
  ) {
    if (player == opponent) return GameResult.draw;

    // Temel kurallar
    const Map<GameChoice, List<GameChoice>> winsAgainst = {
      GameChoice.rock: [GameChoice.scissors],
      GameChoice.paper: [GameChoice.rock],
      GameChoice.scissors: [GameChoice.paper],
      // Gelecek: fire ve water kuralları
      // GameChoice.fire: [GameChoice.scissors, GameChoice.paper],
      // GameChoice.water: [GameChoice.fire, GameChoice.rock],
    };

    if (winsAgainst[player]?.contains(opponent) ?? false) {
      return GameResult.win;
    }

    return GameResult.lose;
  }

  static int calculatePoints(GameResult result, bool isRareChoice) {
    switch (result) {
      case GameResult.win:
        return isRareChoice ? 2 : 1;
      case GameResult.lose:
      case GameResult.draw:
        return 0;
    }
  }

  static String getResultMessage(GameResult result) {
    switch (result) {
      case GameResult.win:
        return '🎉 Kazandın!';
      case GameResult.lose:
        return '😔 Kaybettin';
      case GameResult.draw:
        return '🤝 Berabere';
    }
  }

  static String getRoundResultText(GameRound round) {
    final playerEmoji = round.playerChoice.emoji;
    final aiEmoji = round.aiChoice.emoji;
    final resultSymbol = round.result == GameResult.win ? '✓' : 
                        round.result == GameResult.lose ? '✗' : '-';
    
    return 'Tur ${round.id}: $playerEmoji vs $aiEmoji  $resultSymbol';
  }
}
