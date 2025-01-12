import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/routing/router.dart';

/// {@template move_on_app}
/// Root widget for the MoveOn application.
///
/// This class sets up the fundamental elements of the app, including:
/// * Localization settings
/// * Route configuration
/// * Custom theming using FTheme
/// {@endtemplate}
class MoveOnApp extends StatefulWidget {
  /// {@macro move_on_app}
  const MoveOnApp({super.key});

  @override
  State<MoveOnApp> createState() => _MoveOnAppState();
}

class _MoveOnAppState extends State<MoveOnApp> {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final theme = FThemeData.inherit(
      colorScheme: FThemes.zinc.light.colorScheme.copyWith(
        secondary: const Color(0xFFBBF246),
        secondaryForeground: FThemes.zinc.light.colorScheme.primary,
      ),
      style: FThemes.zinc.light.style.copyWith(
        borderRadius: BorderRadius.circular(20),
      ),
    );

    return MaterialApp.router(
      routerConfig: appRouter.config(),
      title: 'MoveOn',
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      theme: ThemeData(
        scaffoldBackgroundColor: theme.scaffoldStyle.backgroundColor,
      ),
      builder: (context, child) {
        return FTheme(
          data: theme,
          child: child!,
        );
      },
    );
  }
}
