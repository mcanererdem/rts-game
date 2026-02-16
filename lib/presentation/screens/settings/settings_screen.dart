import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

enum AppThemeMode { light, dark, colorful }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.lg),
        children: [
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
                  // TODO: Save to preferences
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
                  // TODO: Save to preferences
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
                onTap: () {
                  // TODO: Export data
                  _showComingSoonDialog('Veri Dışa Aktar');
                },
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
                onTap: () {
                  // TODO: Open privacy policy
                  _showComingSoonDialog('Gizlilik Politikası');
                },
              ),
              _buildActionTile(
                title: 'Kullanım Koşulları',
                subtitle: 'Kullanım şartlarımız',
                icon: Icons.description,
                onTap: () {
                  // TODO: Open terms of service
                  _showComingSoonDialog('Kullanım Koşulları');
                },
              ),
              _buildActionTile(
                title: 'Bize Ulaşın',
                subtitle: 'Destek için iletişime geçin',
                icon: Icons.contact_support,
                onTap: () {
                  // TODO: Open contact
                  _showComingSoonDialog('İletişim');
                },
              ),
            ],
          ),
        ],
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
              // TODO: Apply theme and save
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
            // TODO: Save to preferences
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
}
