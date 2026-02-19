import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Game Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '🗿',
                    style: const TextStyle(fontSize: 48),
                  ).animate().scale(delay: 200.ms, duration: 300.ms),
                  const SizedBox(width: AppConstants.sm),
                  Text(
                    '📄',
                    style: const TextStyle(fontSize: 48),
                  ).animate().scale(delay: 400.ms, duration: 300.ms),
                  const SizedBox(width: AppConstants.sm),
                  Text(
                    '✂️',
                    style: const TextStyle(fontSize: 48),
                  ).animate().scale(delay: 600.ms, duration: 300.ms),
                ],
              ),
              
              const SizedBox(height: AppConstants.lg),
              
              // App Title
              Text(
                AppConstants.appName,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(delay: 800.ms, duration: 500.ms),
              
              const SizedBox(height: AppConstants.xl),
              
              // Loading Indicator
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white.withOpacity(0.8),
                ),
              ).animate().fadeIn(delay: 1200.ms, duration: 300.ms),
              
              const SizedBox(height: AppConstants.md),
              
              Text(
                'Yükleniyor...',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ).animate().fadeIn(delay: 1200.ms, duration: 300.ms),
            ],
          ),
        ),
      ),
    );
  }
}
