import 'package:move_on_app/domain/entities/workout_entity.dart';

abstract interface class IProgressService {
  Future<void> saveWorkout(WorkoutEntity workout);

  Future<WorkoutEntity?> getWorkout(String workoutId);

  Future<WorkoutEntity?> getWorkoutByDate(DateTime date);
}
