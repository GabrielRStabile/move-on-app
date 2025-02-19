// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/data/services/workouts/progress_service.dart';
import 'package:move_on_app/di/dependency_injection.dart';
import 'package:move_on_app/domain/entities/exercise_entity.dart';
import 'package:move_on_app/domain/entities/exercise_progress_entity.dart';
import 'package:move_on_app/domain/entities/workout_entity.dart';
import 'package:move_on_app/ui/core/common_text_style.dart';
import 'package:move_on_app/ui/me/widgets/task_with_progress.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A widget that displays a list of today's workout tasks.
///
/// This widget shows a scrollable list of workout tasks scheduled for the
/// current day.
/// Each task displays:
/// * Exercise name
/// * Sets and repetitions
/// * Progress indicator
///
/// Example:
/// ```dart
/// TodayTasksList(
///   workout: WorkoutEntityDummy.dummy(),
/// )
/// ```
class TodayTasksList extends StatefulWidget {
  /// Creates a list of today's workout tasks.
  ///
  /// By default, shows a empty state if no tasks are provided.
  const TodayTasksList({
    required this.workout,
    required this.isLoading,
    super.key,
  });

  final WorkoutEntity workout;
  final bool isLoading;

  @override
  State<TodayTasksList> createState() => _TodayTasksListState();
}

class _TodayTasksListState extends State<TodayTasksList> {
  final progressService = di.get<IProgressService>();

  late WorkoutEntity _workout;
  bool _isLoading = true;
  int _currentRound = 1;

  @override
  void initState() {
    super.initState();
    _workout = widget.workout;

    _loadExercises();
  }

  @override
  void didUpdateWidget(TodayTasksList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLoading != widget.isLoading) {
      _loadExercises();
    }
  }

  Future<void> _loadExercises() async {
    setState(() {
      _isLoading = widget.isLoading;
    });

    if (_isLoading) return;

    setState(() {
      _workout = widget.workout;
    });

    final result = await progressService.getWorkout(widget.workout.id);

    if (result == null) {
      await progressService.saveWorkout(_workout);
      return;
    }

    setState(() {
      _workout = result;
    });
  }

  Future<void> _onCompleteExercise(ExerciseEntity exercise) async {
    final updatedWorkout = _workout.copyWith(
      exercises: _workout.exercises.map((e) {
        if (e.id == exercise.id) {
          return exercise.copyWith(
            progress: (exercise.progress ??
                    ExerciseProgressEntity(
                      lastUpdated: DateTime.now(),
                      completedPercentage: 100,
                      status: ExerciseStatus.completed,
                    ))
                .copyWith(
              lastUpdated: DateTime.now(),
              completedPercentage: 100,
              status: ExerciseStatus.completed,
            ),
          );
        }
        return e;
      }).toList(),
    );

    final allTasksCompleted = updatedWorkout.exercises.every(
      (e) => e.progress?.status == ExerciseStatus.completed,
    );

    if (allTasksCompleted) {
      _currentRound++;

      final newWorkout = updatedWorkout.copyWith(
        exercises: updatedWorkout.exercises
            .map(
              (e) => e.copyWith(
                progress: null,
              ),
            )
            .toList(),
      );
      await progressService.saveWorkout(newWorkout);
      setState(() {
        _workout = newWorkout;
      });
    } else {
      await progressService.saveWorkout(updatedWorkout);
      setState(() {
        _workout = updatedWorkout;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (_isLoading) {
          return _TasksList(
            exercises: ExerciseEntityDummy.dummyList(count: 5),
            totalRounds: widget.workout.rounds,
            currentRound: 1,
            onCompleted: (_) {},
          );
        } else if (_workout.exercises.isEmpty) {
          return const _EmptyState();
        } else {
          return _TasksList(
            exercises: _workout.exercises,
            totalRounds: widget.workout.rounds,
            currentRound: _currentRound,
            onCompleted: _onCompleteExercise,
          );
        }
      },
    )
        .animate()
        .fadeIn(
          duration: 2000.ms,
          curve: Curves.easeInOut,
        )
        .slide(
          duration: 1000.ms,
          curve: Curves.easeInOut,
          begin: const Offset(0, 0.05),
        );
  }
}

class _TasksList extends StatelessWidget {
  const _TasksList({
    required this.exercises,
    required this.totalRounds,
    required this.currentRound,
    required this.onCompleted,
  });

  final List<ExerciseEntity> exercises;

  final int totalRounds;
  final int currentRound;
  final ValueSetter<ExerciseEntity> onCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tarefas para hoje',
              style: CommonTextStyle.of(context).large,
            ),
            Skeleton.ignore(
              child: Text(
                '$currentRound/$totalRounds rondas concluídas',
                style: CommonTextStyle.of(context).detail,
              ),
            ),
          ],
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => TaskWithProgress(
            exercise: exercises[index],
            onCompleted: () => onCompleted(exercises[index]),
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: 4,
        ),
        FButton(
          onPress: () {
            for (final exercise in exercises) {
              onCompleted(exercise);
            }
          },
          label: const Text('Completar Ronda'),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.checkmark_seal_fill,
            size: 60,
            color: FTheme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhuma tarefa para hoje',
            style: CommonTextStyle.of(context).large,
          ),
          const SizedBox(height: 8),
          Text(
            'Você já completou todas as tarefas de hoje',
            style: CommonTextStyle.of(context).detail,
          ),
        ],
      ),
    );
  }
}
