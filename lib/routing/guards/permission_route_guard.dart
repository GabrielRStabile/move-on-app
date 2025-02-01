import 'package:auto_route/auto_route.dart';
import 'package:move_on_app/data/repositories/permission/permission_repository.dart';
import 'package:move_on_app/di/dependency_injection.dart';
import 'package:move_on_app/routing/router.gr.dart';

/// A route guard that checks for required app permissions before navigation.
///
/// This guard verifies if the user has granted both health and notification
/// permissions. If any permission is missing, it redirects to the permission
/// asking screen before proceeding with the navigation.
///
/// Example usage:
/// ```dart
/// @AutoRouterConfig()
/// class AppRouter extends RootStackRouter {
///   @override
///   List<AutoRoute> get routes => [
///         CustomRoute<OnboardingRoute>(
///           path: '/route',
///           page: OnboardingRoute.page,
///           guards: [PermissionRouteGuard()],
///         ),
///       ];
// }
/// ```
class PermissionRouteGuard extends AutoRouteGuard {
  final IPermissionRepository _permissionRepository = di.get();

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final results = (await Future.wait([
      _permissionRepository.hasHealthPermission(),
      _permissionRepository.hasNotificationPermission(),
    ]))
        .map((e) => e.getOrNull() ?? false);

    if (results.every((permission) => permission)) {
      resolver.next();
    } else {
      await resolver.redirect(const PermissionAskingRoute()).then((_) {
        resolver.next();
      });
    }
  }
}
