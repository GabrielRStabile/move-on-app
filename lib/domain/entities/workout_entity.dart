import 'package:dart_mappable/dart_mappable.dart';
import 'package:move_on_app/domain/entities/exercise_entity.dart';

part 'workout_entity.mapper.dart';

/// Represents the difficulty level of an exercise
@MappableEnum(mode: ValuesMode.named)
enum ExerciseDifficulty {
  /// Easy difficulty level
  @MappableValue('beginner')
  easy,

  /// Medium difficulty level
  @MappableValue('intermediate')
  medium,

  /// Hard difficulty level
  @MappableValue('advanced')
  hard;

  /// Returns the localized name of the difficulty level
  String get name {
    switch (this) {
      case ExerciseDifficulty.easy:
        return 'Iniciante';
      case ExerciseDifficulty.medium:
        return 'Intermediário';
      case ExerciseDifficulty.hard:
        return 'Avançado';
    }
  }

  /// Returns the number of rounds for the difficulty level
  int get rounds {
    switch (this) {
      case ExerciseDifficulty.easy:
        return 3;
      case ExerciseDifficulty.medium:
        return 4;
      case ExerciseDifficulty.hard:
        return 5;
    }
  }
}

/// Represents a workout session with exercises and rounds
@MappableClass()
class WorkoutEntity with WorkoutEntityMappable {
  /// Creates a new workout entity
  ///
  /// [id] Unique identifier for the workout
  /// [name] Name of the workout
  /// [description] Detailed description of the workout
  /// [image] URL or path to the workout image
  /// [rounds] Number of times to repeat the exercise sequence
  /// [exercises] List of exercises in this workout
  WorkoutEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    this.imageHash,
    this.exercises = const [],
  });

  /// Unique identifier of the workout
  final String id;

  /// Name of the workout
  @MappableField(key: 'title')
  final String name;

  /// Detailed description of the workout
  final String description;

  /// URL or path to the workout image
  @MappableField(key: 'thumb_url')
  final String image;

  /// Blur Hash of the workout image
  @MappableField(key: 'blur_hash')
  final String? imageHash;

  /// List of exercises in this workout
  @MappableField(key: 'tasks')
  final List<ExerciseEntity> exercises;

  /// Number of rounds to perform the exercises
  int get rounds => averageDifficulty.rounds;

  /// Calculates the total calories burned in the workout
  /// based on the exercises and number of rounds
  int get totalKcal =>
      exercises.map((e) => e.kcal).reduce((a, b) => a + b) * rounds;

  /// Calculates the total duration of the workout
  /// based on the exercises and number of rounds
  Duration get totalDuration =>
      exercises.map((e) => e.duration).reduce((a, b) => a + b) * rounds;

  /// Calculates the average difficulty of the workout
  /// based on the difficulty of each exercise
  ExerciseDifficulty get averageDifficulty {
    final difficulties = exercises.map((e) => e.difficulty).toList();
    final difficultiesValues = difficulties.map((e) => e.index).toList();
    final difficultiesSum = difficultiesValues.reduce((a, b) => a + b);
    final difficultiesAverage = difficultiesSum / difficultiesValues.length;

    if (difficultiesAverage < 1) {
      return ExerciseDifficulty.easy;
    } else if (difficultiesAverage < 2) {
      return ExerciseDifficulty.medium;
    } else {
      return ExerciseDifficulty.hard;
    }
  }

  /// Factory methods for creating WorkoutEntity from different sources
  static const fromMap = WorkoutEntityMapper.fromMap;

  /// Factory methods for creating WorkoutEntity from JSON
  static const fromJson = WorkoutEntityMapper.fromJson;
}

/// Extension methods for creating dummy WorkoutEntity instances
extension WorkoutEntityDummy on WorkoutEntity {
  /// Creates a single dummy workout
  static WorkoutEntity dummy({String? id}) => WorkoutEntity(
        id: id ?? 'workout-1',
        name: 'Full Body Workout',
        description: 'Complete body workout for beginners',
        image: 'https://picsum.photos/200/300',
        imageHash: 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
        exercises: ExerciseEntityDummy.dummyList(),
      );

  /// Creates a list of dummy workouts
  static List<WorkoutEntity> dummyList({int count = 5}) => List.generate(
        count,
        (index) => dummy(id: 'workout-${index + 1}'),
      );
}
