import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:move_on_app/data/repositories/permission/permission_repository.dart';
import 'package:move_on_app/data/services/health/health_service.dart';
import 'package:move_on_app/data/services/permission/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:result_dart/result_dart.dart';

/// Implementation of [IPermissionRepository] that manages app permissions
class PermissionRepository implements IPermissionRepository {
  /// Creates a new instance of [PermissionRepository]
  ///
  /// [_permissionService] - Service for handling device permissions
  /// [_healthService] - Service for handling health-related permissions
  PermissionRepository(
    this._permissionService,
    this._healthService,
  );

  /// Service for handling device permissions
  final IPermissionService _permissionService;

  /// Service for handling health-related permissions
  final IHealthService _healthService;

  /// List of health data types that the app needs access to
  final _healthDataTypes = [
    HealthDataType.WEIGHT,
    HealthDataType.HEIGHT,
    HealthDataType.GENDER,
    HealthDataType.BIRTH_DATE,
    HealthDataType.WATER,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.SLEEP_ASLEEP,
  ];

  @override
  Future<Result<bool>> requestHealthPermission() async {
    final results = <bool>[];

    if (defaultTargetPlatform == TargetPlatform.android) {
      final activityRecognitionStatus = await _permissionService
          .requestPermission(Permission.activityRecognition);

      results.add(
        activityRecognitionStatus
                .map((status) => status.isGranted)
                .getOrNull() ??
            false,
      );
    }

    final healthStatus = await _healthService.requestAuthorization(
      _healthDataTypes,
      permissions: List.generate(
        _healthDataTypes.length,
        (_) => HealthDataAccess.READ_WRITE,
      ),
    );

    results.add(
      healthStatus.map((status) => status).getOrNull() ?? false,
    );

    return results.every((element) => element)
        ? const Success(true)
        : Failure(Exception('Permissões não concedidas'));
  }

  @override
  Future<Result<bool>> hasHealthPermission() async {
    final results = <bool>[];

    if (defaultTargetPlatform == TargetPlatform.android) {
      final activityRecognitionStatus = await _permissionService
          .checkPermission(Permission.activityRecognition);

      results.add(
        activityRecognitionStatus
                .map((status) => status.isGranted)
                .getOrNull() ??
            false,
      );
    }

    final healthStatus = await _healthService.hasAuthorization(
      _healthDataTypes,
      permissions: List.generate(
        _healthDataTypes.length,
        (_) => HealthDataAccess.READ_WRITE,
      ),
    );

    results.add(
      healthStatus.map((status) => status).getOrNull() ?? false,
    );

    return results.every((element) => element)
        ? const Success(true)
        : const Success(false);
  }

  @override
  Future<Result<bool>> requestNotificationPermission() async {
    final result =
        await _permissionService.requestPermission(Permission.notification);

    return result.map((status) => status.isGranted);
  }

  @override
  Future<Result<bool>> hasNotificationPermission() async {
    final result =
        await _permissionService.checkPermission(Permission.notification);

    return result.map((status) => status.isGranted);
  }
}
