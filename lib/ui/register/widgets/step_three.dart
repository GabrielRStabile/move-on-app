import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/domain/dtos/register_form_dto.dart';
import 'package:move_on_app/ui/core/common_text_style.dart';

class StepThree extends StatefulWidget {
  const StepThree({required this.form, super.key});

  final RegisterFormDTO form;

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  late final RegisterFormDTO _form;
  ActiveLevel? _selectedLevel;

  @override
  void initState() {
    super.initState();
    _form = widget.form;
    _form.activeLevel = _selectedLevel = ActiveLevel.lightlyActive;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: FTheme.of(context).colorScheme.background,
      child: Column(
        spacing: 18,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Como você está hoje?',
                style: CommonTextStyle.of(context).h1,
              ),
              const Text(
                'Nos falando seu nível de atividade conseguimos construir um progresso linear sem muito esforço',
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
          ...ActiveLevel.values.map(
            (level) => Container(
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
                        SvgPicture.asset(level.icon),
                        Text(level.friendlyName),
                      ],
                    ),
                    FRadio(
                      value: _selectedLevel == level,
                      autofocus: true,
                      onChange: (value) {
                        if (value) {
                          _selectedLevel = level;
                          _form.activeLevel = level;
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
