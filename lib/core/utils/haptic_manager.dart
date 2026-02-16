import 'package:flutter/material.dart';
import '../../data/local/preferences_service.dart';

class HapticManager {
  static HapticManager? _instance;
  static HapticManager get instance => _instance ??= HapticManager._();

  HapticManager._();

  bool get _isEnabled => PreferencesService.instance.hapticsEnabled;

  Future<void> lightImpact() async {
    if (!_isEnabled) return;
    // Web'de haptik desteklenmiyor
    debugPrint('Light haptic feedback');
  }

  Future<void> mediumImpact() async {
    if (!_isEnabled) return;
    debugPrint('Medium haptic feedback');
  }

  Future<void> heavyImpact() async {
    if (!_isEnabled) return;
    debugPrint('Heavy haptic feedback');
  }

  Future<void> selectionClick() async {
    if (!_isEnabled) return;
    debugPrint('Selection haptic feedback');
  }

  Future<void> notification() async {
    if (!_isEnabled) return;
    debugPrint('Notification haptic feedback');
  }

  Future<void> error() async {
    if (!_isEnabled) return;
    debugPrint('Error haptic feedback');
  }

  Future<void> success() async {
    if (!_isEnabled) return;
    debugPrint('Success haptic feedback');
  }

  void toggle() {
    // Settings screen'dan yönetilecek
  }
}
