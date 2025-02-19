import 'package:result_dart/result_dart.dart';

/// Abstract interface for accessing and managing health data.
abstract interface class HealthRepository {
  /// Retrieves the number of milliliters of water consumed on a specific date.
  ///
  /// Returns a [Result] containing the number of water cups or an error.
  Future<Result<int>> getWaterConsumption(DateTime date);

  /// Retrieves the number of calories burned on a specific date.
  ///
  /// Returns a [Result] containing the number of calories or an error.
  Future<Result<int>> getCalories(DateTime date);

  /// Saves the number milliliters of water consumed on a specific date.
  ///
  /// Returns a [Result] indicating success or failure.
  Future<Result<void>> saveWaterConsumption(DateTime date, int mililliters);

  /// Saves the number of calories burned on a specific date.
  ///
  /// Returns a [Result] indicating success or failure.
  Future<Result<void>> saveCalories(DateTime date, int calories);

  /// Retrieves the hours of sleep for a specific date.
  ///
  /// Returns a [Result] containing the sleep duration in hours or an error.
  Future<Result<Duration>> getSleepHours(DateTime date);
}
