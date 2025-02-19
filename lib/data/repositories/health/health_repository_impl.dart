import 'package:move_on_app/data/repositories/health/health_repository.dart';
import 'package:move_on_app/data/services/health/health_service.dart';
import 'package:result_dart/result_dart.dart';

/// Implementation of the [HealthRepository] interface.
class HealthRepositoryImpl implements HealthRepository {
  /// Creates a [HealthRepositoryImpl] with the given [healthService].
  HealthRepositoryImpl(this.healthService);

  /// The health service used to access health data.
  final IHealthService healthService;

  @override
  Future<Result<int>> getCalories(DateTime date) async {
    return healthService.getCalories(date);
  }

  @override
  Future<Result<int>> getWaterConsumption(DateTime date) async {
    return healthService.getWaterConsumption(date);
  }

  @override
  Future<Result<void>> saveCalories(DateTime date, int calories) async {
    return healthService.saveCalories(date, calories);
  }

  @override
  Future<Result<void>> saveWaterConsumption(
    DateTime date,
    int milliliters,
  ) async {
    return healthService.saveWaterConsumption(date, milliliters);
  }

  @override
  Future<Result<Duration>> getSleepHours(DateTime date) async {
    return healthService.getSleepHours(date);
  }
}
