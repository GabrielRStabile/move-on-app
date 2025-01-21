import 'package:auto_injector/auto_injector.dart';
import 'package:move_on_app/data/repositories/permission/permission_repository.dart';
import 'package:move_on_app/data/repositories/permission/permission_repository_impl.dart';
import 'package:move_on_app/data/services/health/health_service.dart';
import 'package:move_on_app/data/services/health/health_service_impl.dart';
import 'package:move_on_app/data/services/permission/permission_service.dart';
import 'package:move_on_app/data/services/permission/permission_service_impl.dart';

/// Global dependency injection instance
DI di = DIImpl();

/// Interface for dependency injection container
abstract interface class DI {
  /// Gets an instance of type [T] from the container
  ///
  /// [key] - Optional key to identify the instance
  T get<T>({String? key});

  /// Registers all dependencies in the container
  /// This method should be called only on app startup
  void registerAll();
}

/// Implementation of dependency injection container using AutoInjector
class DIImpl implements DI {
  /// AutoInjector instance used for dependency management
  final autoInjector = AutoInjector();

  @override
  T get<T>({String? key}) {
    return autoInjector.get(key: key);
  }

  @override
  void registerAll() {
    autoInjector
      ..addSingleton<IHealthService>(HealthService.new)
      ..addSingleton<IPermissionService>(PermissionService.new)
      ..addSingleton<IPermissionRepository>(PermissionRepository.new)
      ..commit();
  }
}
