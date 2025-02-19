import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:move_on_app/ui/core/common_text_style.dart';
import 'package:move_on_app/ui/me/widgets/activity_screen/activity_card.dart';
import 'package:move_on_app/ui/me/widgets/activity_screen/activity_date_selection.dart';
import 'package:move_on_app/ui/me/widgets/activity_screen/calories_activity_card.dart';
import 'package:move_on_app/ui/me/widgets/activity_screen/exercises_activity_card.dart';
import 'package:move_on_app/ui/me/widgets/activity_screen/sleep_activity_card.dart';
import 'package:move_on_app/ui/me/widgets/activity_screen/water_activity_card.dart';

/// A screen that displays the user's daily activity summary and health metrics.
///
/// This screen shows various health and fitness metrics in a grid layout, including:
/// * Calories burned
/// * Sleep tracking
/// * Water intake
/// * Exercise progress
/// * Motivational cards
///
/// The user can select different dates to view historical data using the date selection
/// component at the top of the screen.
///
/// Example usage:
/// ```dart
/// @RoutePage()
/// class ActivityScreen extends StatefulWidget {
///   const ActivityScreen({super.key});
///   // ...
/// }
/// ```
///
/// The screen uses [StaggeredGrid] to create a visually appealing layout with cards
/// of different sizes. Each card represents a different health metric and is implemented
/// as a separate widget:
/// * [CaloriesActivityCard] - Shows calories burned
/// * [SleepActivityCard] - Displays sleep metrics
/// * [WaterActivityCard] - Shows water intake
/// * [ExercisesActivityCard] - Displays exercise progress
///
/// The screen automatically updates when:
/// * A different date is selected using [ActivityDateSelection]
/// * Health data is synchronized from HealthKit
/// * User completes activities within the app
@RoutePage()
class ActivityScreen extends StatefulWidget {
  /// Creates an activity screen that displays health and fitness metrics.
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          ActivityDateSelection(
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
            selectedDate: _selectedDate,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Relatório de ${DateFormat.EEEE('pt').format(_selectedDate)}',
              style: CommonTextStyle.of(context).h4,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: [
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 1,
                        child: CaloriesActivityCard(date: _selectedDate),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 1,
                        child: SleepActivityCard(date: _selectedDate),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 2,
                        child: ActivityCard(
                          icon: FIcon(FAssets.icons.trophy),
                          content:
                              const Text('Continue dando o seu melhor! 💪'),
                          color: FTheme.of(context).colorScheme.primary,
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 3,
                        mainAxisCellCount: 2,
                        child: WaterActivityCard(date: _selectedDate),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 4,
                        mainAxisCellCount: 3,
                        child: ExercisesActivityCard(date: _selectedDate),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
