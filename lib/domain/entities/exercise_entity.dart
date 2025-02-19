import 'package:dart_mappable/dart_mappable.dart';
import 'package:move_on_app/domain/entities/duration_mapper.dart';
import 'package:move_on_app/domain/entities/exercise_progress_entity.dart';
import 'package:move_on_app/domain/entities/video_entity.dart';
import 'package:move_on_app/domain/entities/workout_entity.dart';

part 'exercise_entity.mapper.dart';

/// Represents a single exercise within a workout
@MappableClass(includeCustomMappers: [DurationMapper()])
class ExerciseEntity with ExerciseEntityMappable {
  /// Creates a new exercise entity
  ///
  /// [id] Unique identifier for the exercise
  /// [name] Name of the exercise
  /// [description] Detailed description of the exercise
  /// [image] URL or path to the exercise image
  /// [difficulty] Difficulty level of the exercise
  /// [kcal] Calories burned per exercise execution
  /// [duration] Time duration of the exercise
  /// [video] Video resource for the exercise
  ExerciseEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.difficulty,
    required this.kcal,
    required this.duration,
    this.categories = const [],
    this.imageHash,
    this.video,
    this.progress,
  });

  /// Unique identifier of the exercise
  final String id;

  /// Name of the exercise
  @MappableField(key: 'title')
  final String name;

  /// Detailed description of the exercise
  final String description;

  /// URL or path to the exercise image
  @MappableField(key: 'thumb_url')
  final String image;

  /// Blur Hash of the workout image
  @MappableField(key: 'blur_hash')
  final String? imageHash;

  /// Categories of the exercise
  final List<String> categories;

  /// Number of calories burned per execution
  @MappableField(key: 'calories')
  final int kcal;

  /// Duration of the exercise
  final Duration duration;

  /// Difficulty level of the exercise
  @MappableField(key: 'level')
  final ExerciseDifficulty difficulty;

  /// Video resource for the exercise
  final VideoEntity? video;

  /// Progress tracking for the exercise
  final ExerciseProgressEntity? progress;

  /// Factory methods for creating ExerciseEntity from different sources
  static const fromMap = ExerciseEntityMapper.fromMap;

  /// Factory methods for creating ExerciseEntity from JSON
  static const fromJson = ExerciseEntityMapper.fromJson;
}

/// Extension methods for creating dummy ExerciseEntity instances
extension ExerciseEntityDummy on ExerciseEntity {
  /// Creates a single dummy exercise
  static ExerciseEntity dummy({String? id}) => ExerciseEntity(
        id: id ?? 'exercise-1',
        name: 'Push-ups',
        description: 'Classic push-ups exercise',
        image: 'https://picsum.photos/200/300',
        difficulty: ExerciseDifficulty.medium,
        kcal: 8,
        duration: const Duration(seconds: 30),
        video: VideoEntityDummy.dummy(),
        progress: ExerciseProgressEntityDummy.dummy(),
      );

  /// Creates a list of dummy exercises with different variations
  static List<ExerciseEntity> dummyList({int count = 3}) {
    final exercises = [
      dummy(id: 'exercise-1'),
      ExerciseEntity(
        id: 'exercise-2',
        name: 'Squats',
        description: 'Basic squats exercise',
        image: 'https://picsum.photos/200/300',
        difficulty: ExerciseDifficulty.easy,
        kcal: 10,
        duration: const Duration(seconds: 45),
        video: VideoEntityDummy.dummy(format: VideoFormat.hls),
        progress: ExerciseProgressEntityDummy.dummy(
          status: ExerciseStatus.inProgress,
          completedPercentage: 75,
        ),
      ),
      ExerciseEntity(
        id: 'exercise-3',
        name: 'Burpees',
        description: 'High intensity burpees',
        image: 'https://picsum.photos/200/300',
        difficulty: ExerciseDifficulty.hard,
        kcal: 15,
        duration: const Duration(seconds: 60),
        video: VideoEntityDummy.dummy(),
        progress: ExerciseProgressEntityDummy.dummy(
          status: ExerciseStatus.completed,
          completedPercentage: 100,
        ),
      ),
    ];

    if (count <= 3) {
      return exercises.take(count).toList();
    }

    return List.generate(
      count,
      (index) =>
          index < 3 ? exercises[index] : dummy(id: 'exercise-${index + 1}'),
    );
  }
}
