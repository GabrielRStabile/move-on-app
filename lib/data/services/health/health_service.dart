import 'package:health/health.dart';
import 'package:result_dart/result_dart.dart';

/// Interface for handling health-related operations using the Health package
abstract interface class IHealthService {
  /// Initializes the health service and configures required settings
  Future<void> init();

  /// Requests authorization for specific health data types
  ///
  /// [dataTypes] - List of health data types to request access for
  /// [permissions] - Optional list of specific access permissions
  /// Returns a [Result] indicating if the authorization was granted
  Future<Result<bool>> requestAuthorization(
    List<HealthDataType> dataTypes, {
    List<HealthDataAccess>? permissions,
  });

  /// Checks if the app has authorization for specific health data types
  ///
  /// [dataTypes] - List of health data types to check access for
  /// [permissions] - Optional list of specific access permissions
  /// Returns a [Result] indicating if the authorization exists
  Future<Result<bool>> hasAuthorization(
    List<HealthDataType> dataTypes, {
    List<HealthDataAccess>? permissions,
  });

  /// Retrieves the number of calories burned on a specific date.
  ///
  /// Returns a [Result] containing the number of calories or an error.
  Future<Result<int>> getCalories(DateTime date);

  /// Retrieves the number of milliliters consumed on a specific date.
  ///
  /// Returns a [Result] containing the number of milliliters or an error.
  Future<Result<int>> getWaterConsumption(DateTime date);

  /// Saves the quantity of millilitters consumed on a specific date.
  ///
  /// Returns a [Result] indicating success or failure.
  Future<Result<Unit>> saveWaterConsumption(DateTime date, int milliliters);

  /// Saves the number of calories burned on a specific date.
  ///
  /// Returns a [Result] indicating success or failure.
  Future<Result<Unit>> saveCalories(DateTime date, int calories);

  /// Retrieves the hours of sleep for a specific date.
  ///
  /// Returns a [Result] containing the sleep duration in hours or an error.
  Future<Result<Duration>> getSleepHours(DateTime date);
}
