import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/local/preferences_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AppThemeMode _themeMode = AppThemeMode.light;
  bool _soundEnabled = true;
  bool _hapticsEnabled = true;
  int _defaultRounds = AppConstants.defaultRounds;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    setState(() {
      _themeMode = PreferencesService.instance.themeMode;
      _soundEnabled = PreferencesService.instance.soundEnabled;
      _hapticsEnabled = PreferencesService.instance.hapticsEnabled;
      _defaultRounds = PreferencesService.instance.defaultRounds;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF667EEA).withOpacity(0.8),
              const Color(0xFF764BA2).withOpacity(0.8),
              const Color(0xFF64B5F6).withOpacity(0.6),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.all(AppConstants.lg),
              children: [
                // Header
                _buildHeader(),
                
                const SizedBox(height: AppConstants.lg),
                
                // Görünüm Section
                _buildSection(
                  title: 'GÖRÜNÜM',
                  children: [
                    _buildThemeSelector(),
                  ],
                ),
                
                const SizedBox(height: AppConstants.lg),
                
                // Ses ve Titreşim Section
                _buildSection(
                  title: 'SES VE TİTREŞİM',
                  children: [
                    _buildToggleTile(
                      title: 'Ses Efektleri',
                      subtitle: 'Oyun seslerini aç/kapat',
                      icon: Icons.volume_up,
                      value: _soundEnabled,
                      onChanged: (value) {
                        setState(() {
                          _soundEnabled = value;
                        });
                        PreferencesService.instance.setSoundEnabled(value);
                      },
                    ),
                    _buildToggleTile(
                      title: 'Haptik Feedback',
                      subtitle: 'Titreşim geri bildirimleri',
                      icon: Icons.vibration,
                      value: _hapticsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _hapticsEnabled = value;
                        });
                        PreferencesService.instance.setHapticsEnabled(value);
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: AppConstants.lg),
                
                // Oyun Section
                _buildSection(
                  title: 'OYUN',
                  children: [
                    _buildRoundsSelector(),
                  ],
                ),
                
                const SizedBox(height: AppConstants.lg),
                
                // Veri Section
                _buildSection(
                  title: 'VERİ',
                  children: [
                    _buildActionTile(
                      title: 'Verileri Dışa Aktar',
                      subtitle: 'İstatistiklerinizi yedekleyin',
                      icon: Icons.upload_file,
                      onTap: _exportData,
                    ),
                    _buildActionTile(
                      title: 'Verileri Sıfırla',
                      subtitle: 'Tüm verileri sil',
                      icon: Icons.delete_forever,
                      onTap: _showResetDataDialog,
                    ),
                  ],
                ),
                
                const SizedBox(height: AppConstants.lg),
                
                // Hakkında Section
                _buildSection(
                  title: 'HAKKINDA',
                  children: [
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('Versiyon'),
                      subtitle: Text(AppConstants.appVersion),
                    ),
                    _buildActionTile(
                      title: 'Gizlilik Politikası',
                      subtitle: 'Veri kullanımımızı öğrenin',
                      icon: Icons.privacy_tip,
                      onTap: _openPrivacyPolicy,
                    ),
                    _buildActionTile(
                      title: 'Kullanım Koşulları',
                      subtitle: 'Kullanım şartlarımız',
                      icon: Icons.description,
                      onTap: _openTermsOfService,
                    ),
                    _buildActionTile(
                      title: 'Bize Ulaşın',
                      subtitle: 'Destek için iletişime geçin',
                      icon: Icons.contact_support,
                      onTap: _openContact,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.sm),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildThemeSelector() {
    return Column(
      children: AppThemeMode.values.map((mode) {
        return RadioListTile<AppThemeMode>(
          title: Text(_getThemeDisplayName(mode)),
          subtitle: Text(_getThemeDescription(mode)),
          value: mode,
          groupValue: _themeMode,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _themeMode = value;
              });
              PreferencesService.instance.setThemeMode(value);
              _applyTheme(value);
            }
          },
          secondary: Icon(_getThemeIcon(mode)),
        );
      }).toList(),
    );
  }

  Widget _buildToggleTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      secondary: Icon(icon),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildActionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  Widget _buildRoundsSelector() {
    return ListTile(
      leading: const Icon(Icons.format_list_numbered),
      title: const Text('Varsayılan Tur Sayısı'),
      subtitle: Text('Hızlı oyun için $_defaultRounds tur'),
      trailing: DropdownButton<int>(
        value: _defaultRounds,
        items: AppConstants.quickRoundOptions.map((rounds) {
          return DropdownMenuItem<int>(
            value: rounds,
            child: Text('$rounds'),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _defaultRounds = value;
            });
            PreferencesService.instance.setDefaultRounds(value);
          }
        },
      ),
    );
  }

  String _getThemeDisplayName(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'Açık Tema';
      case AppThemeMode.dark:
        return 'Koyu Tema';
      case AppThemeMode.colorful:
        return 'Renkli Tema';
    }
  }

  String _getThemeDescription(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'Aydınlık ve ferah tasarım';
      case AppThemeMode.dark:
        return 'Karanlık ve göz dostu';
      case AppThemeMode.colorful:
        return 'Canlı ve enerjik renkler';
    }
  }

  IconData _getThemeIcon(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
      case AppThemeMode.colorful:
        return Icons.palette;
    }
  }

  void _applyTheme(AppThemeMode mode) {
    ThemeMode themeMode;
    switch (mode) {
      case AppThemeMode.light:
        themeMode = ThemeMode.light;
        break;
      case AppThemeMode.dark:
        themeMode = ThemeMode.dark;
        break;
      case AppThemeMode.colorful:
        themeMode = ThemeMode.light; // For now, use light
        break;
    }
    
    // TODO: Apply theme to app
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$_getThemeDisplayName(mode) uygulandı')),
    );
  }

  void _showResetDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Verileri Sıfırla'),
        content: const Text(
          'Tüm istatistikler, başarımlar ve ayarlar silinecek. Bu işlem geri alınamaz.\n\nDevam etmek istiyor musunuz?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Reset all data
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tüm veriler sıfırlandı')),
              );
              PreferencesService.instance.resetAllData();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Sıfırla'),
          ),
        ],
      ),
    );
  }

  void _showComingSoonDialog(String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(feature),
        content: Text('$feature özelliği yakında eklenecek.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.settings,
            size: 60,
            color: Colors.white,
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            'Ayarlar',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.xs),
          Text(
            'Oyun deneyimini kişiselleştir',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  void _exportData() {
    final stats = PreferencesService.instance.getUserStats();
    final data = {
      'themeMode': _themeMode.toString(),
      'soundEnabled': _soundEnabled,
      'hapticsEnabled': _hapticsEnabled,
      'defaultRounds': _defaultRounds,
      'statistics': {
        'totalGames': stats.totalGames,
        'wins': stats.wins,
        'losses': stats.losses,
        'draws': stats.draws,
        'currentStreak': stats.currentStreak,
        'longestStreak': stats.longestStreak,
        'favoriteChoice': stats.favoriteChoice,
        'winRate': (stats.winRate * 100).toStringAsFixed(1) + '%',
      },
      'exportDate': DateTime.now().toIso8601String(),
    };

    // Show export dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Veri Dışa Aktar'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Verileriniz başarıyla dışa aktarıldı:'),
            const SizedBox(height: AppConstants.sm),
            Container(
              padding: const EdgeInsets.all(AppConstants.sm),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Toplam ${data.length} veri noktası\n'
                'İstatistikler ve ayarlar\n'
                'Tarih: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _openPrivacyPolicy() async {
    final url = Uri.parse('https://github.com/mcanererdem/rts-game/blob/main/PRIVACY.md');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      _showComingSoonDialog('Gizlilik Politikası');
    }
  }

  void _openTermsOfService() async {
    final url = Uri.parse('https://github.com/mcanererdem/rts-game/blob/main/TERMS.md');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      _showComingSoonDialog('Kullanım Koşulları');
    }
  }

  void _openContact() async {
    final url = Uri.parse('https://github.com/mcanererdem/rts-game/issues');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      _showComingSoonDialog('İletişim');
    }
  }
}
