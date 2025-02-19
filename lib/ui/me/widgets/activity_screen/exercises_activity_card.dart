import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/data/services/workouts/progress_service.dart';
import 'package:move_on_app/di/dependency_injection.dart';
import 'package:move_on_app/domain/entities/exercise_entity.dart';
import 'package:move_on_app/ui/me/widgets/activity_screen/activity_card.dart';
import 'package:move_on_app/ui/me/widgets/task_small.dart';

class ExercisesActivityCard extends StatefulWidget {
  const ExercisesActivityCard({required this.date, super.key});

  final DateTime date;

  @override
  State<ExercisesActivityCard> createState() => _ExercisesActivityCardState();
}

class _ExercisesActivityCardState extends State<ExercisesActivityCard> {
  final progressService = di.get<IProgressService>();

  bool _isLoading = true;
  List<ExerciseEntity> _exercises = [];

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  @override
  void didUpdateWidget(covariant ExercisesActivityCard oldWidget) {
    if (oldWidget.date != widget.date) {
      setState(() {
        _isLoading = true;
        _exercises = [];
      });
      _loadExercises();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _loadExercises() async {
    final result = await progressService.getWorkoutByDate(widget.date);

    if (result == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    } else {
      setState(() {
        _exercises = result.exercises;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Widget loading = Center(child: CircularProgressIndicator());

    final content = _exercises.isEmpty
        ? const Center(child: Text('Nenhum treino feito nesse dia'))
        : ListView.builder(
            itemCount: _exercises.length,
            itemBuilder: (context, index) {
              return TaskSmall(
                exercise: _exercises[index],
              );
            },
          );

    return ActivityCard(
      icon: FIcon(FAssets.icons.dumbbell),
      title: const Text('Treinos do dia'),
      content: _isLoading ? loading : content,
      color: Colors.amber,
    );
  }
}
