// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/domain/entities/exercise_entity.dart';
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
///   tasks: [
///     WorkoutTask(name: 'Squats', sets: 3, reps: 12),
///     WorkoutTask(name: 'Push-ups', sets: 4, reps: 10),
///   ],
/// )
/// ```
class TodayTasksList extends StatefulWidget {
  /// Creates a list of today's workout tasks.
  ///
  /// By default, shows a empty state if no tasks are provided.
  const TodayTasksList({
    required this.exercises,
    required this.isLoading,
    super.key,
  });

  final List<ExerciseEntity> exercises;
  final bool isLoading;

  @override
  State<TodayTasksList> createState() => _TodayTasksListState();
}

class _TodayTasksListState extends State<TodayTasksList> {
  List<ExerciseEntity> _exercises = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
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
    _isLoading = widget.isLoading;

    _exercises = widget.isLoading
        ? ExerciseEntityDummy.dummyList(count: 5)
        : widget.exercises;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (_isLoading) {
          return _TasksList(
            exercises: ExerciseEntityDummy.dummyList(count: 5),
          );
        } else if (_exercises.isEmpty) {
          return const _EmptyState();
        } else {
          return _TasksList(
            exercises: _exercises,
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
  const _TasksList({required this.exercises});

  final List<ExerciseEntity> exercises;

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
                '1/4 rondas concluídas',
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
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: 4,
        ),
        FButton(
          onPress: () {},
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
