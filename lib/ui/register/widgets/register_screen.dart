import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/domain/dtos/regiter_form_dto.dart';
import 'package:move_on_app/routing/router.gr.dart';
import 'package:move_on_app/ui/register/widgets/step_one.dart';
import 'package:move_on_app/ui/register/widgets/step_three.dart';
import 'package:move_on_app/ui/register/widgets/step_two.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template register_screen}
/// A screen that handles user registration functionality.
///
/// This screen provides a form interface for new users to create an account
/// by entering their:
/// * Email address
/// * Password
/// * Personal information
///
/// It includes:
/// * Input validation
/// * Error handling
/// * Registration submission
/// * Navigation to home screen upon successful registration
/// {@endtemplate}
@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int currentStep = 1;
  RegisterFormDTO form = RegisterFormDTO();
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: FTheme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: Column(
            spacing: 24,
            children: [
              _CustomStepper(
                currentStep: currentStep,
                maxStep: 3,
                onPop: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  currentStep--;
                  setState(() {});
                },
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    StepOne(form: form),
                    StepTwo(form: form),
                    StepThree(form: form),
                  ],
                ),
              ),
              FButton(
                label: const Text('Próximo'),
                onPress: () async {
                  if (currentStep == 1 &&
                      form.name != null &&
                      form.age != null &&
                      form.gender != null &&
                      form.height != null &&
                      form.weight != null) {
                    currentStep++;
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    setState(() {});

                    return;
                  }
                  // ignore: prefer_is_empty
                  if (currentStep == 2 && form.goal!.length > 0) {
                    currentStep++;
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    setState(() {});

                    return;
                  }
                  if (currentStep == 3) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('current_user', form.toJson());
                    const HomeRoute().navigate(context);
                    return;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A custom stepper widget used to display the progress of the onboarding steps.
class _CustomStepper extends StatelessWidget {
  const _CustomStepper({
    required this.currentStep,
    required this.maxStep,
    required this.onPop,
    this.height = 10,
    super.key,
    this.backgroundColor = Colors.black,
    this.stepColor,
    this.duration = const Duration(milliseconds: 500),
    this.gap = 4,
  })  : assert(currentStep > 0, 'CurrentStep deve ser maior que 0'),
        assert(
          maxStep >= currentStep,
          'MaxStep deve ser maior ou igual a CurrentStep',
        );

  final int currentStep;
  final Color backgroundColor;
  final Color? stepColor;
  final int maxStep;
  final double height;
  final Duration duration;
  final double gap;
  final VoidCallback onPop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        spacing: 8,
        children: [
          if (currentStep > 1)
            SizedBox(
              width: 14,
              child: GestureDetector(
                onTap: onPop,
                child: const Icon(Icons.arrow_back_ios),
              ),
            ),
          Expanded(
            flex: 12,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height),
                color: backgroundColor,
              ),
              padding: const EdgeInsets.all(2),
              child: Row(
                spacing: gap,
                children: [
                  ...List.generate(maxStep, (index) => index + 1).map((index) {
                    return Expanded(
                      child: Container(
                        height: height - 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(height),
                          color: index <= currentStep
                              ? stepColor ??
                                  FTheme.of(context).colorScheme.primary
                              : Colors.black,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              '${((currentStep * 100) / maxStep).truncate()}%',
              style: const TextStyle(
                height: 1,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
