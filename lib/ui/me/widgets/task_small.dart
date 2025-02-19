import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/domain/entities/exercise_entity.dart';
import 'package:move_on_app/routing/router.gr.dart';
import 'package:move_on_app/ui/core/common_text_style.dart';

/// A compact widget that displays summarized exercise information.
///
/// This widget is designed to show a small preview of an exercise, including
/// its image, name, duration, and calories burned. It's ideal for use in
/// lists or grids where space is limited.
///
/// The layout consists of:
/// - A circular exercise image
/// - Exercise name
/// - Informative chips showing duration and calories
///
/// Example usage:
/// ```dart
/// TaskSmall(
///   exercise: ExerciseEntity(
///     name: 'Running',
///     image: 'https://example.com/running.jpg',
///     duration: Duration(minutes: 30),
///     kcal: 300,
///   ),
/// )
/// ```
class TaskSmall extends StatelessWidget {
  /// Creates a [TaskSmall] widget.
  ///
  /// The [exercise] parameter is required and contains the exercise data
  /// that will be displayed.
  const TaskSmall({required this.exercise, super.key});

  /// The entity containing the exercise data to be displayed.
  final ExerciseEntity exercise;

  @override
  Widget build(BuildContext context) {
    return FTappable.animated(
      onPress: () => const VideoRoute().push<void>(context),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 86),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: CommonTextStyle.of(context).large,
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Chip(label: Text('${exercise.duration.inMinutes} min')),
                        const SizedBox(width: 5),
                        Chip(label: Text('${exercise.kcal} cal')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
