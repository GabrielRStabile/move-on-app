import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forui/forui.dart';

/// A customizable animated bottom navigation bar widget.
///
/// This widget creates a bottom navigation bar with smooth animations
/// when switching between tabs. It supports custom colors, shapes,
/// and transitions for both selected and unselected states.
///
/// Example:
/// ```dart
/// AppBottomBar(
///   items: [
///     AppBottomBarItem(icon: Icon(Icons.home), title: Text('Home')),
///     AppBottomBarItem(icon: Icon(Icons.person), title: Text('Profile')),
///   ],
///   currentIndex: 0,
///   onTap: (index) => print('Tapped index: $index'),
/// )
/// ```
class AppBottomBar extends StatelessWidget {
  /// Creates an animated bottom navigation bar.
  ///
  /// The [items] parameter must not be null and must have at least 2 items.
  /// The [currentIndex] must be a valid index in [items].
  ///
  /// [backgroundColor] determines the bar's background color.
  /// [selectedItemColor] and [unselectedItemColor] control the items' colors.
  /// [selectedColorOpacity] controls the opacity of the selected item's
  /// background.
  /// [itemShape] defines the shape of the clickable area around each item.
  /// [margin] sets the spacing around the entire widget.
  /// [itemPadding] controls the spacing within each item.
  /// [duration] and [curve] customize the animation behavior.
  const AppBottomBar({
    required this.items,
    super.key,
    this.backgroundColor,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    this.selectedItemBackgroundColor,
    this.itemShape = const StadiumBorder(),
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
  });

  /// A list of tabs to display, ie `Home`, `Likes`, etc
  final List<AppBottomBarItem> items;

  /// The tab to display.
  final int currentIndex;

  /// Returns the index of the tab that was tapped.
  final ValueChanged<int>? onTap;

  /// The background color of the bar.
  final Color? backgroundColor;

  /// The color of the icon and text when the item is selected.
  final Color? selectedItemColor;

  /// The color of the icon and text when the item is not selected.
  final Color? unselectedItemColor;

  /// The opacity of color of the touchable background when the item is selected
  final double? selectedColorOpacity;

  /// The background color of the selected item.
  final Color? selectedItemBackgroundColor;

  /// The border shape of each item.
  final ShapeBorder itemShape;

  /// A convenience field for the margin surrounding the entire widget.
  final EdgeInsets margin;

  /// The padding of each item.
  final EdgeInsets itemPadding;

  /// The transition duration
  final Duration duration;

  /// The transition curve
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      minimum: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: ColoredBox(
            color: backgroundColor ?? Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: items.length <= 2
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.spaceBetween,
                children: [
                  for (final item in items)
                    TweenAnimationBuilder<double>(
                      tween: Tween(
                        end: items.indexOf(item) == currentIndex ? 1.0 : 0.0,
                      ),
                      curve: curve,
                      duration: duration,
                      builder: (context, t, _) {
                        final selectedColor = item.selectedColor ??
                            selectedItemColor ??
                            theme.primaryColor;

                        final unselectedColor = item.unselectedColor ??
                            unselectedItemColor ??
                            theme.iconTheme.color;

                        return Material(
                          color: Color.lerp(
                            selectedColor.withValues(alpha: 0),
                            selectedItemBackgroundColor ??
                                selectedColor.withValues(
                                  alpha: selectedColorOpacity ?? 0.1,
                                ),
                            t,
                          ),
                          shape: itemShape,
                          child: InkWell(
                            onTap: () => onTap?.call(items.indexOf(item)),
                            customBorder: itemShape,
                            focusColor: selectedColor.withValues(alpha: .1),
                            highlightColor: selectedColor.withValues(alpha: .1),
                            splashColor: selectedColor.withValues(alpha: .1),
                            hoverColor: selectedColor.withValues(alpha: .1),
                            child: Padding(
                              padding: itemPadding -
                                  (Directionality.of(context) ==
                                          TextDirection.ltr
                                      ? EdgeInsets.only(
                                          right: itemPadding.right * t,
                                        )
                                      : EdgeInsets.only(
                                          left: itemPadding.left * t,
                                        )),
                              child: Row(
                                children: [
                                  FIconStyleData(
                                    style: FIconStyle(
                                      color: Color.lerp(
                                        unselectedColor,
                                        selectedColor,
                                        t,
                                      )!,
                                      size: 24,
                                    ),
                                    child: items.indexOf(item) == currentIndex
                                        ? item.activeIcon ?? item.icon
                                        : item.icon,
                                  ),
                                  ClipRect(
                                    clipBehavior: Clip.antiAlias,
                                    child: SizedBox(
                                      height: 20,
                                      child: Align(
                                        alignment: const Alignment(-0.2, 0),
                                        widthFactor: t,
                                        child: Padding(
                                          padding: Directionality.of(context) ==
                                                  TextDirection.ltr
                                              ? EdgeInsets.only(
                                                  left: itemPadding.left / 2,
                                                  right: itemPadding.right,
                                                )
                                              : EdgeInsets.only(
                                                  left: itemPadding.left,
                                                  right: itemPadding.right / 2,
                                                ),
                                          child: DefaultTextStyle(
                                            style: TextStyle(
                                              color: Color.lerp(
                                                selectedColor.withValues(
                                                  alpha: 0,
                                                ),
                                                selectedColor,
                                                t,
                                              ),
                                              fontWeight: FontWeight.w600,
                                            ),
                                            child: item.title,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: 800.ms,
        )
        .scale(
          duration: 3000.ms,
          begin: const Offset(1.1, 1.1),
          curve: Curves.elasticOut,
        )
        .slideY(
          duration: 3500.ms,
          begin: -0.5,
          curve: Curves.elasticOut,
        );
  }
}

/// Represents an item in the bottom navigation bar.
///
/// This class encapsulates all the properties needed to display
/// a single item in the application's bottom navigation bar.
class AppBottomBarItem {
  /// Creates an [AppBottomBarItem].
  ///
  /// The [icon] and [title] parameters must not be null.
  AppBottomBarItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.activeIcon,
  });

  /// The default icon to display when this item is not selected.
  final Widget icon;

  /// The icon to display when this item is selected.
  ///
  /// If null, the [icon] will be used for both selected and unselected states.
  final Widget? activeIcon;

  /// The text label to display for this item.
  final Widget title;

  /// The color to use when this item is selected.
  ///
  /// If null, defaults to the theme's primary color.
  final Color? selectedColor;

  /// The color to use when this item is not selected.
  ///
  /// If null, defaults to the theme's unselected item color.
  final Color? unselectedColor;
}
