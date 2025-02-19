import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/ui/core/common_text_style.dart';

/// A customizable card widget for displaying health activity information.
///
/// The [ActivityCard] widget is designed to showcase a health-related activity,
/// such as water consumption, active calories, or sleep data. It displays an optional
/// title and icon along with the main content in a styled container using a semi-transparent
/// version of the provided [color].
///
/// Example usage:
/// ```dart
/// ActivityCard(
///   title: const Text('Water Consumption'),
///   content: const Text('1000 / 2000 ML'),
///   color: Colors.blue,
///   icon: FIcon(FAssets.icons.water),
/// );
/// ```
class ActivityCard extends StatelessWidget {
  /// Creates an [ActivityCard] widget.
  ///
  /// The [content] and [color] parameters are required.
  /// Optionally, a [title] and an [icon] can be provided to enhance the UI.
  const ActivityCard({
    required this.content,
    required this.color,
    super.key,
    this.title,
    this.icon,
  });

  /// The optional title widget for the card.
  ///
  /// Typically used to summarize the activity being displayed.
  final Widget? title;

  /// The main content of the card.
  ///
  /// This widget displays the activity data, such as the water intake,
  /// active calories, or sleep duration.
  final Widget content;

  /// The base color used to style the card.
  ///
  /// The background of the card uses a semi-transparent version of this color.
  final Color color;

  /// An optional icon displayed alongside the title.
  ///
  /// The icon is styled to complement the [color] scheme of the card.
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || icon != null)
            Padding(
              padding: EdgeInsets.only(bottom: icon != null ? 16 : 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: icon != null
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.center,
                children: [
                  if (icon != null)
                    Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: FIconStyleData(
                        style: FIconStyle.of(context).copyWith(
                          color: HSLColor.fromColor(color).lightness < 0.3
                              ? color
                              : HSLColor.fromColor(color)
                                  .withLightness(0.3)
                                  .toColor(),
                        ),
                        child: icon!,
                      ),
                    ),
                  if (title != null)
                    DefaultTextStyle(
                      style: CommonTextStyle.of(context).large,
                      child: title!,
                    ),
                ],
              ),
            ),
          Expanded(
            child: DefaultTextStyle(
              style: CommonTextStyle.of(context).pUiMedium,
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}
