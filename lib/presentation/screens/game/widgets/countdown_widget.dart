import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_constants.dart';

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({super.key});

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> 
    with TickerProviderStateMixin {
  late AnimationController _controller;
  int _count = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: AppConstants.countdownDuration),
      vsync: this,
    );
    
    _startCountdown();
  }

  void _startCountdown() async {
    for (int i = 3; i >= 1; i--) {
      setState(() {
        _count = i;
      });
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$_count',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ).animate(controller: _controller)
      .scale(
        begin: const Offset(0.5, 0.5),
        end: const Offset(1.2, 1.2),
        duration: 400.ms,
        curve: Curves.easeOutBack,
      )
      .then()
      .scale(
        begin: const Offset(1.2, 1.2),
        end: const Offset(1.0, 1.0),
        duration: 200.ms,
        curve: Curves.easeInBack,
      );
  }
}
