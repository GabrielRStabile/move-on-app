import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:move_on_app/ui/me/widgets/activity_date_selection.dart';

/// {@template register_screen}
// TODO(GabrielRStabile): - Document this screen.
/// {@endtemplate}
@RoutePage()
class ActivityScreen extends StatelessWidget {
  /// {@macro register_screen}
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ActivityDateSelection(
              onDateSelected: (date) {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
