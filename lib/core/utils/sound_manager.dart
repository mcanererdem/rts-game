import 'package:flutter/material.dart';
import '../../data/local/preferences_service.dart';

class SoundManager {
  static SoundManager? _instance;
  static SoundManager get instance => _instance ??= SoundManager._();

  SoundManager._();

  bool get _isMuted => !PreferencesService.instance.soundEnabled;

  void playSound(SoundType soundType) {
    if (_isMuted) return;
    
    // Web'de ses çalmak için HTML5 Audio API kullanılabilir
    // Şimdilik placeholder implementation
    debugPrint('Playing sound: ${soundType.name}');
  }

  void toggleMute() {
    // Settings screen'dan yönetilecek
    // Bu method UI'dan çağrılacak
  }
}

enum SoundType {
  countdown,
  win,
  lose,
  draw,
  click,
  achievement,
}
