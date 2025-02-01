import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:pull_down_button/pull_down_button.dart';

Future<void> testApp(
  WidgetTester tester,
  Widget body, {
  bool isDark = false,
}) async {
  tester.view.devicePixelRatio = 1.0;
  await tester.binding.setSurfaceSize(const Size(1200, 800));

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

  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
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
          ),
        ],
      ),
      home: FTheme(
        data: isDark ? FThemes.zinc.dark : theme,
        child: Scaffold(body: body),
      ),
    ),
  );
}
