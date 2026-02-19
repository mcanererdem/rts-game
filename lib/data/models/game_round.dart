import 'package:uuid/uuid.dart';
import 'game_choice.dart';

enum GameResult { win, lose, draw }

class GameRound {
  final String id;
  final GameChoice playerChoice;
  final GameChoice aiChoice;
  final GameResult result;
  final DateTime timestamp;
  final bool isRareChoice;

  GameRound({
    required this.playerChoice,
    required this.aiChoice,
    required this.result,
    DateTime? timestamp,
  }) : id = const Uuid().v4(),
       timestamp = timestamp ?? DateTime.now(),
       isRareChoice = playerChoice.isRareChoice;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playerChoice': playerChoice.name,
      'aiChoice': aiChoice.name,
      'result': result.name,
      'timestamp': timestamp.toIso8601String(),
      'isRareChoice': isRareChoice,
    };
  }

  factory GameRound.fromJson(Map<String, dynamic> json) {
    return GameRound(
      playerChoice: GameChoice.values.firstWhere((choice) => choice.name == json['playerChoice']),
      aiChoice: GameChoice.values.firstWhere((choice) => choice.name == json['aiChoice']),
      result: GameResult.values.firstWhere((result) => result.name == json['result']),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  @override
  String toString() {
    return 'GameRound(id: $id, playerChoice: $playerChoice, aiChoice: $aiChoice, result: $result)';
  }

  String get displayResult {
    switch (result) {
      case GameResult.win:
        return 'Kazandın! 🎉';
      case GameResult.lose:
        return 'Kaybettin! 😔';
      case GameResult.draw:
        return 'Berabere! 🤝';
    }
  }
}
