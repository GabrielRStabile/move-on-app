import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/domain/dtos/regiter_form_dto.dart';
import 'package:move_on_app/ui/core/common_text_style.dart';

class StepOne extends StatefulWidget {
  const StepOne({required this.form, super.key});

  final RegisterFormDTO form;

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  int? _calculatedAge;

  late final RegisterFormDTO _form;
  final _weightController = FPickerController(initialIndexes: [60]);
  final _heightController = FPickerController(initialIndexes: [110]);

  @override
  void initState() {
    super.initState();
    _form = widget.form;
    _form
      ..age = 20
      ..weight = 70
      ..height = 170;
  }

  int _calculateAge(DateTime date) {
    final now = DateTime.now();
    var age = now.year - date.year;
    if (now.month < date.month ||
        (now.month == date.month && now.day < date.day)) {
      age--;
    }
    _form.age = age;
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: FTheme.of(context).colorScheme.background,
      child: FTheme(
        data: FTheme.of(context).copyWith(
          textFieldStyle: FTheme.of(context).textFieldStyle.copyWith(
                enabledStyle: FTheme.of(context)
                    .textFieldStyle
                    .enabledStyle
                    .copyWith(
                      contentTextStyle: const TextStyle(color: Colors.black),
                    ),
              ),
        ),
        child: Column(
          spacing: 18,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // stepper

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá!',
                  style: CommonTextStyle.of(context).h1,
                ),
                const Text(
                  'Para montarmos um plano de treino personalizado precisamos saber mais sobre você',
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),

            FTextField(
              label: const Text('Como você quer ser chamado?'),
              // onSaved: (newValue) => {print("Email: $newValue")},
              hint: 'Maria José',
              onChange: (value) => _form.name = value,

              keyboardType: TextInputType.name,
              maxLines: 1,
            ),
            FTappable.animated(
              onPress: () {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => Container(
                    height: 216,
                    padding: const EdgeInsets.only(top: 6),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    color:
                        CupertinoColors.systemBackground.resolveFrom(context),
                    child: SafeArea(
                      top: false,
                      child: _DataPiker(
                        onDateSelected: (date) {
                          setState(() {
                            _calculatedAge = _calculateAge(date);
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
              child: FTextField(
                label: const Text('Quantos anos você tem?'),
                hint: '${_calculatedAge?.toString() ?? '20'} anos',
                ignorePointers: true,
                keyboardType: TextInputType.number,
                maxLines: 1,
              ),
            ),
            const Text(
              'Gênero:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _GenderRow(
              onChange: (value) => _form.gender = value,
            ),

            Row(
              spacing: 24,
              children: [
                Flexible(
                  child: Column(
                    spacing: 4.81,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Peso',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Flexible(
                            child: FTappable.animated(
                              onPress: () {
                                // Use modal bottom sheet for better UX
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (context) => Container(
                                    height: 300, // Fixed height for consistency
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  MediaQuery.sizeOf(context)
                                                          .width *
                                                      0.25,
                                            ),
                                            child: FPicker(
                                              controller: _weightController,
                                              children: [
                                                FPickerWheel.builder(
                                                  builder: (
                                                    context,
                                                    index,
                                                  ) =>
                                                      Text(
                                                    '${(index % 591) + 10} ',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                const Text('Kg'),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        FButton(
                                          onPress: () {
                                            _form.weight = _weightController
                                                    .wheels.first.selectedItem +
                                                10;
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          label: const Text('Confirmar'),
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: FTextField(
                                hint: '${_form.weight ?? 70}',
                                ignorePointers: true,
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          const Text('kg'),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    spacing: 4.81,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Altura',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Flexible(
                            child: FTappable.animated(
                              onPress: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (context) => Container(
                                    height: 300, // Fixed height for consistency
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  MediaQuery.sizeOf(context)
                                                          .width *
                                                      0.25,
                                            ),
                                            child: FPicker(
                                              controller: _heightController,
                                              children: [
                                                FPickerWheel.builder(
                                                  builder: (
                                                    context,
                                                    index,
                                                  ) =>
                                                      Text(
                                                    '${(index % 191) + 60} ',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                const Text('cm'),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        FButton(
                                          onPress: () {
                                            _form.height = _heightController
                                                    .wheels.first.selectedItem +
                                                60;
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          label: const Text('Confirmar'),
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: FTextField(
                                hint: '${_form.height ?? 170}',
                                ignorePointers: true,
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          const Text('cm'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GenderSelector extends StatelessWidget {
  const _GenderSelector({
    required this.gender,
    required this.isSelected,
    this.onTap,
  });

  final Gender gender;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 130,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: FTheme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: isSelected ? 3 : 1,
            color: isSelected
                ? FTheme.of(context).colorScheme.primary
                : FTheme.of(context).colorScheme.border,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            SvgPicture.asset(gender.icon, height: 50),
            Flexible(
              child: Text(
                gender.friendlyName,
                overflow: TextOverflow.ellipsis,
                style: CommonTextStyle.of(context).pUiMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenderRow extends StatefulWidget {
  const _GenderRow({required this.onChange, super.key});

  final ValueSetter<Gender> onChange;

  @override
  State<_GenderRow> createState() => _GenderRowState();
}

class _GenderRowState extends State<_GenderRow> {
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        ...Gender.values.map(
          (gender) => Expanded(
            child: _GenderSelector(
              gender: gender,
              isSelected: _selectedGender == gender,
              onTap: () {
                widget.onChange(gender);
                setState(() {
                  _selectedGender = gender;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _DataPiker extends StatefulWidget {
  const _DataPiker({required this.onDateSelected});
  final ValueChanged<DateTime> onDateSelected;

  @override
  State<_DataPiker> createState() => _DataPikerState();
}

class _DataPikerState extends State<_DataPiker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().subtract(const Duration(days: 365 * 20));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoDatePicker(
      initialDateTime: _selectedDate,
      mode: CupertinoDatePickerMode.date,
      use24hFormat: true,
      showDayOfWeek: true,
      onDateTimeChanged: (DateTime newDate) {
        setState(() => _selectedDate = newDate);
        widget.onDateSelected(newDate);
      },
    );
  }
}
