import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:move_on_app/data/repositories/workout/workout_repository.dart';
import 'package:move_on_app/domain/entities/workout_entity.dart';

/// ViewModel responsible for managing home screen workout data
class HomeViewModel extends ChangeNotifier {
  /// Creates a home view model with required workout repository
  HomeViewModel({
    required WorkoutRepository workoutRepository,
  }) : _workoutRepository = workoutRepository {
    loadWorkouts();
  }

  final WorkoutRepository _workoutRepository;

  /// List of popular workouts to display
  List<WorkoutEntity> get popularWorkouts => _popularWorkouts;
  final List<WorkoutEntity> _popularWorkouts = [];

  /// Today's recommended workout
  WorkoutEntity? get todayWorkout => _todayWorkout;
  WorkoutEntity? _todayWorkout;

  /// Whether data is currently being loaded
  bool get isLoading => _isLoading;
  bool _isLoading = true;

  /// Whether an error occurred during loading
  bool get hasError => _hasError;
  bool _hasError = false;

  /// Subscription to workout updates
  StreamSubscription<List<WorkoutEntity>>? _workoutsSubscription;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  /// Loads all workouts from the repository
  /// and sets the popular and today workouts
  Future<void> loadWorkouts() async {
    _workoutsSubscription ??=
        _workoutRepository.allWorkoutsObservable.listen(_onWorkoutLoaded);

    if (_popularWorkouts.isNotEmpty && _todayWorkout != null) return;

    _setLoading(true);
    _setError(false);

    (await _workoutRepository.getAllWorkouts()).onFailure((error) {
      _setError(true);
    });

    _setLoading(false);
  }

  void _onWorkoutLoaded(List<WorkoutEntity> workouts) {
    _popularWorkouts.addAll(workouts);
    _todayWorkout = workouts.first;
    _setLoading(false);
  }

  @override
  void dispose() {
    _workoutsSubscription?.cancel();

    super.dispose();
  }
}
