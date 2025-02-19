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
    this.selectedDate,
    super.key,
  });

  /// Called when the user selects a date.
  final ValueChanged<DateTime> onDateSelected;

  /// The currently selected date.
  final DateTime? selectedDate;

  @override
  State<ActivityDateSelection> createState() => _ActivityDateSelectionState();
}

class _ActivityDateSelectionState extends State<ActivityDateSelection> {
  late DateTime selectedDate;

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
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  void didUpdateWidget(ActivityDateSelection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      setState(
        () => selectedDate = widget.selectedDate ?? DateTime.now(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(
          builder: (context) {
            return FTappable.animated(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
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
          onDaySelected: _onDaySelected,
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
class _DayCarousel extends StatefulWidget {
  /// Creates a day carousel widget.
  ///
  /// * [onDaySelected] - Callback when a day is selected
  /// * [selectedDay] - Currently selected date
  const _DayCarousel({
    required this.onDaySelected,
    required this.selectedDay,
  });

  /// Callback when a day is selected
  final ValueChanged<DateTime> onDaySelected;

  /// The currently selected date
  final DateTime selectedDay;

  @override
  State<_DayCarousel> createState() => _DayCarouselState();
}

class _DayCarouselState extends State<_DayCarousel> {
  final ScrollController _scrollController = ScrollController();
  final double _itemWidth = 60;
  final double _itemHeight = 64;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelectedDay());
  }

  @override
  void didUpdateWidget(covariant _DayCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDay != widget.selectedDay) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _scrollToSelectedDay());
    }
  }

  void _scrollToSelectedDay() {
    final index = widget.selectedDay.day - 1;
    final targetOffset = index * _itemWidth;

    final currentOffset = _scrollController.offset;
    final viewportWidth = _scrollController.position.viewportDimension;

    // If the selected day is already visible, don't scroll
    if (targetOffset >= currentOffset &&
        (targetOffset + _itemWidth) <= (currentOffset + viewportWidth)) {
      return;
    }

    _scrollController.animateTo(
      targetOffset / 2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  int _getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  bool _isSelected(DateTime date) {
    return date.year == widget.selectedDay.year &&
        date.month == widget.selectedDay.month &&
        date.day == widget.selectedDay.day;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysInMonth = _getDaysInMonth(widget.selectedDay);
    final firstDayOfMonth =
        DateTime(widget.selectedDay.year, widget.selectedDay.month);
    final isCurrentMonth = widget.selectedDay.year == now.year &&
        widget.selectedDay.month == now.month;
    final itemCount = isCurrentMonth ? now.day : daysInMonth;

    return SizedBox(
      height: _itemHeight,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          final currentDate = firstDayOfMonth.add(Duration(days: index));
          final isSelectedDay = _isSelected(currentDate);
          return SizedBox(
            width: _itemWidth,
            height: _itemHeight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () => widget.onDaySelected(currentDate),
                child: _DayWidget(
                  currentDate: currentDate,
                  isSelectedDay: isSelectedDay,
                ),
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
