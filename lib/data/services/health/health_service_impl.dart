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

      return Success(result ?? false);
    } catch (e) {
      return Failure(Exception('Falha verificar permissão de saúde'));
    }
  }

  @override
  Future<Result<int>> getCalories(DateTime date) async {
    try {
      final result = await _health.getHealthDataFromTypes(
        types: [HealthDataType.ACTIVE_ENERGY_BURNED],
        startTime: date.copyWith(hour: 0, minute: 0, second: 0),
        endTime: date.copyWith(hour: 23, minute: 59, second: 59),
      );

      if (result.isEmpty) {
        return const Success(0);
      }

      return Success(
        result.fold<int>(
          0,
          (sum, data) =>
              sum + (data.value as NumericHealthValue).numericValue.ceil(),
        ),
      );
    } catch (e) {
      return Failure(Exception('Falha ao obter a quantidade de calorias'));
    }
  }

  @override
  Future<Result<int>> getWaterConsumption(DateTime date) async {
    try {
      final result = await _health.getHealthDataFromTypes(
        types: [HealthDataType.WATER],
        startTime: date.copyWith(hour: 0, minute: 0, second: 0),
        endTime: date.copyWith(hour: 23, minute: 59, second: 59),
      );

      if (result.isEmpty) {
        return const Success(0);
      }

      return Success(
        ((result.first.value as NumericHealthValue).numericValue * 1000).ceil(),
      );
    } catch (e) {
      return Failure(Exception('Falha ao obter a quantidade de copos de água'));
    }
  }

  @override
  Future<Result<Unit>> saveWaterConsumption(
    DateTime date,
    int milliliters,
  ) async {
    try {
      await _health.writeHealthData(
        value: milliliters.toDouble(),
        type: HealthDataType.WATER,
        startTime: date,
        endTime: date,
        unit: HealthDataUnit.MILLILITER,
        recordingMethod: RecordingMethod.manual,
      );
      return const Success(unit);
    } catch (e) {
      return Failure(
        Exception('Falha ao salvar a quantidade de copos de água'),
      );
    }
  }

  @override
  Future<Result<Unit>> saveCalories(DateTime date, int calories) async {
    try {
      await _health.writeHealthData(
        value: calories.toDouble(),
        type: HealthDataType.ACTIVE_ENERGY_BURNED,
        startTime: date,
        endTime: date,
        unit: HealthDataUnit.KILOCALORIE,
        recordingMethod: RecordingMethod.manual,
      );

      return const Success(unit);
    } catch (e) {
      return Failure(Exception('Falha ao salvar a quantidade de calorias'));
    }
  }

  @override
  Future<Result<Duration>> getSleepHours(DateTime date) async {
    try {
      final result = await _health.getHealthDataFromTypes(
        types: [HealthDataType.SLEEP_ASLEEP],
        startTime: date.copyWith(hour: 0, minute: 0, second: 0),
        endTime: date.copyWith(hour: 23, minute: 59, second: 59),
      );

      if (result.isEmpty) {
        return const Success(Duration.zero);
      }

      final totalSleepInMinutes = result.fold<double>(
        0,
        (sum, data) => sum + (data.value as NumericHealthValue).numericValue,
      );

      return Success(Duration(minutes: totalSleepInMinutes.toInt()));
    } catch (e) {
      return Failure(Exception('Falha ao obter as horas de sono'));
    }
  }
}
