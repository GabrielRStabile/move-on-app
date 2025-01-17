import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// A utility class that provides common text styles for the application.
///
/// This class uses the app's theme context to generate consistent text styles
/// across the application.
class CommonTextStyle {
  /// Creates a [CommonTextStyle] instance with the given [BuildContext].
  ///
  /// The [context] is used to access the app's theme data.
  CommonTextStyle.of(
    BuildContext context,
  ) : _context = context;

  final BuildContext _context;

  /// A headline 1 text style with extra-large size and bold weight.
  ///
  /// Uses the theme's extra-large typography with a font weight of 800 (bold).
  TextStyle get h1 =>
      FTheme.of(_context).typography.xl5.copyWith(fontWeight: FontWeight.w800);

  /// A headline 2 text style with extra-large size and semi-bold weight.
  ///
  /// Uses the theme's extra-large typography with a font weight of 600
  /// (semi-bold).
  TextStyle get h2 =>
      FTheme.of(_context).typography.xl3.copyWith(fontWeight: FontWeight.w600);

  /// A headline 3 text style with extra-large size and semi-bold weight.
  ///
  /// Uses the theme's extra-large typography with a font weight of 600
  /// (semi-bold).
  TextStyle get h3 =>
      FTheme.of(_context).typography.xl2.copyWith(fontWeight: FontWeight.w600);

  /// A large text style with semi-bold weight.
  ///
  /// Uses the theme's large typography with a font weight of 600 (semi-bold).
  TextStyle get large =>
      FTheme.of(_context).typography.lg.copyWith(fontWeight: FontWeight.w600);

  /// A medium text style with medium weight.
  ///
  /// Uses the theme's base typography with a font weight of 500 (medium).
  TextStyle get pUiMedium =>
      FTheme.of(_context).typography.base.copyWith(fontWeight: FontWeight.w500);

  /// A small text style with medium weight.
  ///
  /// Uses the theme's small typography with a font weight of 500 (medium).
  TextStyle get small =>
      FTheme.of(_context).typography.sm.copyWith(fontWeight: FontWeight.w500);

  /// A subtitle text style with semi-bold weight.
  ///
  /// Uses the theme's small typography with a font weight of 600 (semi-bold).
  TextStyle get subtitleSemiBold =>
      FTheme.of(_context).typography.sm.copyWith(fontWeight: FontWeight.w600);

  /// A subtitle text style with regular weight.
  ///
  /// Uses the theme's small typography with a font weight of 400 (regular).
  TextStyle get subtitle =>
      FTheme.of(_context).typography.sm.copyWith(fontWeight: FontWeight.w400);

  /// A detail text style with medium weight.
  ///
  /// Uses the theme's extra-small typography with a font weight of 500 (medium).
  TextStyle get detail =>
      FTheme.of(_context).typography.xs.copyWith(fontWeight: FontWeight.w500);
}
