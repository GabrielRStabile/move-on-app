import 'dart:convert';

import 'package:move_on_app/data/services/workouts/progress_service.dart';
import 'package:move_on_app/domain/entities/workout_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressServiceImpl implements IProgressService {
  ProgressServiceImpl(this._prefs);
  final SharedPreferences _prefs;

  String _getProgressKey(String workoutId, DateTime date) {
    final formatedDate =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    return 'exercise_progress_${workoutId}_$formatedDate';
  }

  @override
  Future<void> saveWorkout(WorkoutEntity workout) async {
    final key = _getProgressKey(workout.id, DateTime.now());

    await _prefs.setString(key, jsonEncode(workout.toMap()));
  }

  @override
  Future<WorkoutEntity?> getWorkout(String workoutId) async {
    final key = _getProgressKey(workoutId, DateTime.now());
    final json = _prefs.getString(key);

    if (json == null) return null;

    final workout = WorkoutEntity.fromJson(json);

    return workout;
  }

  @override
  Future<WorkoutEntity?> getWorkoutByDate(DateTime date) async {
    final keys = _prefs.getKeys();

    final key = keys.firstWhere(
      (key) => key.contains(
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day}',
      ),
      orElse: () => '',
    );

    if (key.isEmpty) return null;

    final json = _prefs.getString(key);

    if (json == null) return null;

    final workout = WorkoutEntity.fromJson(json);

    return workout;
  }
}
