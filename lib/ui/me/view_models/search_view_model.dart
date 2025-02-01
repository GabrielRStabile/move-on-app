import 'package:flutter/material.dart';
import 'package:move_on_app/data/repositories/workout/workout_repository.dart';
import 'package:move_on_app/domain/entities/exercise_entity.dart';

/// ViewModel responsible for handling exercise search functionality
class SearchViewModel extends ChangeNotifier {
  /// Creates a search view model with the required workout repository
  SearchViewModel(this._workoutRepository);

  final WorkoutRepository _workoutRepository;

  /// List of exercises matching the current search query
  List<ExerciseEntity> get searchResults => _searchResults;
  final List<ExerciseEntity> _searchResults = [];

  /// Whether a search operation is in progress
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  /// Whether the last search operation resulted in an error
  bool get hasError => _hasError;
  bool _hasError = false;

  /// Performs a search for exercises matching the given query
  Future<void> search(String query) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    final result = await _workoutRepository.searchExercises(query);

    result.fold(
      (exercises) {
        _searchResults
          ..clear()
          ..addAll(exercises);
        _isLoading = false;
        notifyListeners();
      },
      (error) {
        _hasError = true;
        _isLoading = false;
        notifyListeners();
      },
    );

    notifyListeners();
  }
}
