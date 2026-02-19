import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/game_choice.dart';
import '../../../data/models/game_match.dart';
import '../../../data/models/game_round.dart';
import '../../../domain/game_engine/game_logic.dart';
import '../../../domain/game_engine/ai_opponent.dart';
import '../../../core/utils/sound_manager.dart';
import '../../../core/utils/haptic_manager.dart';
import '../../../data/local/preferences_service.dart';
import '../../providers/theme_provider.dart';
import '../match_result/match_result_screen.dart';
import 'widgets/choice_button.dart';
import 'widgets/character_panel.dart';
import 'widgets/countdown_widget.dart';
import 'widgets/win_animation.dart';

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
  bool _showWinAnimation = false;

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
    
    SoundManager.instance.playSound(SoundType.click);
    HapticManager.instance.selectionClick();
    
    setState(() {
      _playerChoice = choice;
      _isCountingDown = true;
    });

    // Start countdown
    _startCountdown();
  }

  void _startCountdown() async {
    SoundManager.instance.playSound(SoundType.countdown);
    
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
      
      // Play result sound
      switch (result) {
        case GameResult.win:
          SoundManager.instance.playSound(SoundType.win);
          HapticManager.instance.success();
          break;
        case GameResult.lose:
          SoundManager.instance.playSound(SoundType.lose);
          HapticManager.instance.error();
          break;
        case GameResult.draw:
          SoundManager.instance.playSound(SoundType.draw);
          HapticManager.instance.lightImpact();
          break;
      }
      
      setState(() {
        _isCountingDown = false;
        _showingResult = true;
        _showWinAnimation = result == GameResult.win;
      });
      
      // Check if match is complete
      if (_currentMatch!.isCompleted) {
        _showMatchCompleteDialog();
      }
    }
  }

  void _showMatchCompleteDialog() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => MatchResultScreen(
          winner: _currentMatch!.winner ?? 'draw',
          playerScore: _currentMatch!.playerScore,
          aiScore: _currentMatch!.aiScore,
          totalRounds: _currentMatch!.totalRounds,
        ),
      ),
    )
        .then((_) {
      _startNewMatch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(themeProvider.getBackgroundImage()),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.1),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.lg),
                  child: Column(
                    children: [
                      if (_currentMatch != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CharacterPanel(
                              name: 'Sen',
                              score: _currentMatch!.playerScore,
                              maxScore: _currentMatch!.totalRounds,
                              isWinning: _currentMatch!.playerScore >= _currentMatch!.aiScore,
                              isPlayer: true,
                            ),
                            CharacterPanel(
                              name: 'AI',
                              score: _currentMatch!.aiScore,
                              maxScore: _currentMatch!.totalRounds,
                              isWinning: _currentMatch!.aiScore >= _currentMatch!.playerScore,
                              isPlayer: false,
                            ),
                          ],
                        ),
                      
                      const SizedBox(height: AppConstants.lg),
                      
                      // Game Area
                      Expanded(
                        child: _buildGameArea(),
                      ),
                      
                      // Choice Buttons
                      _buildChoiceButtons(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGameArea() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_isCountingDown)
          const CountdownWidget()
        else if (_showingResult)
          _buildResultDisplay()
        else
          Expanded(
            child: Center(
              child: Text(
                'Seçimini yap!',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildResultDisplay() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return WinAnimation(
          showAnimation: _showWinAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Player Choice
                  Column(
                    children: [
                      Text(
                        'Sen',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppConstants.sm),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: _playerChoice != null
                            ? Image.asset(
                                themeProvider.getGameChoiceImage(_playerChoice!.name),
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              )
                            : const Icon(Icons.help, size: 40, color: Colors.white),
                      ),
                    ],
                  ),
                  
                  // VS
                  Text(
                    'VS',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  // AI Choice
                  Column(
                    children: [
                      Text(
                        'Bilgisayar',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppConstants.sm),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: _aiChoice != null
                            ? Image.asset(
                                themeProvider.getGameChoiceImage(_aiChoice!.name),
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              )
                            : const Icon(Icons.help, size: 40, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.lg),
              
              // Result
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.lg,
                  vertical: AppConstants.md,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  _currentMatch?.lastResult?.displayResult ?? '',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: _currentMatch?.lastResult == GameResult.win ? Colors.green :
                           _currentMatch?.lastResult == GameResult.lose ? Colors.red : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChoiceButtons() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: GameChoice.basicChoices.map((choice) {
            return ChoiceButton(
              choice: choice,
              onPressed: () => _onChoiceSelected(choice),
              customImage: themeProvider.getGameChoiceImage(choice.name),
            );
          }).toList(),
        );
      },
    );
  }
}
