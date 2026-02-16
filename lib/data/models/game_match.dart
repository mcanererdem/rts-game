import 'package:uuid/uuid.dart';
import 'game_round.dart';
import 'game_choice.dart';

enum MatchStatus { playing, completed, abandoned }

class GameMatch {
  final String id;
  final int totalRounds;
  final List<GameRound> rounds;
  final DateTime startTime;
  final DateTime? endTime;
  final MatchStatus status;

  GameMatch({
    required this.totalRounds,
    List<GameRound>? rounds,
    DateTime? startTime,
    this.endTime,
    this.status = MatchStatus.playing,
  }) : id = const Uuid().v4(),
       rounds = rounds ?? [],
       startTime = startTime ?? DateTime.now();

  int get playerScore {
    return rounds.where((round) => round.result == GameResult.win).length;
  }

  int get aiScore {
    return rounds.where((round) => round.result == GameResult.lose).length;
  }

  int get draws {
    return rounds.where((round) => round.result == GameResult.draw).length;
  }

  int get currentRound => rounds.length + 1;

  bool get isCompleted => playerScore > totalRounds ~/ 2 || 
                         aiScore > totalRounds ~/ 2 || 
                         currentRound > totalRounds;

  GameMatch copyWith({
    List<GameRound>? rounds,
    DateTime? endTime,
    MatchStatus? status,
  }) {
    return GameMatch(
      totalRounds: totalRounds,
      rounds: rounds ?? this.rounds,
      startTime: startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
    );
  }

  GameMatch addRound(GameRound round) {
    final newRounds = [...rounds, round];
    final newStatus = isCompleted ? MatchStatus.completed : MatchStatus.playing;
    final newEndTime = newStatus == MatchStatus.completed ? DateTime.now() : null;
    
    return copyWith(
      rounds: newRounds,
      endTime: newEndTime,
      status: newStatus,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'totalRounds': totalRounds,
      'rounds': rounds.map((round) => round.toJson()).toList(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'status': status.name,
    };
  }

  factory GameMatch.fromJson(Map<String, dynamic> json) {
    return GameMatch(
      totalRounds: json['totalRounds'],
      rounds: (json['rounds'] as List)
          .map((roundJson) => GameRound.fromJson(roundJson))
          .toList(),
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      status: MatchStatus.values.firstWhere((status) => status.name == json['status']),
    );
  }

  @override
  String toString() {
    return 'GameMatch(id: $id, totalRounds: $totalRounds, playerScore: $playerScore, aiScore: $aiScore, status: $status)';
  }
}
