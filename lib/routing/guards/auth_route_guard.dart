import 'package:auto_route/auto_route.dart';
import 'package:move_on_app/data/services/user/user_service.dart';
import 'package:move_on_app/di/dependency_injection.dart';
import 'package:move_on_app/routing/router.gr.dart';

class AuthRouteGuard extends AutoRouteGuard {
  final IUserService userService = di.get();

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final isAuthenticated = await userService.isLogged();

    if (isAuthenticated) {
      await router.replace(const MeRoute());
    } else {
      resolver.next();
    }
  }
}
