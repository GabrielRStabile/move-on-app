import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/ui/core/assets.gen.dart';

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
class OnboardingScreen extends StatefulWidget {
  /// {@macro onboarding_screen}
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int step = 1;

  final List<Map<String, dynamic>> strings = [
    {
      'Text1': 'Em qualquer lugar, sua saúde deve ser prioridade',
      'Text2': 'Não existe uma fórmula mágica para ter uma vida saudável',
      'Image': Assets.images.onboardingStep1.image().image,
    },
    {
      'Text1': 'Cuide do seu corpo, transforme sua mente',
      'Text2': 'Pequenos passos hoje, grandes resultados amanhã.',
      'Image': Assets.images.onboardingStep2.image().image,
    },
    {
      'Text1': 'Treine no seu ritmo, sem complicações',
      'Text2': 'Exercícios simples para qualquer hora e lugar.',
      'Image': Assets.images.onboardingStep3.image().image,
    },
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   // Pré-carrega as imagens
  //   for (final item in strings) {
  //     precacheImage(item['Image'] as ImageProvider, context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: FTheme.of(context).colorScheme.background,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: Container(
                key: ValueKey<int>(step),
                foregroundDecoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: strings[step - 1]['Image'] as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    strings[step - 1]['Text1'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: FTheme.of(context).colorScheme.primaryForeground,
                      fontSize: FTheme.of(context).typography.xl2.fontSize,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 77),
                  child: Text(
                    strings[step - 1]['Text2'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: FTheme.of(context).colorScheme.mutedForeground,
                      fontSize: FTheme.of(context).typography.sm.fontSize,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 157),
                  child: _CustomStepper(
                    currentStep: step,
                    maxStep: strings.length,
                    backgroundColor:
                        FTheme.of(context).colorScheme.primaryForeground,
                    stepColor: FTheme.of(context).colorScheme.primary,
                    height: 5,
                  ),
                ),
                SizedBox(
                  width: 350,
                  height: 56,
                  child: FButton(
                    style: FButtonStyle.secondary,
                    label: Text(step != 3 ? 'Próximo' : 'Continue'),
                    onPress: () {
                      setState(() {
                        if (step < strings.length) {
                          step++;
                        }
                 
                      });
                    },
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
/// A custom stepper widget used to display the progress of the onboarding steps.
class _CustomStepper extends StatelessWidget {
  const _CustomStepper({
    required this.currentStep,
    required this.maxStep,
    this.height = 10,
    super.key,
    this.backgroundColor = Colors.black,
    this.stepColor = Colors.white,
    this.duration = const Duration(milliseconds: 500),
  })  : assert(currentStep > 0, 'CurrentStep deve ser maior que 0'),
        assert(
          maxStep >= currentStep,
          'MaxStep deve ser maior ou igual a CurrentStep',
        );

  final int currentStep;
  final Color backgroundColor;
  final Color stepColor;
  final int maxStep;
  final double height;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.all(2),
        width: constraints.maxWidth,
        child: Stack(
          children: [
            AnimatedSlide(
              duration: duration,
              offset: Offset(currentStep.toDouble() - 1, 0),
              child: Container(
                height: height - 2,
                width: (constraints.maxWidth / maxStep) - 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height),
                  color: stepColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
