import 'package:auto_injector/auto_injector.dart';
import 'package:flutter/foundation.dart';
import 'package:move_on_app/data/repositories/health/health_repository.dart';
import 'package:move_on_app/data/repositories/health/health_repository_impl.dart';
import 'package:move_on_app/data/repositories/permission/permission_repository.dart';
import 'package:move_on_app/data/repositories/permission/permission_repository_impl.dart';
import 'package:move_on_app/data/repositories/workout/workout_repository.dart';
import 'package:move_on_app/data/repositories/workout/workout_repository_impl.dart';
import 'package:move_on_app/data/services/health/health_service.dart';
import 'package:move_on_app/data/services/health/health_service_impl.dart';
import 'package:move_on_app/data/services/permission/permission_service.dart';
import 'package:move_on_app/data/services/permission/permission_service_impl.dart';
import 'package:move_on_app/data/services/user/user_service.dart';
import 'package:move_on_app/data/services/user/user_service_impl.dart';
import 'package:move_on_app/data/services/workouts/progress_service.dart';
import 'package:move_on_app/data/services/workouts/progress_service_impl.dart';
import 'package:move_on_app/data/services/workouts/workout_client_http.dart';
import 'package:move_on_app/ui/me/view_models/home_view_model.dart';
import 'package:move_on_app/ui/me/view_models/search_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global dependency injection instance
DI get di => internalDi;

/// Internal dependency injection instance
@visibleForTesting
DI internalDi = DIImpl();

/// Interface for dependency injection container
abstract interface class DI {
  /// Gets an instance of type [T] from the container
  ///
  /// [key] - Optional key to identify the instance
  T get<T>({String? key});

  /// Registers all dependencies in the container
  /// This method should be called only on app startup
  Future<void> registerAll();
}

/// Implementation of dependency injection container using AutoInjector
class DIImpl implements DI {
  /// AutoInjector instance used for dependency management
  @visibleForTesting
  AutoInjector autoInjector = AutoInjector();

  @override
  T get<T>({String? key}) {
    return autoInjector.get(key: key);
  }

  @override
  Future<void> registerAll() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    autoInjector
      ..addInstance<SharedPreferences>(sharedPreferences)
      ..addSingleton<IHealthService>(HealthService.new)
      ..add<IPermissionService>(PermissionService.new)
      ..add<WorkoutClientHttp>(WorkoutClientHttp.new)
      ..add<IProgressService>(ProgressServiceImpl.new)
      ..add<IUserService>(UserServiceImpl.new)
      ..addSingleton<WorkoutRepository>(WorkoutRepositoryImpl.new)
      ..addSingleton<IPermissionRepository>(PermissionRepository.new)
      ..addSingleton<HealthRepository>(HealthRepositoryImpl.new)
      ..addLazySingleton<HomeViewModel>(HomeViewModel.new)
      ..addLazySingleton<SearchViewModel>(SearchViewModel.new)
      ..commit();
  }
}
