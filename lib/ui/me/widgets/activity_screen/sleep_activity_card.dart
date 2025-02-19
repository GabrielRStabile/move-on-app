import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/data/repositories/health/health_repository.dart';
import 'package:move_on_app/di/dependency_injection.dart';
import 'package:move_on_app/ui/me/widgets/activity_screen/activity_card.dart';

/// A widget that displays the sleep activity card.
///
/// This widget retrieves sleep duration data for a specific [date] from the
/// [HealthRepository] and presents it within an [ActivityCard]. It shows a loading
/// indicator while data is being fetched and displays an error message if the data
/// cannot be retrieved.
///
/// Example usage:
/// ```dart
/// const SleepActivityCard(date: DateTime.now());
/// ```
class SleepActivityCard extends StatefulWidget {
  /// Creates a [SleepActivityCard].
  ///
  /// The [date] parameter specifies the day for which the sleep data is fetched.
  const SleepActivityCard({
    required this.date,
    super.key,
  });

  /// The date for which sleep data is to be displayed.
  ///
  /// This value determines which day's sleep duration is fetched from the repository.
  final DateTime date;

  @override
  State<SleepActivityCard> createState() => _SleepActivityCardState();
}

class _SleepActivityCardState extends State<SleepActivityCard> {
  final HealthRepository _healthRepository = di.get<HealthRepository>();
  Duration _sleepDuration = Duration.zero;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSleepData();
  }

  @override
  void didUpdateWidget(SleepActivityCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.date != widget.date) {
      _loadSleepData();
    }
  }

  Future<void> _loadSleepData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final result = await _healthRepository.getSleepHours(widget.date);

    result.fold(
      (duration) => setState(() {
        _sleepDuration = duration;
        _isLoading = false;
      }),
      (error) => setState(() {
        _error = error.toString();
        _isLoading = false;
      }),
    );
  }

  String get _sleepText {
    if (_sleepDuration == Duration.zero) {
      return 'Sem dados de sono';
    }

    final hours = _sleepDuration.inHours;
    final minutes = _sleepDuration.inMinutes.remainder(60);

    if (hours == 0) {
      return '$minutes min de sono';
    }

    return minutes > 0 ? '$hours h $minutes min de sono' : '$hours h de sono';
  }

  @override
  Widget build(BuildContext context) {
    return ActivityCard(
      color: Colors.purple,
      icon: FIcon(FAssets.icons.moon),
      title: const Text('Sono'),
      content: _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Text(
              _error != null ? 'Falha ao carregar dados de sono' : _sleepText,
            ),
    );
  }
}
