import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/game_choice.dart';
import '../../../data/models/game_match.dart';
import '../../../data/models/game_round.dart';
import '../../../domain/game_engine/game_logic.dart';
import '../../../domain/game_engine/ai_opponent.dart';
import 'widgets/choice_button.dart';
import 'widgets/score_board.dart';
import 'widgets/countdown_widget.dart';

class GameScreen extends StatefulWidget {
  final int totalRounds;
  
  const GameScreen({
    super.key,
    required this.totalRounds,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameMatch? _currentMatch;
  bool _isCountingDown = false;
  bool _showingResult = false;
  GameChoice? _playerChoice;
  GameChoice? _aiChoice;
  final AIOpponent _aiOpponent = AIOpponent();

  @override
  void initState() {
    super.initState();
    _startNewMatch();
  }

  void _startNewMatch() {
    setState(() {
      _currentMatch = GameMatch(totalRounds: widget.totalRounds);
      _isCountingDown = false;
      _showingResult = false;
      _playerChoice = null;
      _aiChoice = null;
    });
  }

  void _onChoiceSelected(GameChoice choice) {
    if (_isCountingDown || _showingResult) return;
    
    setState(() {
      _playerChoice = choice;
      _isCountingDown = true;
    });

    // Start countdown
    _startCountdown();
  }

  void _startCountdown() async {
    // Show countdown animation
    await Future.delayed(const Duration(milliseconds: AppConstants.countdownDuration));
    
    // Make AI choice
    _aiChoice = _aiOpponent.makeChoice();
    
    // Calculate result and add round
    if (_playerChoice != null && _aiChoice != null && _currentMatch != null) {
      final result = GameLogic.determineWinner(_playerChoice!, _aiChoice!);
      final round = GameRound(
        playerChoice: _playerChoice!,
        aiChoice: _aiChoice!,
        result: result,
      );
      
      _currentMatch = _currentMatch!.addRound(round);
      
      // Show result
      _showResult(result);
    }
  }

  void _showResult(GameResult result) {
    setState(() {
      _isCountingDown = false;
      _showingResult = true;
    });

    // Hide result after delay
    Future.delayed(const Duration(milliseconds: AppConstants.resultDisplayDuration), () {
      if (mounted) {
        if (_currentMatch?.isCompleted == true) {
          _showMatchCompleteDialog();
        } else {
          setState(() {
            _showingResult = false;
            _playerChoice = null;
            _aiChoice = null;
          });
        }
      }
    });
  }

  void _showMatchCompleteDialog() {
    final playerScore = _currentMatch!.playerScore;
    final aiScore = _currentMatch!.aiScore;
    final isDraw = playerScore == aiScore;
    final playerWon = playerScore > aiScore;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          isDraw ? 'Berabere!' : (playerWon ? '🎉 Kazandın!' : '😔 Kaybettin'),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Final Skor: $playerScore - $aiScore',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppConstants.md),
            if (_currentMatch != null)
              ..._currentMatch!.rounds.map((round) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${round.playerChoice.emoji} ${round.playerChoice.displayName}'),
                    Text('vs'),
                    Text('${round.aiChoice.displayName} ${round.aiChoice.emoji}'),
                    Text(
                      round.result == GameResult.win ? '✓' : 
                      round.result == GameResult.lose ? '✗' : '-',
                      style: TextStyle(
                        color: round.result == GameResult.win ? Colors.green :
                               round.result == GameResult.lose ? Colors.red : Colors.grey,
                      ),
                    ),
                  ],
                ),
              )).toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go to home
            },
            child: const Text('Ana Menü'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              _startNewMatch(); // Start new game
            },
            child: const Text('Tekrar Oyna'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oyun - Tur ${_currentMatch?.currentRound ?? 1}/${widget.totalRounds}'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.lg),
        child: Column(
          children: [
            // Score Board
            if (_currentMatch != null)
              ScoreBoard(match: _currentMatch!),
            
            const SizedBox(height: AppConstants.lg),
            
            // Game Area
            Expanded(
              child: Center(
                child: _buildGameArea(),
              ),
            ),
            
            // Choice Buttons
            if (!_isCountingDown && !_showingResult)
              _buildChoiceButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildGameArea() {
    if (_isCountingDown) {
      return const CountdownWidget();
    }
    
    if (_showingResult && _playerChoice != null && _aiChoice != null) {
      return _buildResultDisplay();
    }
    
    // Ready state
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hazır mısın?',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: AppConstants.sm),
        Text(
          'Seçimini yap ve oyunu başlat!',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildResultDisplay() {
    final result = GameLogic.determineWinner(_playerChoice!, _aiChoice!);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'Sen',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppConstants.sm),
                Text(
                  _playerChoice!.emoji,
                  style: const TextStyle(fontSize: 80),
                ),
                Text(
                  _playerChoice!.displayName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'AI',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppConstants.sm),
                Text(
                  _aiChoice!.emoji,
                  style: const TextStyle(fontSize: 80),
                ),
                Text(
                  _aiChoice!.displayName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppConstants.lg),
        Text(
          GameLogic.getResultMessage(result),
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: result == GameResult.win ? Colors.green :
                   result == GameResult.lose ? Colors.red : Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: GameChoice.basicChoices.map((choice) {
        return ChoiceButton(
          choice: choice,
          onPressed: () => _onChoiceSelected(choice),
        );
      }).toList(),
    );
  }
}
