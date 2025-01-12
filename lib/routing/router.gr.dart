// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:move_on_app/ui/onboarding/widgets/onboarding_screen.dart'
    as _i1;
import 'package:move_on_app/ui/register/widgets/register_screen.dart' as _i2;

/// generated route for
/// [_i1.OnboardingScreen]
class OnboardingRoute extends _i3.PageRouteInfo<void> {
  const OnboardingRoute({List<_i3.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i2.RegisterScreen]
class RegisterRoute extends _i3.PageRouteInfo<void> {
  const RegisterRoute({List<_i3.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.RegisterScreen();
    },
  );
}
