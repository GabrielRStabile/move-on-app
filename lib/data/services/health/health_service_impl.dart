import 'package:health/health.dart';
import 'package:move_on_app/data/services/health/health_service.dart';
import 'package:result_dart/result_dart.dart';

/// Implementation of [IHealthService] that handles health data operations
class HealthService implements IHealthService {
  /// Initializes the health service with an optional [Health] instance
  HealthService({Health? health}) : _health = health ?? Health();

  /// Instance of Health package to interact with platform health APIs
  late final Health _health;

  @override
  Future<void> init() async => _health.configure();

  @override
  Future<Result<bool>> requestAuthorization(
    List<HealthDataType> dataTypes, {
    List<HealthDataAccess>? permissions,
  }) async {
    try {
      final result = await _health.requestAuthorization(
        dataTypes,
        permissions: permissions,
      );

      return Success(result);
    } catch (e) {
      return Failure(Exception('Falha ao solicitar permissão de saúde'));
    }
  }

  @override
  Future<Result<bool>> hasAuthorization(
    List<HealthDataType> dataTypes, {
    List<HealthDataAccess>? permissions,
  }) async {
    try {
      final result = await _health.hasPermissions(
        dataTypes,
        permissions: permissions,
      );

      return Success(result ?? true);
    } catch (e) {
      return Failure(Exception('Falha verificar permissão de saúde'));
    }
  }
}
