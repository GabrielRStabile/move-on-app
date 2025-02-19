// ignore_for_file: invalid_use_of_internal_member

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/routing/router.dart';
import 'package:pull_down_button/pull_down_button.dart';

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
        primary: const Color(0xFFBBF246),
        primaryForeground: FThemes.zinc.light.colorScheme.primary,
        secondary: FThemes.zinc.light.colorScheme.primary,
        secondaryForeground: FThemes.zinc.light.colorScheme.primaryForeground,
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
      locale: const Locale('pt', 'BR'),
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          secondary: Color(0xFFBBF246),
        ),
        scaffoldBackgroundColor: theme.scaffoldStyle.backgroundColor,
        extensions: [
          PullDownButtonTheme(
            routeTheme: PullDownMenuRouteTheme(
              backgroundColor:
                  FThemes.zinc.light.colorScheme.primary.withValues(alpha: 0.8),
            ),
            itemTheme: PullDownMenuItemTheme(
              textStyle:
                  PullDownMenuItemTheme.defaults(context).textStyle?.copyWith(
                        color: FThemes.zinc.light.colorScheme.primaryForeground,
                      ),
              destructiveColor: FThemes.zinc.light.colorScheme.error,
              subtitleStyle: PullDownMenuItemTheme.defaults(context)
                  .subtitleStyle
                  ?.copyWith(
                    color: FThemes.zinc.light.colorScheme.primaryForeground,
                  ),
              iconActionTextStyle: PullDownMenuItemTheme.defaults(context)
                  .iconActionTextStyle
                  ?.copyWith(
                    color: FThemes.zinc.light.colorScheme.primaryForeground,
                  ),
            ),
          ),
        ],
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
