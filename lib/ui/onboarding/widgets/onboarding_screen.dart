import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// {@template onboarding_screen}
/// A screen that displays the onboarding experience for new users.
///
/// The onboarding screen guides users through the main features and benefits
/// of the application when they first launch it. It typically contains:
/// * Welcome message
/// * Key feature highlights
/// * Getting started instructions
/// * Navigation controls to move between onboarding steps
/// {@endtemplate}
@RoutePage()
class OnboardingScreen extends StatelessWidget {
  /// {@macro onboarding_screen}
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
