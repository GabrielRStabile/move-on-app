import 'package:dart_mappable/dart_mappable.dart';

part 'exercise_progress_entity.mapper.dart';

/// Represents the progress status of an exercise
@MappableEnum(mode: ValuesMode.named)
enum ExerciseStatus {
  /// Exercise not started
  notStarted,

  /// Exercise in progress
  inProgress,

  /// Exercise completed
  completed,
}

/// Represents the progress tracking of an exercise
@MappableClass()
class ExerciseProgressEntity with ExerciseProgressEntityMappable {
  /// Creates a new exercise progress entity
  ///
  /// [status] Current status of the exercise
  /// [completedPercentage] Percentage of completion (0-100)
  /// [lastUpdated] Last time the progress was updated
  ExerciseProgressEntity({
    required this.status,
    required this.completedPercentage,
    required this.lastUpdated,
  });

  /// Current status of the exercise
  final ExerciseStatus status;

  /// Percentage of completion (0-100)
  final double completedPercentage;

  /// Last time the progress was updated
  final DateTime lastUpdated;

  /// Factory methods for creating ExerciseProgressEntity from different sources
  static const fromMap = ExerciseProgressEntityMapper.fromMap;

  /// Factory methods for creating ExerciseProgressEntity from JSON
  static const fromJson = ExerciseProgressEntityMapper.fromJson;

  /// Returns the percentage as a formatted string
  String get percentageString => '${completedPercentage.toStringAsFixed(0)} %';
}

/// Extension methods for creating dummy ExerciseProgressEntity instances
extension ExerciseProgressEntityDummy on ExerciseProgressEntity {
  /// Creates a single dummy progress
  static ExerciseProgressEntity dummy({
    ExerciseStatus? status,
    double? completedPercentage,
  }) =>
      ExerciseProgressEntity(
        status: status ?? ExerciseStatus.inProgress,
        completedPercentage: completedPercentage ?? 50,
        lastUpdated: DateTime.now(),
      );
}
