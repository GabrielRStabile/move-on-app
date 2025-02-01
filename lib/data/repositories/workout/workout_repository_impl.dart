import 'dart:async';

import 'package:diacritic/diacritic.dart';
import 'package:move_on_app/data/repositories/workout/workout_repository.dart';
import 'package:move_on_app/data/services/workouts/workout_client_http.dart';
import 'package:move_on_app/domain/entities/exercise_entity.dart';
import 'package:move_on_app/domain/entities/workout_entity.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

/// Implementation of WorkoutRepository interface
class WorkoutRepositoryImpl implements WorkoutRepository {
  /// Creates a workout repository implementation with the required HTTP client
  WorkoutRepositoryImpl(this._client);

  final WorkoutClientHttp _client;

  /// Controller for broadcasting workout updates
  final StreamController<List<WorkoutEntity>> _workoutsController =
      StreamController.broadcast();

  /// Internal cache of all workouts
  final List<WorkoutEntity> _allWorkouts = [];

  @override
  List<WorkoutEntity> get allWorkouts => _allWorkouts;

  @override
  Stream<List<WorkoutEntity>> get allWorkoutsObservable =>
      _workoutsController.stream;

  @override
  AsyncResult<List<WorkoutEntity>> getAllWorkouts() async {
    final result = await _client.getAllWorkouts().onSuccess((workouts) {
      _allWorkouts
        ..clear()
        ..addAll(workouts);
      _workoutsController.add(workouts);
    });

    return result;
  }

  @override
  AsyncResult<Unit> updateProgress(WorkoutEntity workout) async {
    // TODO: implement updateProgress on LocalStorage

    final lastWorkouts = _allWorkouts;

    final updatedWorkouts = lastWorkouts.map((w) {
      if (w.id == workout.id) {
        return workout;
      }
      return w;
    }).toList();

    _workoutsController.add(updatedWorkouts);
    _allWorkouts
      ..clear()
      ..addAll(updatedWorkouts);

    return successOf(unit);
  }

  @override
  void dispose() {
    _workoutsController.close();
  }

  @override
  AsyncResult<List<ExerciseEntity>> searchExercises(String query) async {
    var lastWorkouts = _allWorkouts;

    if (lastWorkouts.isEmpty) {
      (await getAllWorkouts()).onSuccess((workouts) {
        lastWorkouts = workouts;
      });
    }

    final result = lastWorkouts
        .map((workout) => workout.exercises)
        .expand((exercises) => exercises)
        .where(
          (exercise) => removeDiacritics(exercise.name.toLowerCase()).contains(
            removeDiacritics(query.toLowerCase()),
          ),
        )
        .toList();

    return successOf(result);
  }
}
