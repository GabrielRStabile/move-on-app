import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/domain/dtos/regiter_form_dto.dart';
import 'package:move_on_app/ui/core/common_text_style.dart';

class StepTwo extends StatefulWidget {
  const StepTwo({required this.form, super.key});

  final RegisterFormDTO form;

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  late final RegisterFormDTO _form;

  @override
  void initState() {
    super.initState();
    _form = widget.form;
    _form.goal = [];
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: FTheme.of(context).colorScheme.background,
      child: Column(
        spacing: 18,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // stepper

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Aonde quer chegar?',
                style: CommonTextStyle.of(context).h1,
              ),
              const Text(
                'Saber seus objetivos nos ajuda a personalizar seu plano de treino',
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),

          ...Goal.values.map(
            (goal) => Container(
              height: 64,
              decoration: BoxDecoration(
                color: FTheme.of(context).colorScheme.background,
                border: Border.all(
                  color: FTheme.of(context).colorScheme.border,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 14,
                      children: [
                        FIcon(
                          goal.icon,
                          size: 24,
                        ),
                        Text(goal.friendlyName),
                      ],
                    ),
                    FCheckbox(
                      value: _form.goal!.contains(goal),
                      onChange: (value) {
                        if (value) {
                          _form.goal?.add(goal);
                        } else {
                          _form.goal?.remove(goal);
                        }

                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
