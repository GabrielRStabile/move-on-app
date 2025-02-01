import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/domain/entities/workout_entity.dart';
import 'package:move_on_app/ui/core/common_text_style.dart';

/// A widget that displays workout information in a carousel format
/// with an image background, gradient overlay and workout details.
class WorkoutCarouselContent extends StatelessWidget {
  /// Creates a workout carousel content widget.
  ///
  /// Requires a [workout] entity to display its information.
  const WorkoutCarouselContent({
    required this.workout,
    super.key,
  });

  /// The workout entity containing the data to be displayed
  final WorkoutEntity workout;

  @override
  Widget build(BuildContext context) {
    final fTheme = FTheme.of(context);

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: workout.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                FThemes.zinc.light.colorScheme.primary.withValues(alpha: 0.51),
                FThemes.zinc.light.colorScheme.primary.withValues(alpha: 0),
              ],
              stops: const [0.3558, 0.9809],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CommonTextStyle.of(context).h2.copyWith(
                            color: FThemes
                                .zinc.light.colorScheme.primaryForeground,
                            height: 0,
                          ),
                    ),
                    const Spacer(),
                    Chip(
                      avatar: FIcon(FAssets.icons.flame),
                      backgroundColor: fTheme.colorScheme.secondaryForeground,
                      label: Text(
                        '${workout.totalKcal} Kcal',
                        style: CommonTextStyle.of(context).detail,
                      ),
                    ),
                    Chip(
                      avatar: FIcon(FAssets.icons.timer),
                      backgroundColor: fTheme.colorScheme.secondaryForeground,
                      label: Text(
                        '${workout.totalDuration.inMinutes} min',
                        style: CommonTextStyle.of(context).detail,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Flexible(
                child: IconButton.filledTonal(
                  onPressed: () {
                    //TODO: Navigate to workout screen
                  },
                  icon: const Icon(Icons.play_arrow),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
