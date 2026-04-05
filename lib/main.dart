import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'data/database/database_helper.dart';
import 'data/providers/progress_provider.dart';
import 'data/providers/character_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  await DatabaseHelper.instance.initialize();

  runApp(const AventuraHistoriaApp());
}

/// Main application widget
class AventuraHistoriaApp extends StatelessWidget {
  final ProgressProvider? progressProvider;
  final CharacterProvider? characterProvider;

  const AventuraHistoriaApp({
    super.key,
    this.progressProvider,
    this.characterProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        if (progressProvider != null)
          ChangeNotifierProvider<ProgressProvider>.value(
              value: progressProvider!)
        else
          ChangeNotifierProvider(create: (_) => ProgressProvider()),
        if (characterProvider != null)
          ChangeNotifierProvider<CharacterProvider>.value(
              value: characterProvider!)
        else
          ChangeNotifierProvider(create: (_) => CharacterProvider()),
      ],
      child: MaterialApp(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,

        // Portuguese (Portugal) localization
        locale: const Locale('pt', 'PT'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'PT'),
        ],

        home: const SplashScreen(),
      ),
    );
  }
}
