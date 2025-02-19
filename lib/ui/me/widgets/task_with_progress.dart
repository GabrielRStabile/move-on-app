import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/domain/entities/exercise_entity.dart';
import 'package:move_on_app/domain/entities/exercise_progress_entity.dart';
import 'package:move_on_app/routing/router.gr.dart';
import 'package:move_on_app/ui/core/common_text_style.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A widget that displays an exercise task with its progress,
/// supporting sliding actions and context menu interactions.
class TaskWithProgress extends StatefulWidget {
  /// Creates a task with progress widget.
  ///
  /// Requires an [exercise] entity to display its information.
  /// The [onCompleted] callback is called when the task is completed.
  const TaskWithProgress({
    required this.exercise,
    required this.onCompleted,
    super.key,
  });

  /// The exercise entity containing the task data
  final ExerciseEntity exercise;

  /// The callback to be called when the task is completed
  final VoidCallback onCompleted;

  @override
  State<TaskWithProgress> createState() => _TaskWithProgressState();
}

class _TaskWithProgressState extends State<TaskWithProgress> {
  /// The current exercise being displayed
  late ExerciseEntity exercise;

  @override
  void initState() {
    exercise = widget.exercise;

    super.initState();
  }

  @override
  void didUpdateWidget(TaskWithProgress oldWidget) {
    if (oldWidget.exercise != widget.exercise) {
      setState(() {
        exercise = widget.exercise;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  /// Updates the exercise progress to completed status
  void completeExercise() {
    setState(() {
      exercise = exercise.copyWith(
        progress: ExerciseProgressEntity(
          lastUpdated: DateTime.now(),
          completedPercentage: 100,
          status: ExerciseStatus.completed,
        ),
      );
    });

    widget.onCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final fTheme = FTheme.of(context);

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (_) => completeExercise(),
            borderRadius: BorderRadius.circular(23),
            backgroundColor: const Color(0xFFFAFAFA),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FIcon(FAssets.icons.check),
                const Text('Concluir tarefa'),
              ],
            ),
          ),
        ],
      ),
      child: CupertinoContextMenu.builder(
        enableHapticFeedback: true,
        actions: [
          if (exercise.progress?.status != ExerciseStatus.completed)
            CupertinoContextMenuAction(
              trailingIcon: Icons.check,
              onPressed: () {
                completeExercise();
                Navigator.of(context).pop();
              },
              child: const Text('Concluir tarefa'),
            ),
          CupertinoContextMenuAction(
            trailingIcon: Icons.tv,
            child: const Text('Assistir vídeo tutorial'),
            onPressed: () {
              const VideoRoute().push<void>(context);
            },
          ),
        ],
        builder: (_, animation) => SizedBox(
          height: 120,
          width: animation.isCompleted
              ? MediaQuery.sizeOf(context).width * 0.9
              : null,
          child: DecoratedBoxTransition(
            decoration: animation
                .drive(
                  CurveTween(curve: Curves.easeInOut),
                )
                .drive(
                  DecorationTween(
                    begin: BoxDecoration(
                      color: const Color(0xFFF4F4F5),
                      borderRadius: BorderRadius.circular(23),
                    ),
                    end: BoxDecoration(
                      color: const Color(0xFFF4F4F5),
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x20000000),
                          blurRadius: 10,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 20,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: fTheme.colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                    ),
                    child: Skeleton.ignore(
                      child: Text(
                        exercise.difficulty.name,
                        style: CommonTextStyle.of(context).detail.copyWith(
                              color: fTheme.colorScheme.secondaryForeground,
                            ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(23),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            exercise.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Text(
                              exercise.name,
                              style: CommonTextStyle.of(context).pUiMedium,
                            ),
                            const SizedBox(height: 4),
                            Flexible(
                              child: Text(
                                exercise.description,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    CommonTextStyle.of(context).detail.copyWith(
                                          color: fTheme
                                              .colorScheme.primaryForeground
                                              .withValues(alpha: 0.8),
                                        ),
                              ),
                            ),
                            const Spacer(),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                LinearProgressIndicator(
                                  value:
                                      (exercise.progress?.completedPercentage ??
                                              0) /
                                          100,
                                  minHeight: 20,
                                  backgroundColor: const Color(0xFFFAFAFA),
                                  valueColor: AlwaysStoppedAnimation(
                                    fTheme.colorScheme.primary,
                                  ),
                                ),
                                Skeleton.ignore(
                                  child: Text(
                                    exercise.progress?.percentageString ??
                                        'Não iniciado',
                                    style: CommonTextStyle.of(context).detail,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
