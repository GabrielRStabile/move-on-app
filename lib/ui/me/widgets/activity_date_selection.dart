import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:move_on_app/ui/core/common_text_style.dart';

/// A widget that allows users to select a date from a horizontal day carousel
/// and displays a calendar picker.
///
/// Features:
/// * Horizontal scrollable day selection
/// * Month/year display with calendar picker
/// * Visual indicators for selected date
/// * Haptic feedback on interaction
class ActivityDateSelection extends StatefulWidget {
  /// Creates an activity date selection widget.
  const ActivityDateSelection({
    required this.onDateSelected,
    super.key,
  });

  /// Called when the user selects a date.
  final ValueChanged<DateTime> onDateSelected;

  @override
  State<ActivityDateSelection> createState() => _ActivityDateSelectionState();
}

class _ActivityDateSelectionState extends State<ActivityDateSelection> {
  DateTime selectedDate = DateTime.now();

  Future<void> onCalendarWidgetTap(BuildContext context) async {
    final renderBox = context.findRenderObject() as RenderBox?;
    final nowDate = DateTime.now();

    final pickedDate = await showCupertinoCalendarPicker(
      context,
      widgetRenderBox: renderBox,
      minimumDateTime: nowDate.subtract(const Duration(days: 360 * 15)),
      initialDateTime: selectedDate,
      maximumDateTime: nowDate,
      onDateSelected: _onDaySelected,
    );

    if (pickedDate != null) _onDaySelected(pickedDate);
  }

  void _onDaySelected(DateTime date) {
    if (!mounted && date == selectedDate) return;

    setState(() {
      selectedDate = date;
      widget.onDateSelected(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(
          builder: (context) {
            return FTappable.animated(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat('MMMM yyyy', 'pt')
                        .format(selectedDate)
                        .replaceFirstMapped(
                          RegExp('^[a-z]'),
                          (match) => match.group(0)!.toUpperCase(),
                        ),
                    style: CommonTextStyle.of(context).h3,
                  ),
                  const SizedBox(width: 10),
                  FIcon(
                    FAssets.icons.chevronDown,
                    color: Colors.black,
                  ),
                ],
              ),
              onPress: () {
                HapticFeedback.selectionClick();
                onCalendarWidgetTap(context);
              },
            );
          },
        ),
        const SizedBox(height: 16),
        _DayCarousel(
          onDaySelected: (date) {
            setState(() {
              selectedDate = date;
            });
          },
          selectedDay: selectedDate,
        ),
      ],
    );
  }
}

/// A private widget that displays a horizontal carousel of days.
///
/// Shows days of the current month up to the current day, or all days
/// for past months.
class _DayCarousel extends StatelessWidget {
  /// Creates a day carousel widget.
  ///
  /// * [onDaySelected] - Callback when a day is selected
  /// * [selectedDay] - Currently selected date
  const _DayCarousel({
    required this.onDaySelected,
    required this.selectedDay,
  });

  /// Called when the user selects a day.
  final ValueChanged<DateTime> onDaySelected;

  /// The currently selected date.
  final DateTime selectedDay;

  /// Returns the number of days in the given month.
  int _getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  /// Checks if the given date is currently selected.
  bool _isSelected(DateTime date) {
    return date.year == selectedDay.year &&
        date.month == selectedDay.month &&
        date.day == selectedDay.day;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysInMonth = _getDaysInMonth(selectedDay);
    final firstDayOfMonth = DateTime(selectedDay.year, selectedDay.month);

    final isCurrentMonth =
        selectedDay.year == now.year && selectedDay.month == now.month;

    final itemCount = isCurrentMonth ? now.day : daysInMonth;

    return SizedBox(
      height: 64,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(right: 10),
        itemBuilder: (context, index) {
          final currentDate = firstDayOfMonth.add(Duration(days: index));
          final isSelectedDay = _isSelected(currentDate);

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => onDaySelected(currentDate),
              child: _DayWidget(
                currentDate: currentDate,
                isSelectedDay: isSelectedDay,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// A private widget that displays a single day item in the carousel.
///
/// Shows the day of week initial and date number with selection state.
class _DayWidget extends StatelessWidget {
  /// Creates a day widget.
  ///
  /// * [currentDate] - The date to display
  /// * [isSelectedDay] - Whether this day is currently selected
  const _DayWidget({
    required this.currentDate,
    required this.isSelectedDay,
  });

  /// The date to display in this widget.
  final DateTime currentDate;

  /// Whether this day is currently selected.
  final bool isSelectedDay;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 52,
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: isSelectedDay
                ? FTheme.of(context).colorScheme.secondary
                : FTheme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('E', 'pt')
                          .format(currentDate)[0]
                          .toUpperCase(),
                      style: CommonTextStyle.of(context).subtitle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isSelectedDay
                                ? FTheme.of(context)
                                    .colorScheme
                                    .secondaryForeground
                                : null,
                          ),
                    ),
                    Text(
                      DateFormat('dd', 'pt').format(currentDate),
                      style: CommonTextStyle.of(context).subtitle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isSelectedDay
                                ? FTheme.of(context)
                                    .colorScheme
                                    .secondaryForeground
                                : null,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isSelectedDay)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: FTheme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
