import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/data/repositories/health/health_repository.dart';
import 'package:move_on_app/di/dependency_injection.dart';
import 'package:move_on_app/ui/core/common_text_style.dart';
import 'package:move_on_app/ui/me/widgets/activity_screen/activity_card.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

/// A widget that displays the water consumption activity card.
///
/// This widget is part of the "MoveOn" Flutter app for health and fitness. It shows the
/// current water intake relative to a daily goal using a wave animation and allows users to
/// increment their water consumption. The widget interacts with the [HealthRepository]
/// to load and save water consumption data.
class WaterActivityCard extends StatefulWidget {
  /// Creates a [WaterActivityCard].
  ///
  /// The [date] parameter specifies the day for which water consumption data is tracked.
  /// If the [date] is the current day, then operations will use [DateTime.now()] for data persistence.
  const WaterActivityCard({required this.date, super.key});

  /// The date corresponding to the water consumption record.
  ///
  /// This date is used to determine whether to record the data as for the current day
  /// or for a specific past/future day.
  final DateTime date;

  @override
  State<WaterActivityCard> createState() => _WaterActivityCardState();
}

class _WaterActivityCardState extends State<WaterActivityCard> {
  final HealthRepository _healthRepository = di.get<HealthRepository>();

  int _currentWaterML = 0;
  final int _maxWaterML = 2000;
  final int _stepML = 200;

  void _incrementWaterML() {
    if (_currentWaterML < _maxWaterML) {
      setState(() {
        _currentWaterML = (_currentWaterML + _stepML).clamp(0, _maxWaterML);

        Future.delayed(const Duration(seconds: 1), () {
          final date = widget.date.isToday ? DateTime.now() : widget.date;
          _healthRepository.saveWaterConsumption(date, _stepML);
        });
      });
    }
  }

  Future<void> _loadWaterData() async {
    final result = await _healthRepository.getWaterConsumption(widget.date);

    result.fold(
      (ml) => setState(() {
        _currentWaterML = ml;
      }),
      (error) => debugPrint('Error: $error'),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadWaterData();
  }

  @override
  void didUpdateWidget(covariant WaterActivityCard oldWidget) {
    if (oldWidget.date != widget.date) {
      _loadWaterData();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ActivityCard(
      color: Colors.blue,
      icon: FIcon(FAssets.icons.glassWater),
      title: const Text('Hidratação'),
      content: Row(
        spacing: 8,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox.expand(
                child: ColoredBox(
                  color: FTheme.of(context).colorScheme.background,
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(seconds: 1),
                        bottom: 0,
                        height: (200 / _maxWaterML) * _currentWaterML,
                        child: WaveWidget(
                          config: CustomConfig(
                            colors: [
                              Colors.blue.shade200,
                              Colors.blue,
                            ],
                            durations: [5000, 10000],
                            heightPercentages: [0.2, 0.25],
                          ),
                          waveAmplitude: 1,
                          size: const Size(300, 200),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text(
                              '$_currentWaterML / $_maxWaterML',
                              style: CommonTextStyle.of(context).h3.copyWith(
                                    height: 1,
                                  ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'ML',
                              style: CommonTextStyle.of(context).pUiMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          FButton.icon(
            style: FButtonStyle.secondary,
            onPress: _incrementWaterML,
            child: FIcon(FAssets.icons.plus),
          ),
        ],
      ),
    );
  }
}

extension on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}
