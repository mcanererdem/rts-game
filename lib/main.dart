import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'presentation/theme/app_theme.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/screens/splash/splash_screen.dart';
import 'data/local/preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.instance.init();
  await ThemeProvider().loadTheme();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: AppConstants.appName,
            theme: themeProvider.getTheme(),
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
