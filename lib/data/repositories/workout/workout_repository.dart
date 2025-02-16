import 'package:move_on_app/domain/entities/exercise_entity.dart';
import 'package:move_on_app/domain/entities/workout_entity.dart';
import 'package:result_dart/result_dart.dart';

/// Repository interface for managing workout data
abstract interface class WorkoutRepository {
  /// Stream of all workouts for real-time updates
  Stream<List<WorkoutEntity>> get allWorkoutsObservable;

  /// Current list of all workouts
  List<WorkoutEntity> get allWorkouts;

  /// Fetches all available workouts
  AsyncResult<List<WorkoutEntity>> getAllWorkouts();

  /// Updates the progress of a workout
  AsyncResult<Unit> updateProgress(WorkoutEntity workout);

  /// Cleans up resources
  void dispose();

  /// Searches for exercises matching the query
  AsyncResult<List<ExerciseEntity>> searchExercises(String query);
}
