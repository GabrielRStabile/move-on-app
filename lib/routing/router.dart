import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:move_on_app/routing/router.gr.dart';

/// A router configuration class that handles navigation in the application.
///
/// This class extends [RootStackRouter] and uses the auto_route package
/// to handle route management. It is annotated with [@AutoRouterConfig]
/// to enable code generation for route configuration.
///
/// The [routes] getter defines all available routes in the application.
/// Currently, the routes list is empty and needs to be populated with
/// [AutoRoute] entries for each screen in the application.
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        CustomRoute<OnboardingRoute>(
          path: '/onboarding',
          page: OnboardingRoute.page,
          customRouteBuilder: _defaultCustomRoute,
        ),
        CustomRoute<RegisterRoute>(
          path: '/register',
          page: RegisterRoute.page,
          customRouteBuilder: _defaultCustomRoute,
        ),
        CustomRoute<MeRoute>(
          path: '/me',
          page: MeRoute.page,
          initial: true,
          customRouteBuilder: _defaultCustomRoute,
          children: [
            CustomRoute<HomeRoute>(
              path: 'home',
              page: HomeRoute.page,
              customRouteBuilder: _defaultCustomRoute,
            ),
            CustomRoute<ExploreRoute>(
              path: 'explore',
              page: ExploreRoute.page,
              customRouteBuilder: _defaultCustomRoute,
            ),
            CustomRoute<ProgressRoute>(
              path: 'progress',
              page: ProgressRoute.page,
              customRouteBuilder: _defaultCustomRoute,
            ),
          ],
        ),
      ];

  Route<T> _defaultCustomRoute<T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<T> page,
  ) {
    return MaterialWithModalsPageRoute<T>(
      fullscreenDialog: page.fullscreenDialog,
      settings: page,
      builder: (context) => child,
    );
  }
}
