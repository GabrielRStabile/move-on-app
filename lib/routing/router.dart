import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:move_on_app/routing/guards/permission_route_guard.dart';
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
        AdaptiveRoute<OnboardingRoute>(
          path: '/onboarding',
          page: OnboardingRoute.page,
          initial: true,
        ),
        CustomRoute<PermissionAskingRoute>(
          path: '/permission',
          page: PermissionAskingRoute.page,
          customRouteBuilder: _modalSheetBuilder,
        ),
        AdaptiveRoute<RegisterRoute>(
          path: '/register',
          page: RegisterRoute.page,
        ),
        AdaptiveRoute<VideoRoute>(
          page: VideoRoute.page,
          path: '/video',
        ),
        AdaptiveRoute<MeRoute>(
          path: '/me',
          page: MeRoute.page,
          guards: [
            PermissionRouteGuard(),
          ],
          children: [
            AdaptiveRoute<HomeRoute>(
              path: 'home',
              page: HomeRoute.page,
            ),
            AdaptiveRoute<ExploreRoute>(
              path: 'explore',
              page: ExploreRoute.page,
            ),
            AdaptiveRoute<ActivityRoute>(
              path: 'activity',
              page: ActivityRoute.page,
            ),
          ],
        ),
      ];

  Route<T> _modalSheetBuilder<T>(
    BuildContext context,
    Widget child,
    RouteSettings page,
  ) {
    return CupertinoSheetRoute(
      settings: page,
      builder: (context) => child,
    );
  }
}
