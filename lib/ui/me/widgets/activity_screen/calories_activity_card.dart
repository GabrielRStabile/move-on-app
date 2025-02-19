import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/data/repositories/health/health_repository.dart';
import 'package:move_on_app/di/dependency_injection.dart';
import 'package:move_on_app/ui/me/widgets/activity_screen/activity_card.dart';

/// A widget that displays the active calories activity card.
///
/// This widget is part of the "MoveOn" Flutter app for health and fitness. It fetches
/// the active calorie data for a given [date] from the [HealthRepository] and displays it
/// within an [ActivityCard] styled interface.
class CaloriesActivityCard extends StatefulWidget {
  /// Creates an instance of [CaloriesActivityCard].
  ///
  /// The [date] parameter specifies the day for which the active calorie data is retrieved.
  /// The widget uses this date to fetch and display the corresponding calorie information.
  const CaloriesActivityCard({required this.date, super.key});

  /// The date corresponding to the active calorie record.
  ///
  /// This value determines the day for which the calorie data is fetched and displayed.
  final DateTime date;

  @override
  State<CaloriesActivityCard> createState() => _CaloriesActivityCardState();
}

class _CaloriesActivityCardState extends State<CaloriesActivityCard> {
  final _healthRepository = di.get<HealthRepository>();

  int _calories = 0;

  Future<void> _loadCalories() async {
    final result = await _healthRepository.getCalories(widget.date);

    result.fold(
      (calories) => setState(() {
        _calories = calories;
      }),
      (error) => debugPrint('Error: $error'),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadCalories();
  }

  @override
  void didUpdateWidget(covariant CaloriesActivityCard oldWidget) {
    if (oldWidget.date != widget.date) {
      _loadCalories();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ActivityCard(
      title: const Text('Calorias Ativas'),
      icon: FIcon(FAssets.icons.flame),
      content: Text('$_calories Calorias'),
      color: Colors.red,
    );
  }
}
