import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../../core/constants/app_constants.dart';

class MatchResultScreen extends StatefulWidget {
  final String winner;
  final int playerScore;
  final int aiScore;
  final int totalRounds;

  const MatchResultScreen({
    super.key,
    required this.winner,
    required this.playerScore,
    required this.aiScore,
    required this.totalRounds,
  });

  @override
  State<MatchResultScreen> createState() => _MatchResultScreenState();
}

class _MatchResultScreenState extends State<MatchResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(milliseconds: AppConstants.confettiDuration),
    );
    if (widget.winner == 'player') {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWin = widget.winner == 'player';
    final isLose = widget.winner == 'ai';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.orange,
                Colors.purple,
                Colors.cyan,
                Colors.pink,
                Colors.blue,
                Colors.green,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isWin ? '🎉 Kazandın!' : isLose ? '😔 Kaybettin!' : '🤝 Berabere!',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConstants.lg),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.lg),
                    child: Column(
                      children: [
                        Text(
                          'Skor',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppConstants.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('👤', style: TextStyle(fontSize: 24)),
                            const SizedBox(width: AppConstants.sm),
                            Text(
                              '${widget.playerScore}',
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: AppConstants.lg),
                            Text(
                              ':',
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(width: AppConstants.lg),
                            Text(
                              '${widget.aiScore}',
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: AppConstants.sm),
                            const Text('🤖', style: TextStyle(fontSize: 24)),
                          ],
                        ),
                        const SizedBox(height: AppConstants.md),
                        Text(
                          'Toplam Turlar: ${widget.totalRounds}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.xl),
                SizedBox(
                  width: double.infinity,
                  height: AppConstants.buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Tekrar Oyna'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
