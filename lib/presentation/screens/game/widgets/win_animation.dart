import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class WinAnimation extends StatefulWidget {
  final Widget child;
  final bool showAnimation;

  const WinAnimation({
    super.key,
    required this.child,
    this.showAnimation = false,
  });

  @override
  State<WinAnimation> createState() => _WinAnimationState();
}

class _WinAnimationState extends State<WinAnimation>
    with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOutBack,
    ));

    if (widget.showAnimation) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    _confettiController.play();
    _scaleController.forward();
    _rotationController.forward();
  }

  @override
  void didUpdateWidget(WinAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showAnimation && !oldWidget.showAnimation) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.showAnimation)
          Positioned.fill(
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.1,
              colors: [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
                Colors.yellow,
              ],
            ),
          ),
        if (widget.showAnimation)
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value * 0.1,
                  child: child,
                ),
              );
            },
            child: widget.child,
          ),
      ],
    );
  }
}
